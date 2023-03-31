MIME-Version: 1.0
References: <20230331154214.613245-1-frank@...2641...>
 <20230331154214.613245-2-frank@...2641...>
In-Reply-To: <20230331154214.613245-2-frank@...2641...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 31 Mar 2023 18:53:46 +0300
Message-ID: <CAGyAFMXx44gPcmt7O-VtMKpEt_gYSoROK+hFZi+n0TcQrJuLfA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] vcpkg-ports/pkcs11-helper: Make
 compatible with mingw build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Reviewed in Gerrit.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 31. maalisk. 2023 klo 18.43 Frank Lichtenheld
(frank@...2641...) kirjoitti:
>
> Annoyingly this requires custom vcpkg triplets because
> the mingw toolchain definition and the vcpkg_configure_make
> function use incompatible default triplets (-pc-mingw32 vs
> -w64-mingw32).
>
> Change-Id: I4e671938220e9bfd798f91819f34b6f8ceaa45f5
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  ...to-succeed-if-configured-with-disabl.patch | 46 +++++++++++++++++++
>  .../vcpkg-ports/pkcs11-helper/portfile.cmake  | 33 ++++++++++---
>  contrib/vcpkg-triplets/x64-mingw-ovpn.cmake   |  8 ++++
>  contrib/vcpkg-triplets/x86-mingw-ovpn.cmake   |  8 ++++
>  4 files changed, 88 insertions(+), 7 deletions(-)
>  create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
>  create mode 100644 contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
>  create mode 100644 contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
>
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
> new file mode 100644
> index 00000000..102be4ec
> --- /dev/null
> +++ b/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
> @@ -0,0 +1,46 @@
> +From 7171396a151a2edb3474c7a321b7ae4ff7e171fc Mon Sep 17 00:00:00 2001
> +From: Frank Lichtenheld <frank@...2641...>
> +Date: Wed, 29 Mar 2023 12:44:44 +0200
> +Subject: [PATCH] Allow the build to succeed if configured with
> + --disable-shared
> +
> +Do not try to install a file that does not exist.
> +
> +Signed-off-by: Frank Lichtenheld <frank@...2641...>
> +---
> + configure.ac    | 1 +
> + lib/Makefile.am | 2 ++
> + 2 files changed, 3 insertions(+)
> +
> +diff --git a/configure.ac b/configure.ac
> +index a7e9760..f154ae3 100644
> +--- a/configure.ac
> ++++ b/configure.ac
> +@@ -581,6 +581,7 @@ AC_SUBST([LIBPKCS11_HELPER_LT_AGE])
> + AC_SUBST([LIBPKCS11_HELPER_LT_OLDEST])
> + AC_SUBST([WIN_LIBPREFIX])
> + AC_SUBST([PKCS11H_FEATURES])
> ++AM_CONDITIONAL([ENABLE_SHARED], [test "${enable_shared}" = "yes" ])
> + AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
> + AM_CONDITIONAL([CYGWIN], [test "${CYGWIN}" = "yes"])
> + AM_CONDITIONAL([ENABLE_DOC], [test "${enable_doc}" = "yes"])
> +diff --git a/lib/Makefile.am b/lib/Makefile.am
> +index 31b928f..3cba32f 100644
> +--- a/lib/Makefile.am
> ++++ b/lib/Makefile.am
> +@@ -128,10 +128,12 @@ if ENABLE_PKCS11H_TOKEN
> + endif
> +
> + if WIN32
> ++if ENABLE_SHARED
> + mylibdir=$(libdir)
> + mylib_DATA=.libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...
> + .libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...:      libpkcs11-helper.la
> + endif
> ++endif
> +
> + RCCOMPILE = $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
> +       $(AM_CPPFLAGS) $(CPPFLAGS)
> +--
> +2.34.1
> +
> diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> index 1c6cedac..67e9a2bf 100644
> --- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> +++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
> @@ -13,24 +13,43 @@ vcpkg_extract_source_archive_ex(
>      PATCHES
>          0001-nmake-compatibility-with-vcpkg-nmake.patch
>          0002-config-w32-vc.h.in-indicate-OpenSSL.patch
> +        0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
>          pkcs11-helper-001-RFC7512.patch
>          pkcs11-helper-002-dynamic_loader_flags.patch
>  )
>
> -vcpkg_build_nmake(
> +if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
> +  vcpkg_build_nmake(
>      SOURCE_PATH ${SOURCE_PATH}
>      PROJECT_SUBPATH lib
>      PROJECT_NAME Makefile.w32-vc
>      OPTIONS
>          OPENSSL=1
>          OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
> -)
> +  )
> +
> +  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
> +  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
> +
> +  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
> +  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
> +
> +  file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
> +
> +else()
> +  find_program(man_to_html man2html REQUIRED)
> +
> +  vcpkg_configure_make(
> +    SOURCE_PATH ${SOURCE_PATH}
> +    OPTIONS --disable-crypto-engine-gnutls --disable-crypto-engine-nss
> +    --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
> +    )
> +  vcpkg_install_make()
> +  vcpkg_fixup_pkgconfig()
>
> -file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
> -file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
> -file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
> +  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
> +endif()
>
> -file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
> -file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
> +vcpkg_copy_pdbs()
>
>  file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
> diff --git a/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
> new file mode 100644
> index 00000000..3676cdb0
> --- /dev/null
> +++ b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
> @@ -0,0 +1,8 @@
> +set(VCPKG_TARGET_ARCHITECTURE x64)
> +set(VCPKG_CRT_LINKAGE dynamic)
> +set(VCPKG_LIBRARY_LINKAGE static)
> +set(VCPKG_ENV_PASSTHROUGH PATH)
> +
> +set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
> +
> +set(VCPKG_MAKE_BUILD_TRIPLET --host=x86_64-w64-mingw32)
> diff --git a/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
> new file mode 100644
> index 00000000..9e65f67f
> --- /dev/null
> +++ b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
> @@ -0,0 +1,8 @@
> +set(VCPKG_TARGET_ARCHITECTURE x86)
> +set(VCPKG_CRT_LINKAGE dynamic)
> +set(VCPKG_LIBRARY_LINKAGE static)
> +set(VCPKG_ENV_PASSTHROUGH PATH)
> +
> +set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
> +
> +set(VCPKG_MAKE_BUILD_TRIPLET --host=i686-w64-mingw32)
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

