---@diagnostic disable: lowercase-global, undefined-global, deprecated
local menu = require("oop_menu")

if not MENU_LIB_ERROR_OUTDATED then
    return error("outdated library")
elseif MENU_LIB_VER ~= 1 then
    return MENU_LIB_ERROR_OUTDATED()
end

local script_name = "PIZDA_NOGAM"

local hitgroup_str = {
    [0] = 'generic',
    'head', 'chest', 'stomach',
    'left arm', 'right arm',
    'left leg', 'right leg',
    'neck', 'generic', 'gear'
}

local logs_data = {}
local w, h = render.get_screen_size()
local verdana = render.create_font("verdana.ttf", 11, render.font_flag_shadow)
local verdanab = render.create_font("verdanab.ttf", 11, render.font_flag_shadow)

local r_3dsky = cvar.r_3dsky
local r_aspectratio = cvar.r_aspectratio
local mat_fullbright = cvar.mat_fullbright
local cl_csm_rot_ovr = cvar.cl_csm_rot_override
local cl_csm_rot_x = cvar.cl_csm_rot_x
local cl_csm_rot_y = cvar.cl_csm_rot_y
local cl_csm_rot_z = cvar.cl_csm_rot_z
local fog_ovr = cvar.fog_override
local fog_color = cvar.fog_color
local fog_maxdensity = cvar.fog_maxdensity
local fog_start = cvar.fog_start
local fog_end = cvar.fog_end

local aa_place = "rage>anti-aim>angles"
local aa_desync = "rage>anti-aim>desync"

local aa_states = { "standing", "moving", "in air", "in air duck", "ducking", "slowwalking" }
local add_types = { "none", "static", "3-way", "slow jitter" }
local dsy_types = { "none", "static", "3-way", "slow jitter" }
local def_pitch_t = { "down", "half down", "zero", "half up", "up", "jitter half up/half down", "jitter up/down", "custom" }
local def_yaw_t = { "180 jitter", "spin" }
local fs_types = { "none", "peek desync", "peek real" }

local ui = {
    tabs = menu.add_listbox("", "lua>tab a", 3, false, { "~ ragebot", "~ visuals", "~ misc" }),

    name = menu.add_listbox("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", "lua>tab a", 1, false, { "                 PIZDA_NOGAM", "anti-aim builder is in rage>anti-aim" }),

    aa_cond = menu.add_combo("[PIZDANOGAM] condition", aa_place, aa_states),

    legitaa = menu.add_checkbox("legit aa", aa_place),

    st_yaw_add = menu.add_combo("yaw add ", aa_place, add_types),
    mv_yaw_add = menu.add_combo("yaw add  ", aa_place, add_types),
    ai_yaw_add = menu.add_combo("yaw add   ", aa_place, add_types),
    ad_yaw_add = menu.add_combo("yaw add    ", aa_place, add_types),
    dc_yaw_add = menu.add_combo("yaw add     ", aa_place, add_types),
    sw_yaw_add = menu.add_combo("yaw add      ", aa_place, add_types),
    st_add = menu.add_slider("add ", aa_place, -180, 180, 1),
    mv_add = menu.add_slider("add  ", aa_place, -180, 180, 1),
    ai_add = menu.add_slider("add   ", aa_place, -180, 180, 1),
    ad_add = menu.add_slider("add    ", aa_place, -180, 180, 1),
    dc_add = menu.add_slider("add     ", aa_place, -180, 180, 1),
    sw_add = menu.add_slider("add      ", aa_place, -180, 180, 1),
    st_at_target = menu.add_checkbox("yaw at target", aa_place),
    mv_at_target = menu.add_checkbox("yaw at target ", aa_place),
    ai_at_target = menu.add_checkbox("yaw at target  ", aa_place),
    ad_at_target = menu.add_checkbox("yaw at target   ", aa_place),
    dc_at_target = menu.add_checkbox("yaw at target    ", aa_place),
    sw_at_target = menu.add_checkbox("yaw at target     ", aa_place),
    st_spin = menu.add_checkbox("spin ", aa_place),
    mv_spin = menu.add_checkbox("spin  ", aa_place),
    ai_spin = menu.add_checkbox("spin   ", aa_place),
    ad_spin = menu.add_checkbox("spin    ", aa_place),
    dc_spin = menu.add_checkbox("spin     ", aa_place),
    sw_spin = menu.add_checkbox("spin      ", aa_place),
    st_spin_range = menu.add_slider("spin range ", aa_place, 0, 180, 1),
    mv_spin_range = menu.add_slider("spin range  ", aa_place, 0, 180, 1),
    ai_spin_range = menu.add_slider("spin range   ", aa_place, 0, 180, 1),
    ad_spin_range = menu.add_slider("spin range    ", aa_place, 0, 180, 1),
    dc_spin_range = menu.add_slider("spin range     ", aa_place, 0, 180, 1),
    sw_spin_range = menu.add_slider("spin range      ", aa_place, 0, 180, 1),
    st_spin_speed = menu.add_slider("spin speed ", aa_place, 0, 180, 1),
    mv_spin_speed = menu.add_slider("spin speed  ", aa_place, 0, 180, 1),
    ai_spin_speed = menu.add_slider("spin speed   ", aa_place, 0, 180, 1),
    ad_spin_speed = menu.add_slider("spin speed    ", aa_place, 0, 180, 1),
    dc_spin_speed = menu.add_slider("spin speed     ", aa_place, 0, 180, 1),
    sw_spin_speed = menu.add_slider("spin speed      ", aa_place, 0, 180, 1),
    st_jit = menu.add_checkbox("jitter ", aa_place),
    mv_jit = menu.add_checkbox("jitter  ", aa_place),
    ai_jit = menu.add_checkbox("jitter   ", aa_place),
    ad_jit = menu.add_checkbox("jitter    ", aa_place),
    dc_jit = menu.add_checkbox("jitter     ", aa_place),
    sw_jit = menu.add_checkbox("jitter      ", aa_place),
    st_jit_range = menu.add_slider("jitter range ", aa_place, 0, 180, 1),
    mv_jit_range = menu.add_slider("jitter range  ", aa_place, 0, 180, 1),
    ai_jit_range = menu.add_slider("jitter range   ", aa_place, 0, 180, 1),
    ad_jit_range = menu.add_slider("jitter range    ", aa_place, 0, 180, 1),
    dc_jit_range = menu.add_slider("jitter range     ", aa_place, 0, 180, 1),
    sw_jit_range = menu.add_slider("jitter range      ", aa_place, 0, 180, 1),
    st_jit_rnd = menu.add_checkbox("random ", aa_place),
    mv_jit_rnd = menu.add_checkbox("random  ", aa_place),
    ai_jit_rnd = menu.add_checkbox("random   ", aa_place),
    ad_jit_rnd = menu.add_checkbox("random    ", aa_place),
    dc_jit_rnd = menu.add_checkbox("random     ", aa_place),
    sw_jit_rnd = menu.add_checkbox("random      ", aa_place),

    defensive_aa = menu.add_checkbox("defensive aa", aa_place),
    def_pitch = menu.add_combo("pitch type", aa_place, def_pitch_t),
    def_custom_pitch = menu.add_slider("custom pitch", aa_place, -89, 89, 1),
    def_type = menu.add_combo("yaw type", aa_place, def_yaw_t),
    def_delay = menu.add_slider("ticks to flick", aa_place, 1, 16, 1),

    jit_dis = menu.add_multi_combo("jitter disablers", aa_place, { "on freestand", "on manual aa" }),
    aa_manual = menu.add_checkbox("anti-aim override", aa_place),
    left = menu.add_checkbox("left ", aa_place),
    back = menu.add_checkbox("back ", aa_place),
    right = menu.add_checkbox("right ", aa_place),
    fs = menu.add_checkbox("freestand ", aa_place),
    st_dsy = menu.add_combo("desync ", aa_desync, dsy_types),
    mv_dsy = menu.add_combo("desync  ", aa_desync, dsy_types),
    ai_dsy = menu.add_combo("desync   ", aa_desync, dsy_types),
    ad_dsy = menu.add_combo("desync    ", aa_desync, dsy_types),
    dc_dsy = menu.add_combo("desync     ", aa_desync, dsy_types),
    sw_dsy = menu.add_combo("desync      ", aa_desync, dsy_types),
    st_dsy_amt = menu.add_slider("desync amount ", aa_desync, -100, 100, 1),
    mv_dsy_amt = menu.add_slider("desync amount  ", aa_desync, -100, 100, 1),
    ai_dsy_amt = menu.add_slider("desync amount   ", aa_desync, -100, 100, 1),
    ad_dsy_amt = menu.add_slider("desync amount    ", aa_desync, -100, 100, 1),
    dc_dsy_amt = menu.add_slider("desync amount     ", aa_desync, -100, 100, 1),
    sw_dsy_amt = menu.add_slider("desync amount      ", aa_desync, -100, 100, 1),
    st_dsy_fs = menu.add_combo("freestand desync", aa_desync, fs_types),
    mv_dsy_fs = menu.add_combo("freestand desync ", aa_desync, fs_types),
    ai_dsy_fs = menu.add_combo("freestand desync  ", aa_desync, fs_types),
    ad_dsy_fs = menu.add_combo("freestand desync   ", aa_desync, fs_types),
    dc_dsy_fs = menu.add_combo("freestand desync    ", aa_desync, fs_types),
    sw_dsy_fs = menu.add_combo("freestand desync     ", aa_desync, fs_types),
    st_dsy_jit = menu.add_checkbox("switch desync with jitter ", aa_desync),
    mv_dsy_jit = menu.add_checkbox("switch desync with jitter  ", aa_desync),
    ai_dsy_jit = menu.add_checkbox("switch desync with jitter   ", aa_desync),
    ad_dsy_jit = menu.add_checkbox("switch desync with jitter    ", aa_desync),
    dc_dsy_jit = menu.add_checkbox("switch desync with jitter     ", aa_desync),
    sw_dsy_jit = menu.add_checkbox("switch desync with jitter      ", aa_desync),

    da_ovr = menu.add_checkbox("dormant aimbot override", "lua>tab b"),
    fl_ovr = menu.add_multi_combo("disable fakelag on", "lua>tab b", { "double tap", "hide shots" }),

    inds = menu.add_multi_combo("windows", "lua>tab b", { "inds under crosshair", "logs under crosshair", "manual aa indication" }),
    ind_first = menu.add_colorpicker("lua>tab b>windows", true, render.color(200, 220, 255, 255)),
    ind_second = menu.add_colorpicker("lua>tab b>windows", true, render.color(160, 200, 230, 160)),
    log_offset = menu.add_slider("logs y", "lua>tab b", 0, h / 2 - 160, 1),
    removals = menu.add_multi_combo("visual removals", "lua>tab b", { "3d skybox", "lighting" }),

    sunset = menu.add_checkbox("sunset", "lua>tab b"),
    sunset_x = menu.add_slider("direction x", "lua>tab b", -100, 100, 1),
    sunset_y = menu.add_slider("direction y", "lua>tab b", -100, 100, 1),
    sunset_z = menu.add_slider("direction z", "lua>tab b", -100, 100, 1),

    fog = menu.add_checkbox("world fog", "lua>tab b"),
    fog_col = menu.add_colorpicker("lua>tab b>world fog", false, render.color(255, 255, 255, 100)),
    fog_start = menu.add_slider("start", "lua>tab b", 0, 2500, 1),
    fog_end = menu.add_slider("end", "lua>tab b", 0, 2500, 1),
    fog_strength = menu.add_slider("density", "lua>tab b", 0, 100, 1),
    
    ratio = menu.add_slider("aspect ratio", "lua>tab b", 0, 200, 1),

    animchangers = menu.add_checkbox("animation modifiers", "lua>tab b"),
    leg_movement = menu.add_combo("leg movement type", "lua>tab b", { "default", "jitter", "random", "moonwalk", "no animation" }),
    falling_anim = menu.add_combo("falling animation style", "lua>tab b", { "default", "static" }),
    lean = menu.add_combo("lean yaw style", "lua>tab b", { "default", "random" })
}

local dt_ref = menu.get_reference("rage>aimbot>aimbot>double tap")
local hs_ref = menu.get_reference("rage>aimbot>aimbot>hide shot")
local fs_ref = menu.get_reference("rage>anti-aim>angles>freestand")
local md_ref = menu.get_reference("rage>aimbot>ssg08>scout>override")
local ba_ref = menu.get_reference("rage>aimbot>aimbot>force extra safety")
local sw_ref = menu.get_reference("misc>movement>slide")
local left_ref = menu.get_reference("rage>anti-aim>angles>left")
local back_ref = menu.get_reference("rage>anti-aim>angles>back")
local right_ref = menu.get_reference("rage>anti-aim>angles>right")
local da_ref = menu.get_reference("rage>aimbot>aimbot>target dormant")

local aa_check_ref = menu.get_reference("rage>anti-aim>angles>anti-aim")
local aa_pitch_ref = menu.get_reference("rage>anti-aim>angles>pitch")
local aa_yaw_ref = menu.get_reference("rage>anti-aim>angles>yaw")
local aa_at_target_ref = menu.get_reference("rage>anti-aim>angles>at fov target")
local aa_yaw_add_ref = menu.get_reference("rage>anti-aim>angles>yaw add")
local aa_add_ref = menu.get_reference("rage>anti-aim>angles>add")
local aa_spin_ref = menu.get_reference("rage>anti-aim>angles>spin")
local aa_spin_range_ref = menu.get_reference("rage>anti-aim>angles>spin range")
local aa_spin_speed_ref = menu.get_reference("rage>anti-aim>angles>spin speed")
local aa_jit_ref = menu.get_reference("rage>anti-aim>angles>jitter")
local aa_jit_range_ref = menu.get_reference("rage>anti-aim>angles>jitter range")
local aa_jit_rnd_ref = menu.get_reference("rage>anti-aim>angles>random")
local aa_manual_ref = menu.get_reference("rage>anti-aim>angles>antiaim override")
local aa_dsy_ref = menu.get_reference("rage>anti-aim>desync>fake")
local aa_dsy_amt_ref = menu.get_reference("rage>anti-aim>desync>fake amount")
local aa_dsy_comp_ref = menu.get_reference("rage>anti-aim>desync>compensate angle")
local aa_dsy_fs_ref = menu.get_reference("rage>anti-aim>desync>freestand fake")
local aa_dsy_jit_ref = menu.get_reference("rage>anti-aim>desync>flip fake with jitter")
local aa_roll_ref = menu.get_reference("rage>anti-aim>desync>roll lean")
local aa_roll_walk_ref = menu.get_reference("rage>anti-aim>desync>ensure lean")
local aa_roll_flip_ref = menu.get_reference("rage>anti-aim>desync>flip lean with jitter")
local aa_fakelag_ref = menu.get_reference("rage>anti-aim>fakelag>limit")
local aa_leg_ref = menu.get_reference("rage>anti-aim>desync>leg slide")

aa_manual_ref:set_visible(false)
left_ref:set_visible(false)
back_ref:set_visible(false)
right_ref:set_visible(false)
fs_ref:set_visible(false)
aa_at_target_ref:set_visible(false)
aa_yaw_add_ref:set_visible(false)
aa_add_ref:set_visible(false)
aa_spin_ref:set_visible(false)
aa_spin_range_ref:set_visible(false)
aa_spin_speed_ref:set_visible(false)
aa_jit_ref:set_visible(false)
aa_jit_range_ref:set_visible(false)
aa_jit_rnd_ref:set_visible(false)
aa_dsy_ref:set_visible(false)
aa_dsy_amt_ref:set_visible(false)
aa_dsy_comp_ref:set_visible(false)
aa_dsy_fs_ref:set_visible(false)
aa_dsy_jit_ref:set_visible(false)
aa_roll_ref:set_visible(false)
aa_roll_walk_ref:set_visible(false)
aa_roll_flip_ref:set_visible(false)

menu.add_keybind(ui.left)
menu.add_keybind(ui.back)
menu.add_keybind(ui.right)
menu.add_keybind(ui.fs)
menu.add_keybind(ui.da_ovr)
menu.add_keybind(ui.legitaa)

aa_manual_ref:bind_to(ui.aa_manual)
left_ref:bind_to(ui.left)
back_ref:bind_to(ui.back)
right_ref:bind_to(ui.right)
fs_ref:bind_to(ui.fs)

local on_ground_ticks = 0

local sigs = {
    get_pose_params = {"client.dll", "55 8B EC 8B 45 08 57 8B F9 8B 4F 04 85 C9 75 15"}
}

local offsets = {
    animstate = 0x9960,
    m_pStudioHdr = 0x2950,
    landing_anim = 0x109,
}

function bool_to_int(v)
    return v and 1 or 0
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function mix(first, second, amt)
    return {
        lerp(first.r, second.r, amt),
        lerp(first.g, second.g, amt),
        lerp(first.b, second.b, amt),
        lerp(first.a, second.a, amt),
    }
end

function text_multicolor(data, x, y, font, alphamod)
    local textp = 0
    local totaltext = ""
    for k,v in pairs(data) do
        totaltext = totaltext .. v.text
    end
    local ttx = {}
        ttx.x,ttx.y = render.get_text_size(font, totaltext)
    for k,v in pairs(data) do
        if alphamod then
            v.clr.a = alphamod
        end
        render.text(font, x+textp-ttx.x/2,y,v.text,v.clr)
        textp = textp + render.get_text_size(font,v.text)
    end
end

local bind_argument = function(fn, arg)
    return function(...)
        return fn(arg, ...)
    end
end

local interface_type = ffi.typeof("uintptr_t**")

local i_client_entity_list = ffi.cast(interface_type, utils.find_interface("client.dll", "VClientEntityList003"))
local get_client_entity = bind_argument(ffi.cast("void*(__thiscall*)(void*, int)", i_client_entity_list[0][3]), i_client_entity_list)

local get_pose_parameters = ffi.cast( "struct {char pad[8]; float m_flStart; float m_flEnd; float m_flState;}*(__thiscall* )( void*, int )", utils.find_pattern(unpack(sigs.get_pose_params)))

local cache = {}

local set_layer = function(player_ptr, layer, start_val, end_val)

    player_ptr = ffi.cast("unsigned int", player_ptr)

    if player_ptr == 0x0 then
        return false
    end

    local studio_hdr = ffi.cast("void**", player_ptr + offsets.m_pStudioHdr)[0]

    if studio_hdr == nil then
        return false
    end

    local pose_params = get_pose_parameters(studio_hdr, layer)

    if pose_params == nil then
        return
    end

    if cache[layer] == nil then
        cache[layer] = {}

        cache[layer].m_flStart = pose_params.m_flStart
        cache[layer].m_flEnd = pose_params.m_flEnd

        cache[layer].m_flState = pose_params.m_flState

        cache[layer].installed = false
        return true
    end

    if start_val ~= nil and not cache[layer].installed then
        pose_params.m_flStart   = start_val
        pose_params.m_flEnd     = end_val

        pose_params.m_flState   = (pose_params.m_flStart + pose_params.m_flEnd) / 2

        cache[layer].installed = true
        return true
    end
    
    if cache[layer].installed then
        pose_params.m_flStart   = cache[layer].m_flStart
        pose_params.m_flEnd     = cache[layer].m_flEnd

        pose_params.m_flState   = cache[layer].m_flState

        cache[layer].installed = false

        return true
    end

    return false
end

local jittering = false
local setup = function(cmd)
    local lp = entities[engine.get_local_player()]
    local local_player = get_client_entity(engine.get_local_player())

    if local_player == nil or lp:is_alive() == false or engine.is_in_game() == false then
        return
    end

    local animstate = ffi.cast( "void**", ffi.cast("unsigned int", local_player) + offsets.animstate)[0]

    if animstate == nil then
        return
    end

    animstate = ffi.cast("unsigned int", animstate)

    if animstate == 0x0 then
        return
    end

    for k, _ in pairs(cache) do
        set_layer(local_player, k)
    end

    local random = utils.random_float(-180, 180)

    if (ui.leg_movement:get() == 4 and ui.animchangers:get()) then
        set_layer(local_player, 8, 0, 0.001)
        set_layer(local_player, 9, 0, 0.001)
        set_layer(local_player, 10, 0, 0.001)
        aa_leg_ref:set(1)
    elseif (ui.leg_movement:get() == 3 and ui.animchangers:get()) then
        set_layer(local_player, 7, 0, 0.001)
        aa_leg_ref:set(1)
    elseif (ui.leg_movement:get() == 2 and ui.animchangers:get()) then
        set_layer(local_player, 0, random, random)
        aa_leg_ref:set(2)
    elseif (ui.leg_movement:get() == 1 and ui.animchangers:get()) then
        set_layer(local_player, 0, jittering and -180 or 160, jittering and 180 or -160)
        aa_leg_ref:set(2)
    else
        set_layer(local_player, 0, -180, 180)
    end

    jittering = not jittering

    if (ui.lean:get() == 1 and ui.animchangers:get()) then
        set_layer(local_player, 2, random, random)
    else
        set_layer(local_player, 2, -180, 180)
    end
    
    if (ui.falling_anim:get() == 1 and ui.animchangers:get()) then
        set_layer(local_player, 6, 0.9, 1)
    end
end

local on_destroy = function()
    local local_player = get_client_entity(engine.get_local_player())

    if local_player == nil then
        return
    end

    for k, _ in pairs(cache) do
        set_layer(local_player, k)
    end

end

local legit_aa = 0; local defensive = 0; local spin = -180;
function antiaim()
    local local_player = entities.get_entity(engine.get_local_player())

    if local_player == nil then
        return
    end

    local is_defusing = local_player:get_prop("m_bIsDefusing")

    if (is_defusing) then
        aa_yaw_add_ref:set(0)
        aa_spin_ref:set(0)
        aa_jit_ref:set(0)
        aa_dsy_ref:set(0)
        return
    else
        aa_check_ref:set(1)
    end

    if (ui.legitaa:get() and not is_defusing) then
        if (legit_aa < 2) then
            legit_aa = legit_aa + 1
            return
        end

        engine.exec("-use")
        aa_pitch_ref:set(0)
        aa_yaw_ref:set(0)
        aa_at_target_ref:set(0)
        aa_yaw_add_ref:set(0)
        aa_spin_ref:set(0)
        aa_jit_ref:set(0)
        aa_dsy_ref:set(1)
        aa_dsy_amt_ref:set(-100)
        aa_dsy_jit_ref:set(0)
        aa_dsy_fs_ref:set(1)
        return
    else
        legit_aa = 0
        aa_pitch_ref:set(1)
        aa_yaw_ref:set(1)
    end

    local duckamt = local_player:get_prop("m_flDuckAmount")
    local jumping = local_player:get_prop("m_hGroundEntity") == -1
    local walking = sw_ref:get() == 1

    local vel = math.sqrt(local_player:get_prop("m_vecVelocity[0]") * local_player:get_prop("m_vecVelocity[0]") + local_player:get_prop("m_vecVelocity[1]") * local_player:get_prop("m_vecVelocity[1]"))

    if (defensive > 0 and ui.defensive_aa:get() and dt_ref:get() == 1 and hs_ref:get() == 0) then
        if spin > 170 then
            spin = -180
        end

        aa_pitch_ref:set(3)
        aa_yaw_add_ref:set(1)
        aa_add_ref:set(ui.def_type:get() == 1 and spin or 180)
        aa_spin_ref:set(false)
        aa_jit_ref:set(ui.def_type:get() == 1 and 0 or 1)
        aa_jit_range_ref:set(140)
        aa_dsy_ref:set(true)
        aa_dsy_amt_ref:set(-100)
        aa_dsy_jit_ref:set(false)
        aa_dsy_fs_ref:set(2)

        spin = spin + 20
        return
    end

    if ((ui.jit_dis:get()[1] and fs_ref:get() == 1) or (ui.jit_dis:get()[2] and (left_ref:get() == 1 or back_ref:get() == 1 or right_ref:get() == 1))) then
        aa_at_target_ref:set(1)
        aa_yaw_add_ref:set(0)
        aa_spin_ref:set(0)
        aa_jit_ref:set(0)
        aa_dsy_ref:set(1)
        aa_dsy_amt_ref:set(-100)
        aa_dsy_jit_ref:set(0)
        aa_dsy_fs_ref:set(2)
        return
    end

    local tickcount = math.floor(global_vars.tickcount % 6 / 2)
    local slowjitter = math.floor(global_vars.tickcount % 8 / 4) * 2

    if (jumping and duckamt > 0.5) then
        aa_at_target_ref:set(ui.ad_at_target:get())
        aa_yaw_add_ref:set(ui.ad_yaw_add:get() > 0 and true or false)
        if (ui.ad_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.ad_add:get() + (ui.ad_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.ad_yaw_add:get() == 2 and (-ui.ad_add:get() + (ui.ad_add:get() * tickcount)) or (ui.ad_add:get()))
        end
        aa_spin_ref:set(ui.ad_spin:get())
        aa_spin_range_ref:set(ui.ad_spin_range:get())
        aa_spin_speed_ref:set(ui.ad_spin_speed:get())
        aa_jit_ref:set(ui.ad_jit:get())
        aa_jit_range_ref:set(ui.ad_jit_range:get())
        aa_jit_rnd_ref:set(ui.ad_jit_rnd:get())
        aa_dsy_ref:set(ui.ad_dsy:get() > 0 and true or false)
        if (ui.ad_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.ad_dsy:get() > 1) and -ui.ad_dsy_amt:get() or ui.ad_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.ad_dsy:get() > 1) and -ui.ad_dsy_amt:get() or ui.ad_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.ad_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.ad_dsy_jit:get())
    elseif (jumping) then
        aa_at_target_ref:set(ui.ai_at_target:get())
        aa_yaw_add_ref:set(ui.ai_yaw_add:get() > 0 and true or false)
        if (ui.ai_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.ai_add:get() + (ui.ai_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.ai_yaw_add:get() == 2 and (-ui.ai_add:get() + (ui.ai_add:get() * tickcount)) or (ui.ai_add:get()))
        end
        aa_spin_ref:set(ui.ai_spin:get())
        aa_spin_range_ref:set(ui.ai_spin_range:get())
        aa_spin_speed_ref:set(ui.ai_spin_speed:get())
        aa_jit_ref:set(ui.ai_jit:get())
        aa_jit_range_ref:set(ui.ai_jit_range:get())
        aa_jit_rnd_ref:set(ui.ai_jit_rnd:get())
        aa_dsy_ref:set(ui.ai_dsy:get() > 0 and true or false)
        if (ui.ai_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.ai_dsy:get() > 1) and -ui.ai_dsy_amt:get() or ui.ai_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.ai_dsy:get() > 1) and -ui.ai_dsy_amt:get() or ui.ai_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.ai_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.ai_dsy_jit:get())
    elseif (walking and vel > 5) then
        aa_at_target_ref:set(ui.sw_at_target:get())
        aa_yaw_add_ref:set(ui.sw_yaw_add:get() > 0 and true or false)
        if (ui.sw_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.sw_add:get() + (ui.sw_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.sw_yaw_add:get() == 2 and (-ui.sw_add:get() + (ui.sw_add:get() * tickcount)) or (ui.sw_add:get()))
        end
        aa_spin_ref:set(ui.sw_spin:get())
        aa_spin_range_ref:set(ui.sw_spin_range:get())
        aa_spin_speed_ref:set(ui.sw_spin_speed:get())
        aa_jit_ref:set(ui.sw_jit:get())
        aa_jit_range_ref:set(ui.sw_jit_range:get())
        aa_jit_rnd_ref:set(ui.sw_jit_rnd:get())
        aa_dsy_ref:set(ui.sw_dsy:get() > 0 and true or false)
        if (ui.sw_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.sw_dsy:get() > 1) and -ui.sw_dsy_amt:get() or ui.sw_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.sw_dsy:get() > 1) and -ui.sw_dsy_amt:get() or ui.sw_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.sw_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.sw_dsy_jit:get())
    elseif (duckamt > 0.5) then
        aa_at_target_ref:set(ui.dc_at_target:get())
        aa_yaw_add_ref:set(ui.dc_yaw_add:get() > 0 and true or false)
        if (ui.dc_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.dc_add:get() + (ui.dc_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.dc_yaw_add:get() == 2 and (-ui.dc_add:get() + (ui.dc_add:get() * tickcount)) or (ui.dc_add:get()))
        end
        aa_spin_ref:set(ui.dc_spin:get())
        aa_spin_range_ref:set(ui.dc_spin_range:get())
        aa_spin_speed_ref:set(ui.dc_spin_speed:get())
        aa_jit_ref:set(ui.dc_jit:get())
        aa_jit_range_ref:set(ui.dc_jit_range:get())
        aa_jit_rnd_ref:set(ui.dc_jit_rnd:get())
        aa_dsy_ref:set(ui.dc_dsy:get() > 0 and true or false)
        if (ui.dc_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.dc_dsy:get() > 1) and -ui.dc_dsy_amt:get() or ui.dc_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.dc_dsy:get() > 1) and -ui.dc_dsy_amt:get() or ui.dc_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.dc_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.dc_dsy_jit:get())
    elseif (vel < 5) then
        aa_at_target_ref:set(ui.st_at_target:get())
        aa_yaw_add_ref:set(ui.st_yaw_add:get() > 0 and true or false)
        if (ui.st_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.st_add:get() + (ui.st_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.st_yaw_add:get() == 2 and (-ui.st_add:get() + (ui.st_add:get() * tickcount)) or (ui.st_add:get()))
        end
        aa_spin_ref:set(ui.st_spin:get())
        aa_spin_range_ref:set(ui.st_spin_range:get())
        aa_spin_speed_ref:set(ui.st_spin_speed:get())
        aa_jit_ref:set(ui.st_jit:get())
        aa_jit_range_ref:set(ui.st_jit_range:get())
        aa_jit_rnd_ref:set(ui.st_jit_rnd:get())
        aa_dsy_ref:set(ui.st_dsy:get() > 0 and true or false)
        if (ui.st_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.st_dsy:get() > 1) and -ui.st_dsy_amt:get() or ui.st_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.st_dsy:get() > 1) and -ui.st_dsy_amt:get() or ui.st_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.st_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.st_dsy_jit:get())
    else
        aa_at_target_ref:set(ui.mv_at_target:get())
        aa_yaw_add_ref:set(ui.mv_yaw_add:get() > 0 and true or false)
        if (ui.mv_yaw_add:get() > 2) then
            aa_add_ref:set(-ui.mv_add:get() + (ui.mv_add:get() * slowjitter))
        else
            aa_add_ref:set(ui.mv_yaw_add:get() == 2 and (-ui.mv_add:get() + (ui.mv_add:get() * tickcount)) or (ui.mv_add:get()))
        end
        aa_spin_ref:set(ui.mv_spin:get())
        aa_spin_range_ref:set(ui.mv_spin_range:get())
        aa_spin_speed_ref:set(ui.mv_spin_speed:get())
        aa_jit_ref:set(ui.mv_jit:get())
        aa_jit_range_ref:set(ui.mv_jit_range:get())
        aa_jit_rnd_ref:set(ui.mv_jit_rnd:get())
        aa_dsy_ref:set(ui.mv_dsy:get() > 0 and true or false)
        if (ui.mv_dsy:get() > 2) then
            aa_dsy_amt_ref:set((slowjitter > 0 and ui.mv_dsy:get() > 1) and -ui.mv_dsy_amt:get() or ui.mv_dsy_amt:get())
        else
            aa_dsy_amt_ref:set((tickcount > 1 and ui.mv_dsy:get() > 1) and -ui.mv_dsy_amt:get() or ui.mv_dsy_amt:get())
        end
        aa_dsy_fs_ref:set(ui.mv_dsy_fs:get())
        aa_dsy_jit_ref:set(ui.mv_dsy_jit:get())
    end
end

local highest_tickbase = 0
function on_create_move()
    setup()

    local local_player = entities.get_entity(engine.get_local_player())
    if local_player == nil then
        return
    end

    local local_player = entities.get_entity(engine.get_local_player())

    if local_player == nil then
        return
    end

    if ui.defensive_aa:get() then
        local tickbase = local_player:get_prop("m_nTickBase")

        if (tickbase > highest_tickbase) then
            highest_tickbase = tickbase
            if defensive > 0 and defensive < ui.def_delay:get() + 1 then
                defensive = defensive + 1
            elseif defensive > ui.def_delay:get() then
                defensive = 0
            end
        else
            defensive = 1
        end
    end

    local on_ground = bit.band(local_player:get_prop("m_fFlags"),1)
    if on_ground == 1 then
        on_ground_ticks = on_ground_ticks + 1
    else
        on_ground_ticks = 0
    end

    if (ui.fl_ovr:get()[1] and dt_ref:get() == 1) or (ui.fl_ovr:get()[2] and hs_ref:get() == 1) then
        aa_fakelag_ref:set(1)
    else
        aa_fakelag_ref:set(14)
    end

    antiaim()
end

function get_button(cmd, button)
    return bit.band(cmd:get_buttons(), button) ~= 0
end

local pitch_jit = false
function on_run_command(cmd)
    if not ui.defensive_aa:get() then
        return
    end

    local view_angles_x, view_angles_y = cmd:get_view_angles()

    local in_attack = get_button(cmd, csgo.in_attack)
    local pitch = ui.def_pitch:get()

    if pitch == 0 then
        pitch = 89
    elseif pitch == 1 then
        pitch = 45
    elseif pitch == 2 then
        pitch = 0
    elseif pitch == 3 then
        pitch = -45
    elseif pitch == 4 then
        pitch = -89
    elseif pitch == 5 then
        if pitch_jit then
            pitch = -45
        else
            pitch = 45
        end
    elseif pitch == 6 then
        if pitch_jit then
            pitch = -89
        else
            pitch = 89
        end
    else
        pitch = ui.def_custom_pitch:get()
    end

    pitch_jit = not pitch_jit

    if defensive > 0 and not in_attack and dt_ref:get() == 1 and hs_ref:get() == 0 then
        cmd:set_view_angles(pitch, view_angles_y + 180, 0)
    end
end

function menu_handler()
    local tab = ui.tabs:get()

    local tabrage = tab == 0
    local tabvis = tab == 1
    local tabmisc = tab == 2

    local cond_st = ui.aa_cond:get() == 0
    local cond_mv = ui.aa_cond:get() == 1
    local cond_ai = ui.aa_cond:get() == 2
    local cond_ad = ui.aa_cond:get() == 3
    local cond_dc = ui.aa_cond:get() == 4
    local cond_sw = ui.aa_cond:get() == 5
    
    local animbreaker = ui.animchangers:get()
    local leg_movement = ui.leg_movement:get() == 1

    ui.st_at_target:set_visible(cond_st)
    ui.mv_at_target:set_visible(cond_mv)
    ui.ai_at_target:set_visible(cond_ai)
    ui.ad_at_target:set_visible(cond_ad)
    ui.dc_at_target:set_visible(cond_dc)
    ui.sw_at_target:set_visible(cond_sw)
    
    ui.st_yaw_add:set_visible(cond_st)
    ui.mv_yaw_add:set_visible(cond_mv)
    ui.ai_yaw_add:set_visible(cond_ai)
    ui.ad_yaw_add:set_visible(cond_ad)
    ui.dc_yaw_add:set_visible(cond_dc)
    ui.sw_yaw_add:set_visible(cond_sw)

    ui.st_add:set_visible(cond_st and ui.st_yaw_add:get() > 0)
    ui.mv_add:set_visible(cond_mv and ui.mv_yaw_add:get() > 0)
    ui.ai_add:set_visible(cond_ai and ui.ai_yaw_add:get() > 0)
    ui.ad_add:set_visible(cond_ad and ui.ad_yaw_add:get() > 0)
    ui.dc_add:set_visible(cond_dc and ui.dc_yaw_add:get() > 0)
    ui.sw_add:set_visible(cond_sw and ui.sw_yaw_add:get() > 0)

    ui.st_spin:set_visible(cond_st)
    ui.mv_spin:set_visible(cond_mv)
    ui.ai_spin:set_visible(cond_ai)
    ui.ad_spin:set_visible(cond_ad)
    ui.dc_spin:set_visible(cond_dc)
    ui.sw_spin:set_visible(cond_sw)

    ui.st_spin_range:set_visible(cond_st and ui.st_spin:get())
    ui.mv_spin_range:set_visible(cond_mv and ui.mv_spin:get())
    ui.ai_spin_range:set_visible(cond_ai and ui.ai_spin:get())
    ui.ad_spin_range:set_visible(cond_ad and ui.ad_spin:get())
    ui.dc_spin_range:set_visible(cond_dc and ui.dc_spin:get())
    ui.sw_spin_range:set_visible(cond_sw and ui.sw_spin:get())

    ui.st_spin_speed:set_visible(cond_st and ui.st_spin:get())
    ui.mv_spin_speed:set_visible(cond_mv and ui.mv_spin:get())
    ui.ai_spin_speed:set_visible(cond_ai and ui.ai_spin:get())
    ui.ad_spin_speed:set_visible(cond_ad and ui.ad_spin:get())
    ui.dc_spin_speed:set_visible(cond_dc and ui.dc_spin:get())
    ui.sw_spin_speed:set_visible(cond_sw and ui.sw_spin:get())

    ui.st_jit:set_visible(cond_st)
    ui.mv_jit:set_visible(cond_mv)
    ui.ai_jit:set_visible(cond_ai)
    ui.ad_jit:set_visible(cond_ad)
    ui.dc_jit:set_visible(cond_dc)
    ui.sw_jit:set_visible(cond_sw)

    ui.st_jit_range:set_visible(cond_st and ui.st_jit:get())
    ui.mv_jit_range:set_visible(cond_mv and ui.mv_jit:get())
    ui.ai_jit_range:set_visible(cond_ai and ui.ai_jit:get())
    ui.ad_jit_range:set_visible(cond_ad and ui.ad_jit:get())
    ui.dc_jit_range:set_visible(cond_dc and ui.dc_jit:get())
    ui.sw_jit_range:set_visible(cond_sw and ui.sw_jit:get())

    ui.st_jit_rnd:set_visible(cond_st and ui.st_jit:get())
    ui.mv_jit_rnd:set_visible(cond_mv and ui.mv_jit:get())
    ui.ai_jit_rnd:set_visible(cond_ai and ui.ai_jit:get())
    ui.ad_jit_rnd:set_visible(cond_ad and ui.ad_jit:get())
    ui.dc_jit_rnd:set_visible(cond_dc and ui.dc_jit:get())
    ui.sw_jit_rnd:set_visible(cond_sw and ui.sw_jit:get())

    ui.st_dsy:set_visible(cond_st)
    ui.mv_dsy:set_visible(cond_mv)
    ui.ai_dsy:set_visible(cond_ai)
    ui.ad_dsy:set_visible(cond_ad)
    ui.dc_dsy:set_visible(cond_dc)
    ui.sw_dsy:set_visible(cond_sw)
    
    ui.st_dsy_amt:set_visible(cond_st and ui.st_dsy:get() > 0)
    ui.mv_dsy_amt:set_visible(cond_mv and ui.mv_dsy:get() > 0)
    ui.ai_dsy_amt:set_visible(cond_ai and ui.ai_dsy:get() > 0)
    ui.ad_dsy_amt:set_visible(cond_ad and ui.ad_dsy:get() > 0)
    ui.dc_dsy_amt:set_visible(cond_dc and ui.dc_dsy:get() > 0)
    ui.sw_dsy_amt:set_visible(cond_sw and ui.sw_dsy:get() > 0)
    
    ui.st_dsy_fs:set_visible(cond_st and ui.st_dsy:get() > 0)
    ui.mv_dsy_fs:set_visible(cond_mv and ui.mv_dsy:get() > 0)
    ui.ai_dsy_fs:set_visible(cond_ai and ui.ai_dsy:get() > 0)
    ui.ad_dsy_fs:set_visible(cond_ad and ui.ad_dsy:get() > 0)
    ui.dc_dsy_fs:set_visible(cond_dc and ui.dc_dsy:get() > 0)
    ui.sw_dsy_fs:set_visible(cond_sw and ui.sw_dsy:get() > 0)

    ui.st_dsy_jit:set_visible(cond_st and ui.st_dsy:get() > 0)
    ui.mv_dsy_jit:set_visible(cond_mv and ui.mv_dsy:get() > 0)
    ui.ai_dsy_jit:set_visible(cond_ai and ui.ai_dsy:get() > 0)
    ui.ad_dsy_jit:set_visible(cond_ad and ui.ad_dsy:get() > 0)
    ui.dc_dsy_jit:set_visible(cond_dc and ui.dc_dsy:get() > 0)
    ui.sw_dsy_jit:set_visible(cond_sw and ui.sw_dsy:get() > 0)
    
    ui.def_pitch:set_visible(ui.defensive_aa:get())
    ui.def_custom_pitch:set_visible(ui.defensive_aa:get() and ui.def_pitch:get() == 7)
    ui.def_type:set_visible(ui.defensive_aa:get())
    ui.def_delay:set_visible(ui.defensive_aa:get())

    ui.da_ovr:set_visible(tabrage)
    ui.fl_ovr:set_visible(tabrage)
    ui.inds:set_visible(tabvis)
    ui.log_offset:set_visible(tabvis and ui.inds:get()[2])
    ui.removals:set_visible(tabvis)
    ui.sunset:set_visible(tabvis)
    ui.sunset_x:set_visible(tabvis and ui.sunset:get())
    ui.sunset_y:set_visible(tabvis and ui.sunset:get())
    ui.sunset_z:set_visible(tabvis and ui.sunset:get())
    ui.fog:set_visible(tabvis)
    ui.fog_start:set_visible(tabvis and ui.fog:get())
    ui.fog_end:set_visible(tabvis and ui.fog:get())
    ui.fog_strength:set_visible(tabvis and ui.fog:get())
    ui.ratio:set_visible(tabvis)
    ui.animchangers:set_visible(tabmisc)
    ui.leg_movement:set_visible(tabmisc and animbreaker)
    ui.lean:set_visible(tabmisc and animbreaker)
    ui.falling_anim:set_visible(tabmisc and animbreaker)
end

local anim = 0; local dt_lerp = 0; local dt_a = 0; local os_a = 0; local fs_a = 0; local md_a = 0; local ba_a = 0; local da_a = 0
local arrow_lr = 0; local arrow_lg = 0; local arrow_lb = 0; local arrow_la = 0; local arrow_rr = 0; local arrow_rg = 0; local arrow_rb = 0; local arrow_ra = 0
local side_l = 0; local side_r = 0
function on_paint()
    menu_handler()

    if (engine.is_in_game() == false) then
        return
    end

    local w_mul = 510 / string.len(script_name)
    local watermark_w, watermark_h = render.get_text_size(verdana, script_name)
    local wc_offset = 0

    for i = 1, string.len(script_name) do
        local char = string.sub(script_name, i, i)
        local char_w, char_h = render.get_text_size(verdana, char)
        local c_anim = math.min((global_vars.tickcount * 5 - i * w_mul) % 1020, 510)
        local alpha = c_anim > 255 and 510 - c_anim or c_anim
        local col = mix(render.color(255, 255, 255, 120), render.color(255, 255, 255, 255), alpha / 255)

        render.text(verdana, w / 2 - watermark_w / 2 + wc_offset, h - 10, char, render.color(unpack(col)), render.align_left, render.align_center)

        wc_offset = wc_offset + char_w
    end
    
    local lp = entities[engine.get_local_player()]

    if lp:is_alive() == false then
        return
    end

    if ui.inds:get()[1] then
        local scoped = lp:get_prop("m_bIsScoped", 0)

        anim = lerp(anim, (scoped and 1 or 0), 0.07)

        dt_lerp = lerp(dt_lerp, (info.fatality.can_fastfire and 255 or 60), 0.07)
        dt_a = lerp(dt_a, (dt_ref:get() == 1 and 255 or 0), 0.2)
        os_a = lerp(os_a, (hs_ref:get() == 1 and 255 or 0), 0.2)
        fs_a = lerp(fs_a, (fs_ref:get() == 1 and 255 or 0), 0.2)
        md_a = lerp(md_a, (md_ref:get() == 1 and 255 or 0), 0.2)
        ba_a = lerp(ba_a, (ba_ref:get() == 1 and 255 or 0), 0.2)
        da_a = lerp(da_a, (ui.da_ovr:get() and 255 or 0), 0.2)

        local dt_col = render.color(255, dt_lerp, dt_lerp, dt_a)
        local add_y = 0

        local name = "pizdanogam°"
        local dt_ind = "doubletap"
        local os_ind = "onshot"
        local fs_ind = "freestand"
        local md_ind = "damage"
        local ba_ind = "safe"
        local da_ind = "dormant"

        local dt_w, dt_h = render.get_text_size(verdana, dt_ind)
        local os_w, os_h = render.get_text_size(verdana, os_ind)
        local fs_w, fs_h = render.get_text_size(verdana, fs_ind)
        local md_w, md_h = render.get_text_size(verdana, md_ind)
        local ba_w, ba_h = render.get_text_size(verdana, ba_ind)
        local da_w, da_h = render.get_text_size(verdana, da_ind)

        local name_w, name_h = render.get_text_size(verdanab, name)

        local add_x = anim * (name_w / 2 + 2)

        local mul = 510 / string.len(name)
        local c_offset = 0

        local cl1_val = ui.ind_first:get()
        local cl2_val = ui.ind_second:get()

        for i = 1, string.len(name) do
            local char = string.sub(name, i, i)
            local char_w, char_h = render.get_text_size(verdanab, char)
            local c_anim = math.min((global_vars.tickcount * 5 - i * mul) % 1020, 510)
            local alpha = c_anim > 255 and 510 - c_anim or c_anim
            local col = mix(cl1_val, cl2_val, alpha / 255)

            render.text(verdanab, w / 2 - name_w / 2 + add_x + c_offset, h / 2 + 20, char, render.color(unpack(col)), render.align_left, render.align_center)

            c_offset = c_offset + char_w
        end

        add_y = add_y + 12

        if (ba_ref:get() == 1 or ba_a > 1) then
            render.text(verdana, w / 2 - (ba_w / 2 - anim * (ba_w / 2 + 2)), h / 2 + 20 + add_y, ba_ind, render.color(255, 255, 255, ba_a), render.align_left, render.align_center)
            add_y = add_y + 10
        end
            
        if (dt_ref:get() == 1 or dt_a > 1) then
            render.text(verdana, w / 2 - (dt_w / 2 - anim * (dt_w / 2 + 2)), h / 2 + 20 + add_y, dt_ind, dt_col, render.align_left, render.align_center)
            add_y = add_y + 10
        end
        
        if (hs_ref:get() == 1 or os_a > 1) then
            render.text(verdana, w / 2 - (os_w / 2 - anim * (os_w / 2 + 2)), h / 2 + 20 + add_y, os_ind, render.color(255, 255, 255, os_a), render.align_left, render.align_center)
            add_y = add_y + 10
        end
        
        if (fs_ref:get() == 1 or fs_a > 1) then
            render.text(verdana, w / 2 - (fs_w / 2 - anim * (fs_w / 2 + 2)), h / 2 + 20 + add_y, fs_ind, render.color(255, 255, 255, fs_a), render.align_left, render.align_center)
            add_y = add_y + 10
        end
        
        if (md_ref:get() == 1 or md_a > 1) then
            render.text(verdana, w / 2 - (md_w / 2 - anim * (md_w / 2 + 2)), h / 2 + 20 + add_y, md_ind, render.color(255, 255, 255, md_a), render.align_left, render.align_center)
            add_y = add_y + 10
        end

        if (ui.da_ovr:get() or da_a > 1) then
            render.text(verdana, w / 2 - (da_w / 2 - anim * (da_w / 2 + 2)), h / 2 + 20 + add_y, da_ind, render.color(255, 255, 255, da_a), render.align_left, render.align_center)
            add_y = add_y + 10
        end
    end

    if ui.inds:get()[3] then
        arrow_lr = lerp(arrow_lr, (left_ref:get() == 1 and ui.ind_first:get().r or 0), 0.1)
        arrow_lg = lerp(arrow_lg, (left_ref:get() == 1 and ui.ind_first:get().g or 0), 0.1)
        arrow_lb = lerp(arrow_lb, (left_ref:get() == 1 and ui.ind_first:get().b or 0), 0.1)
        arrow_la = lerp(arrow_la, (left_ref:get() == 1 and ui.ind_first:get().a or 100), 0.1)
        arrow_rr = lerp(arrow_rr, (right_ref:get() == 1 and ui.ind_first:get().r or 0), 0.1)
        arrow_rg = lerp(arrow_rg, (right_ref:get() == 1 and ui.ind_first:get().g or 0), 0.1)
        arrow_rb = lerp(arrow_rb, (right_ref:get() == 1 and ui.ind_first:get().b or 0), 0.1)
        arrow_ra = lerp(arrow_ra, (right_ref:get() == 1 and ui.ind_first:get().a or 100), 0.1)

        render.triangle_filled(w / 2 - 64, h / 2 - anim * 16, w / 2 - 50, h / 2 - 7 - anim * 16, w / 2 - 50, h / 2 + 7 - anim * 16, render.color(arrow_lr, arrow_lg, arrow_lb, arrow_la))
        render.triangle_filled(w / 2 + 64, h / 2 - anim * 16, w / 2 + 50, h / 2 - 7 - anim * 16, w / 2 + 50, h / 2 + 7 - anim * 16, render.color(arrow_rr, arrow_rg, arrow_rb, arrow_ra))
    end

    local ratio = ui.ratio:get() * 0.01
    local val_sky = bool_to_int(ui.removals:get()[1] == false)
    local val_fullbright = bool_to_int(ui.removals:get()[2])

    da_ref:set(ui.da_ovr:get())
    r_3dsky:set_int(val_sky)
    r_aspectratio:set_float(ratio)
    mat_fullbright:set_int(val_fullbright)

    if ui.inds:get()[2] then
        for k, v in pairs(logs_data) do
            v.info.alpha:direct(255)
            if 2.9 - (global_vars.tickcount / 64 - v.info.tick / 64) < 0 then
                v.info.alpha:direct(0)
            end

            local totaltext = ""
            for i, j in pairs(v.data) do
                totaltext = totaltext .. j.text
            end

            local text_size_w, text_size_h = render.get_text_size(verdana, totaltext)

            render.rect_filled_rounded(w / 2 - text_size_w / 2 - 6, h / 2 + 156 + ui.log_offset:get() + (24 * (k - 1)) + (v.info.alpha:get_value() / 255 * 24), math.floor(w / 2 + text_size_w / 2 + 8), h / 2 + 176 + ui.log_offset:get() + (24 * (k - 1)) + (v.info.alpha:get_value() / 255 * 24), render.color(10, 10, 10, v.info.alpha:get_value()), 2)
            render.rect(w / 2 - text_size_w / 2 - 5, h / 2 + 157 + ui.log_offset:get() + (24 * (k - 1)) + (v.info.alpha:get_value() / 255 * 24), math.floor(w / 2 + text_size_w / 2 + 7), h / 2 + 175 + ui.log_offset:get() + (24 * (k - 1)) + (v.info.alpha:get_value() / 255 * 24), render.color(40, 40, 40, v.info.alpha:get_value()))

            text_multicolor(v.data, w / 2, h / 2 + 160 + ui.log_offset:get() + (24 * (k - 1)) + (v.info.alpha:get_value() / 255 * 24), verdana, v.info.alpha:get_value())
            if v.info.alpha:get_value() <= 0.1 and (2.9 - (global_vars.tickcount / 64 - v.info.tick / 64) < 0) then
                table.remove(logs_data, k)
            end
        end
    end

    render.rect_filled_rounded(10, 10, 20, 20, render.color(255, 255, 255, 255), 1.5)

    cl_csm_rot_ovr:set_int(ui.sunset:get() and 1 or 0)
    cl_csm_rot_x:set_int(ui.sunset_x:get())
    cl_csm_rot_y:set_int(ui.sunset_y:get())
    cl_csm_rot_z:set_int(ui.sunset_z:get())

    fog_ovr:set_int(ui.fog:get() and 1 or 0)
    fog_start:set_int(ui.fog_start:get())
    fog_end:set_int(ui.fog_end:get())
    fog_color:set_string(tostring(ui.fog_col:get().r) .. " " .. tostring(ui.fog_col:get().g) .. " " .. tostring(ui.fog_col:get().b))
    fog_maxdensity:set_float(ui.fog_strength:get() / 100)
end

function on_shot_registered(e)
    if e.result ~= "hit" and hitgroup_str[e.client_hitgroup] ~= nil then
        local accent = render.color("#FFFFFF")
        local rescol = ui.ind_first:get()

        table.insert(logs_data,
        {
            data = {
                {
                    text = "missed",
                    clr = accent
                },
                {
                    text = (" %s"):format(engine.get_player_info(e.target).name),
                    clr = rescol
                },
                {
                    text = ("'s"),
                    clr = accent
                },
                {
                    text = (" %s"):format(hitgroup_str[e.client_hitgroup]),
                    clr = rescol
                },
                {
                    text = (" due to"),
                    clr = accent
                },
                {
                    text = (" %s"):format(e.result),
                    clr = rescol
                },
                {
                    text = (" ("),
                    clr = accent
                },
                {
                    text = ("%s"):format(math.floor(.5 + e.hitchance)),
                    clr = rescol
                },
                {
                    text = ([[% hitchance)]]),
                    clr = accent
                },
            },
            info = {
                tick = e.tick,
                alpha = render.create_animator_float(0, .1)
                }
            }
        )
    end
end

function on_player_hurt(e)
    if not ui.inds:get()[2] then
        return
    end

    local attacker = e:get_int("attacker")
    local attacked = e:get_int("userid")
    local attacked_index = engine.get_player_for_user_id(attacked)
    local attacked_name = engine.get_player_info(attacked_index)['name']
    if engine.get_player_for_user_id(attacker) == engine.get_local_player() and attacked ~= attacker then
        local accent = render.color("#FFFFFF")
        local rescol = ui.ind_first:get()
        table.insert(logs_data,
        {
            data = {
                {
                    text = "hit",
                    clr = accent
                },
                {
                    text = (" %s"):format(attacked_name),
                    clr = rescol
                },
                {
                    text = ("'s"),
                    clr = accent
                },
                {
                    text = (" %s"):format(hitgroup_str[e:get_int("hitgroup")]),
                    clr = rescol
                },
                {
                    text = (" for"),
                    clr = accent
                },
                {
                    text = (" %s"):format(e:get_int("dmg_health")),
                    clr = rescol
                },
                {
                    text = (" damage ("),
                    clr = accent
                },
                {
                    text = e:get_int("health") == 0 and "" or ("%s"):format(e:get_int("health")),
                    clr = rescol
                },
                {
                    text = (e:get_int("health") == 0 and [[dead)]] or [[ health remaining)]]),
                    clr = accent
                },
            },
            info = {
                tick = global_vars.tickcount,
                alpha = render.create_animator_float(0, .1)
                }
            }
        )
    end
end

function on_round_start()
    defensive = 0
end

function on_shutdown()
    aa_manual_ref:set_visible(true)
    left_ref:set_visible(true)
    back_ref:set_visible(true)
    right_ref:set_visible(true)
    fs_ref:set_visible(true)
    aa_at_target_ref:set_visible(true)
    aa_yaw_add_ref:set_visible(true)
    aa_add_ref:set_visible(true)
    aa_spin_ref:set_visible(true)
    aa_spin_range_ref:set_visible(true)
    aa_spin_speed_ref:set_visible(true)
    aa_jit_ref:set_visible(true)
    aa_jit_range_ref:set_visible(true)
    aa_jit_rnd_ref:set_visible(true)
    aa_dsy_ref:set_visible(true)
    aa_dsy_amt_ref:set_visible(true)
    aa_dsy_comp_ref:set_visible(true)
    aa_dsy_fs_ref:set_visible(true)
    aa_dsy_jit_ref:set_visible(true)
    aa_roll_ref:set_visible(true)
    aa_roll_walk_ref:set_visible(true)
    aa_roll_flip_ref:set_visible(true)

    on_destroy()
end
