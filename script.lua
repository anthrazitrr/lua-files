function __main()
    local menu = require("oop_menu")

    if not MENU_LIB_ERROR_OUTDATED then
        return error("outdated library")
    elseif MENU_LIB_VER ~= 1 then
        return MENU_LIB_ERROR_OUTDATED()
    end

    local build = "1.0.4\n"

    local script_name = "PIZDA_NOGAM"

    utils.http_get("https://raw.githubusercontent.com/anthrazitrr/lua-files/main/version", "Accept: */*", function(latest_build)
        if (not (build == latest_build)) then
            print(latest_build)
            return error("download the new version nigger")
        else
            print("[pizdanogam] executed")
        end
    end)

    local w, h = render.get_screen_size()
    local verdana = render.create_font("verdana.ttf", 11, render.font_flag_shadow)
    local verdanab = render.create_font("verdanab.ttf", 11, render.font_flag_shadow)
    local small = render.font_esp

    local r_3dsky = cvar.r_3dsky
    local r_aspectratio = cvar.r_aspectratio
    local mat_fullbright = cvar.mat_fullbright

    local aa_place = "rage>anti-aim>angles"
    local aa_desync = "rage>anti-aim>desync"

    local add_types = { "none", "static", "3-way", "slow jitter" }
    local dsy_types = { "none", "static", "3-way", "slow jitter" }

    local ui = {
        tabs = menu.add_listbox("", "lua>tab a", 3, false, { "~ ragebot", "~ visuals", "~ misc" }),

        name = menu.add_listbox("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", "lua>tab a", 1, false, { "                 PIZDA_NOGAM", "anti-aim builder is in rage>anti-aim" }),

        aa_cond = menu.add_combo("[PIZDANOGAM] condition", aa_place, { "standing", "moving", "in air", "in air duck", "ducking", "slowwalking" }),

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
        st_spin_speed = menu.add_slider("spin speed ", aa_place, 0, 180, 1, "rpm"),
        mv_spin_speed = menu.add_slider("spin speed  ", aa_place, 0, 180, 1, "rpm"),
        ai_spin_speed = menu.add_slider("spin speed   ", aa_place, 0, 180, 1, "rpm"),
        ad_spin_speed = menu.add_slider("spin speed    ", aa_place, 0, 180, 1, "rpm"),
        dc_spin_speed = menu.add_slider("spin speed     ", aa_place, 0, 180, 1, "rpm"),
        sw_spin_speed = menu.add_slider("spin speed      ", aa_place, 0, 180, 1, "rpm"),
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
        st_dsy_jit = menu.add_checkbox("switch desync with jitter ", aa_desync),
        mv_dsy_jit = menu.add_checkbox("switch desync with jitter  ", aa_desync),
        ai_dsy_jit = menu.add_checkbox("switch desync with jitter   ", aa_desync),
        ad_dsy_jit = menu.add_checkbox("switch desync with jitter    ", aa_desync),
        dc_dsy_jit = menu.add_checkbox("switch desync with jitter     ", aa_desync),
        sw_dsy_jit = menu.add_checkbox("switch desync with jitter      ", aa_desync),

        da_ovr = menu.add_checkbox("dormant aimbot override", "lua>tab b"),
        fl_ovr = menu.add_checkbox("disable fakelag on hide shots", "lua>tab b"),

        inds = menu.add_multi_combo("indicators", "lua>tab b", { "under crosshair", "manual aa" }),
        ind_first = menu.add_colorpicker("lua>tab b>indicators", true, render.color(200, 220, 255, 255)),
        ind_second = menu.add_colorpicker("lua>tab b>indicators", true, render.color(160, 200, 230, 160)),
        ratio = menu.add_slider("aspect ratio", "lua>tab b", 0, 200, 1),
        sky = menu.add_checkbox("disable 3d skybox", "lua>tab b"),
        fullbright = menu.add_checkbox("fullbright", "lua>tab b"),

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

    aa_manual_ref:bind_to(ui.aa_manual)
    left_ref:bind_to(ui.left)
    back_ref:bind_to(ui.back)
    right_ref:bind_to(ui.right)
    fs_ref:bind_to(ui.fs)

    local on_ground_ticks = 0

    local sigs = {
        get_pose_params = {"client.dll", "55 8B EC 8B 45 08 57 8B F9 8B 4F 04 85 C9 75 15"} -- https://github.com/perilouswithadollarsign/cstrike15_src/blob/master/public/studio.cpp#L931 
    }

    local offsets = {
        animstate = 0x9960, -- m_bIsScoped - 20
        m_pStudioHdr = 0x2950, -- https://github.com/frk1/hazedumper/blob/master/csgo.json#L55
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

        --[[
        local landing_anim = ffi.cast("bool*", animstate + offsets.landing_anim)[0]

        if landing_anim == nil then
            return
        end
        ]]

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
            set_layer(local_player, 6, 0.9, 1) -- falling anim -- m_flPoseParamter 6
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

    function antiaim()
        local local_player = entities.get_entity(engine.get_local_player())

        if local_player == nil then
            return
        end

        local duckamt = local_player:get_prop("m_flDuckAmount")
        local jumping = local_player:get_prop("m_hGroundEntity") == -1
        local walking = sw_ref:get() == 1

        local vel = math.sqrt(local_player:get_prop("m_vecVelocity[0]") * local_player:get_prop("m_vecVelocity[0]") + local_player:get_prop("m_vecVelocity[1]") * local_player:get_prop("m_vecVelocity[1]"))

        if ((ui.jit_dis:get()[1] and fs_ref:get() == 1) or (ui.jit_dis:get()[2] and (left_ref:get() == 1 or back_ref:get() == 1 or right_ref:get() == 1))) then
            aa_at_target_ref:set(1)
            aa_yaw_add_ref:set(0)
            aa_spin_ref:set(0)
            aa_jit_ref:set(0)
            aa_dsy_ref:set(1)
            aa_dsy_amt_ref:set(-100)
            aa_dsy_jit_ref:set(0)
            return
        end

        local tickcount = math.floor(global_vars.tickcount % 6 / 2)

        if (jumping and duckamt > 0.5) then
            aa_at_target_ref:set(ui.ad_at_target:get())
            aa_yaw_add_ref:set(ui.ad_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.ad_yaw_add:get() == 2 and (-ui.ad_add:get() + (ui.ad_add:get() * tickcount)) or (ui.ad_add:get()))
            aa_spin_ref:set(ui.ad_spin:get())
            aa_spin_range_ref:set(ui.ad_spin_range:get())
            aa_spin_speed_ref:set(ui.ad_spin_speed:get())
            aa_jit_ref:set(ui.ad_jit:get())
            aa_jit_range_ref:set(ui.ad_jit_range:get())
            aa_jit_rnd_ref:set(ui.ad_jit_rnd:get())
            aa_dsy_ref:set(ui.ad_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.ad_dsy:get() > 1) and -ui.ad_dsy_amt:get() or ui.ad_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.ad_dsy_jit:get())
        elseif (jumping) then
            aa_at_target_ref:set(ui.ai_at_target:get())
            aa_yaw_add_ref:set(ui.ai_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.ai_yaw_add:get() == 2 and (-ui.ai_add:get() + (ui.ai_add:get() * tickcount)) or (ui.ai_add:get()))
            aa_spin_ref:set(ui.ai_spin:get())
            aa_spin_range_ref:set(ui.ai_spin_range:get())
            aa_spin_speed_ref:set(ui.ai_spin_speed:get())
            aa_jit_ref:set(ui.ai_jit:get())
            aa_jit_range_ref:set(ui.ai_jit_range:get())
            aa_jit_rnd_ref:set(ui.ai_jit_rnd:get())
            aa_dsy_ref:set(ui.ai_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.ai_dsy:get() > 1) and -ui.ai_dsy_amt:get() or ui.ai_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.ai_dsy_jit:get())
        elseif (walking and vel > 5) then
            aa_at_target_ref:set(ui.sw_at_target:get())
            aa_yaw_add_ref:set(ui.sw_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.sw_yaw_add:get() == 2 and (-ui.sw_add:get() + (ui.sw_add:get() * tickcount)) or (ui.sw_add:get()))
            aa_spin_ref:set(ui.sw_spin:get())
            aa_spin_range_ref:set(ui.sw_spin_range:get())
            aa_spin_speed_ref:set(ui.sw_spin_speed:get())
            aa_jit_ref:set(ui.sw_jit:get())
            aa_jit_range_ref:set(ui.sw_jit_range:get())
            aa_jit_rnd_ref:set(ui.sw_jit_rnd:get())
            aa_dsy_ref:set(ui.sw_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.sw_dsy:get() > 1) and -ui.sw_dsy_amt:get() or ui.sw_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.sw_dsy_jit:get())
        elseif (duckamt > 0.5) then
            aa_at_target_ref:set(ui.dc_at_target:get())
            aa_yaw_add_ref:set(ui.dc_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.dc_yaw_add:get() == 2 and (-ui.dc_add:get() + (ui.dc_add:get() * tickcount)) or (ui.dc_add:get()))
            aa_spin_ref:set(ui.dc_spin:get())
            aa_spin_range_ref:set(ui.dc_spin_range:get())
            aa_spin_speed_ref:set(ui.dc_spin_speed:get())
            aa_jit_ref:set(ui.dc_jit:get())
            aa_jit_range_ref:set(ui.dc_jit_range:get())
            aa_jit_rnd_ref:set(ui.dc_jit_rnd:get())
            aa_dsy_ref:set(ui.dc_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.dc_dsy:get() > 1) and -ui.dc_dsy_amt:get() or ui.dc_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.dc_dsy_jit:get())
        elseif (vel < 5) then
            aa_at_target_ref:set(ui.st_at_target:get())
            aa_yaw_add_ref:set(ui.st_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.st_yaw_add:get() == 2 and (-ui.st_add:get() + (ui.st_add:get() * tickcount)) or (ui.st_add:get()))
            aa_spin_ref:set(ui.st_spin:get())
            aa_spin_range_ref:set(ui.st_spin_range:get())
            aa_spin_speed_ref:set(ui.st_spin_speed:get())
            aa_jit_ref:set(ui.st_jit:get())
            aa_jit_range_ref:set(ui.st_jit_range:get())
            aa_jit_rnd_ref:set(ui.st_jit_rnd:get())
            aa_dsy_ref:set(ui.st_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.st_dsy:get() > 1) and -ui.st_dsy_amt:get() or ui.st_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.st_dsy_jit:get())
        else
            aa_at_target_ref:set(ui.mv_at_target:get())
            aa_yaw_add_ref:set(ui.mv_yaw_add:get() > 0 and true or false)
            aa_add_ref:set(ui.mv_yaw_add:get() == 2 and (-ui.mv_add:get() + (ui.mv_add:get() * tickcount)) or (ui.mv_add:get()))
            aa_spin_ref:set(ui.mv_spin:get())
            aa_spin_range_ref:set(ui.mv_spin_range:get())
            aa_spin_speed_ref:set(ui.mv_spin_speed:get())
            aa_jit_ref:set(ui.mv_jit:get())
            aa_jit_range_ref:set(ui.mv_jit_range:get())
            aa_jit_rnd_ref:set(ui.mv_jit_rnd:get())
            aa_dsy_ref:set(ui.mv_dsy:get() > 0 and true or false)
            aa_dsy_amt_ref:set((tickcount > 1 and ui.mv_dsy:get() > 1) and -ui.mv_dsy_amt:get() or ui.mv_dsy_amt:get())
            aa_dsy_jit_ref:set(ui.mv_dsy_jit:get())
        end
    end

    function on_create_move(cmd)
        setup(cmd)

        local local_player = entities.get_entity(engine.get_local_player())
        if local_player == nil then
            return
        end

        local on_ground = bit.band(local_player:get_prop("m_fFlags"),1)
        if on_ground == 1 then
            on_ground_ticks = on_ground_ticks + 1
        else
            on_ground_ticks = 0
        end

        if (ui.fl_ovr:get()) then
            aa_fakelag_ref:set(hs_ref:get() == 1 and 1 or 14)
        end

        antiaim()
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
        
        ui.st_dsy_jit:set_visible(cond_st and ui.st_dsy:get() > 0)
        ui.mv_dsy_jit:set_visible(cond_mv and ui.mv_dsy:get() > 0)
        ui.ai_dsy_jit:set_visible(cond_ai and ui.ai_dsy:get() > 0)
        ui.ad_dsy_jit:set_visible(cond_ad and ui.ad_dsy:get() > 0)
        ui.dc_dsy_jit:set_visible(cond_dc and ui.dc_dsy:get() > 0)
        ui.sw_dsy_jit:set_visible(cond_sw and ui.sw_dsy:get() > 0)
        
        ui.da_ovr:set_visible(tabrage)
        ui.fl_ovr:set_visible(tabrage)
        ui.inds:set_visible(tabvis)
        ui.ratio:set_visible(tabvis)
        ui.sky:set_visible(tabvis)
        ui.fullbright:set_visible(tabvis)
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

        if (lp:is_alive() == false) then
            return
        end

        if (ui.inds:get()[1]) then
            local scoped = lp:get_prop("m_bIsScoped", 0)

            anim = lerp(anim, (scoped and 1 or 0), 0.07)

            local add_x = anim * 34

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

            local name_w, name_h = render.get_text_size(verdanab, name)

            -- render.text(verdanab, w / 2 - name_w / 2 + add_x, h / 2 + 20, name, ui.ind_color:get(), render.align_left, render.align_center)

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
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, ba_ind, render.color(255, 255, 255, ba_a), render.align_center, render.align_center)
                add_y = add_y + 10
            end
                
            if (dt_ref:get() == 1 or dt_a > 1) then
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, dt_ind, dt_col, render.align_center, render.align_center)
                add_y = add_y + 10
            end
            
            if (hs_ref:get() == 1 or os_a > 1) then
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, os_ind, render.color(255, 255, 255, os_a), render.align_center, render.align_center)
                add_y = add_y + 10
            end
            
            if (fs_ref:get() == 1 or fs_a > 1) then
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, fs_ind, render.color(255, 255, 255, fs_a), render.align_center, render.align_center)
                add_y = add_y + 10
            end
            
            if (md_ref:get() == 1 or md_a > 1) then
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, md_ind, render.color(255, 255, 255, md_a), render.align_center, render.align_center)
                add_y = add_y + 10
            end

            if (ui.da_ovr:get() or da_a > 1) then
                render.text(verdana, w / 2 + add_x, h / 2 + 20 + add_y, da_ind, render.color(255, 255, 255, da_a), render.align_center, render.align_center)
                add_y = add_y + 10
            end
        end

        if (ui.inds:get()[2]) then
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

            -- render.rect_filled(w / 2 - 48, h / 2 - 7, w / 2 - 46, h / 2 + 7, ui.ind_color:get())
        end

        local ratio = ui.ratio:get() * 0.01
        local val_sky = bool_to_int(ui.sky:get() == false)
        local val_fullbright = bool_to_int(ui.fullbright:get())

        da_ref:set(ui.da_ovr:get())
        r_3dsky:set_int(val_sky)
        r_aspectratio:set_float(ratio)
        mat_fullbright:set_int(val_fullbright)
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
end

return __main
