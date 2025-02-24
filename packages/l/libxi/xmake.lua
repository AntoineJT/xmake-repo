package("libxi")

    set_homepage("https://www.x.org/")
    set_description("X.Org: Library for the X Input Extension")

    set_urls("https://www.x.org/archive/individual/lib/libXi-$(version).tar.bz2")
    add_versions("1.7.10", "36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061")

    if is_plat("linux") then
        add_extsources("apt::libxi-dev")
    end

    if is_plat("macosx", "linux") then
        add_deps("pkg-config", "libx11", "libxext", "libxfixes", "xorgproto")
    end

    on_install("macosx", "linux", function (package)
        local configs = {"--sysconfdir=" .. package:installdir("etc"),
                         "--localstatedir=" .. package:installdir("var"),
                         "--disable-dependency-tracking",
                         "--disable-silent-rules",
                         "--enable-docs=no",
                         "--enable-specs=no"}
        import("package.tools.autoconf").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_ctypes("XDeviceButtonEvent", {includes = "X11/extensions/XInput.h"}))
    end)
