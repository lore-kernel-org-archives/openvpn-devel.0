MIME-Version: 1.0
References: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
 <20211119005306.624-1-lstipakov@...277...>
In-Reply-To: <20211119005306.624-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 20:35:53 +0200
Message-ID: <CAGyAFMV-9Y5dzTohMqxzfiqcj=Y2cYY+c3VDPi9sCzO6oioE2Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Load OpenSSL config on Windows from
 trusted location
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: Lev Stipakov <lev@...515...>

I don't have a setup to properly test it, like actually loading the
config - I only checked that the openvpn.exe attempted to access
openssl.cnf at the correct location.

If someone wants to test - binary artifacts could be found here:
https://github.com/lstipakov/openvpn/actions/runs/1496114596

I could also do testing if someone educates me how :)

ti 23. marrask. 2021 klo 20.27 Lev Stipakov (lstipakov@...277...) kirjoitti:
>
> From: Lev Stipakov <lev@...515...>
>
> Commits
>
>  - 92535b6 ("contrib/vcpkg-ports: add openssl port with --no-autoload-config option set (CVE-2121-3606)")
>  - 447cfb4 ("crypto_openssl.c: disable explicit initialization on Windows (CVE-2121-3606)")
>
> disabled OpenSSL config loading functionality, which could be
> exploited by loading config from untrusted locations.
>
> However, ability to load config might be useful for some users.
>
> This brings config loading back and sets OpenSSL enviroment variables
>
>  OPENSSL_CONF, OPENSSL_ENGINES, OPENSSL_MODULES
>
> which are used to load config, engines and modules, to a trusted location.
> The location is constructed based on installation path, read from registry on startup.
> If installation path cannot be read, Windows\System32 is used as a fallback.
>
> While on it, remove unused "bool impersonate_as_system();" declaration.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>
>  v3:
>   - do not assume that installation path ends with directory separator
>   - set enviroment variables only if they're not already set
>   - bring back explicit initialization on Windows (might be needed on
>     some cases)
>   - slightly revamp commit message
>
>  v2:
>   - add missing "static" modifier to set_openssl_env_vars() declaration
> spotted by gcc
>
>  .../vcpkg-triplets/arm64-windows-ovpn.cmake   |  2 -
>  contrib/vcpkg-triplets/x64-windows-ovpn.cmake |  2 -
>  contrib/vcpkg-triplets/x86-windows-ovpn.cmake |  2 -
>  src/openvpn/buffer.c                          | 23 -----
>  src/openvpn/crypto_openssl.c                  |  2 -
>  src/openvpn/win32.c                           | 92 +++++++++++++++++++
>  src/openvpn/win32.h                           |  8 +-
>  7 files changed, 99 insertions(+), 32 deletions(-)
>
> diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> index 89f6a279..dd3c6c0a 100644
> --- a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> +++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> @@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
>  if(PORT STREQUAL "lz4")
>      set(VCPKG_LIBRARY_LINKAGE static)
>  endif()
> -
> -set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
> diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> index d860eed6..7036ed2d 100644
> --- a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> +++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> @@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
>  if(PORT STREQUAL "lz4")
>      set(VCPKG_LIBRARY_LINKAGE static)
>  endif()
> -
> -set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
> diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
> index c1ea6ef3..7d3bf340 100644
> --- a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
> +++ b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
> @@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
>  if(PORT STREQUAL "lz4")
>      set(VCPKG_LIBRARY_LINKAGE static)
>  endif()
> -
> -set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index c82d3d4d..54e758af 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -310,29 +310,6 @@ openvpn_snprintf(char *str, size_t size, const char *format, ...)
>      return (len >= 0 && len < size);
>  }
>
> -/*
> - * openvpn_swprintf() is currently only used by Windows code paths
> - * and when enabled for all platforms it will currently break older
> - * OpenBSD versions lacking vswprintf(3) support in their libc.
> - */
> -
> -#ifdef _WIN32
> -bool
> -openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
> -{
> -    va_list arglist;
> -    int len = -1;
> -    if (size > 0)
> -    {
> -        va_start(arglist, format);
> -        len = vswprintf(str, size, format, arglist);
> -        va_end(arglist);
> -        str[size - 1] = L'\0';
> -    }
> -    return (len >= 0 && len < size);
> -}
> -#endif
> -
>  /*
>   * write a string to the end of a buffer that was
>   * truncated by buf_printf
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index c9dc9d0a..ef520928 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -154,13 +154,11 @@ crypto_init_lib_engine(const char *engine_name)
>  void
>  crypto_init_lib(void)
>  {
> -#ifndef _WIN32
>  #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
>      OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
>  #else
>      OPENSSL_config(NULL);
>  #endif
> -#endif /* _WIN32 */
>      /*
>       * If you build the OpenSSL library and OpenVPN with
>       * CRYPTO_MDEBUG, you will get a listing of OpenSSL
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 6cff17b2..ac7775e4 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -101,6 +101,12 @@ struct semaphore netcmd_semaphore; /* GLOBAL */
>   */
>  static char *win_sys_path = NULL; /* GLOBAL */
>
> +/**
> + * Set OpenSSL environment variables to a safe directory
> + */
> +static void
> +set_openssl_env_vars();
> +
>  void
>  init_win32(void)
>  {
> @@ -110,6 +116,8 @@ init_win32(void)
>      }
>      window_title_clear(&window_title);
>      win32_signal_clear(&win32_signal);
> +
> +    set_openssl_env_vars();
>  }
>
>  void
> @@ -1509,4 +1517,88 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
>      return ret;
>  }
>
> +bool
> +openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t* const format, ...)
> +{
> +    va_list arglist;
> +    int len = -1;
> +    if (size > 0)
> +    {
> +        va_start(arglist, format);
> +        len = vswprintf(str, size, format, arglist);
> +        va_end(arglist);
> +        str[size - 1] = L'\0';
> +    }
> +    return (len >= 0 && len < size);
> +}
> +
> +static BOOL
> +get_install_path(WCHAR *path, DWORD size)
> +{
> +    WCHAR reg_path[256];
> +    HKEY key;
> +    BOOL res = FALSE;
> +    openvpn_swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" PACKAGE_NAME);
> +
> +    LONG status = RegOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
> +    if (status != ERROR_SUCCESS)
> +    {
> +        return res;
> +    }
> +
> +    /* The default value of REG_KEY is the install path */
> +    status = RegGetValueW(key, NULL, NULL, RRF_RT_REG_SZ, NULL, (LPBYTE)path, &size);
> +    res = status == ERROR_SUCCESS;
> +
> +    RegCloseKey(key);
> +
> +    return res;
> +}
> +
> +static void
> +set_openssl_env_vars()
> +{
> +    const WCHAR* ssl_fallback_dir = L"C:\\Windows\\System32";
> +
> +    WCHAR install_path[MAX_PATH] = { 0 };
> +    if (!get_install_path(install_path, _countof(install_path)))
> +    {
> +        /* if we cannot find installation path from the registry,
> +         * use Windows directory as a fallback
> +         */
> +        openvpn_swprintf(install_path, _countof(install_path), L"%ls", ssl_fallback_dir);
> +    }
> +
> +    if ((install_path[wcslen(install_path) - 1]) == L'\\')
> +    {
> +        install_path[wcslen(install_path) - 1] = L'\0';
> +    }
> +
> +    WCHAR openssl_cnf[MAX_PATH] = {0};
> +    WCHAR openssl_engines[MAX_PATH] = {0};
> +    WCHAR openssl_modules[MAX_PATH] = {0};
> +
> +    openvpn_swprintf(openssl_cnf, _countof(install_path),
> +        L"OPENSSL_CONF=%ls\\ssl\\openssl.cnf", install_path);
> +    openvpn_swprintf(openssl_engines, _countof(openssl_engines),
> +        L"OPENSSL_ENGINES=%ls\\ssl\\engines", install_path);
> +    openvpn_swprintf(openssl_modules, _countof(openssl_modules),
> +        L"OPENSSL_MODULES=%ls\\ssl\\modules", install_path);
> +
> +    if (_wgetenv(L"OPENSSL_CONF") == NULL)
> +    {
> +        _wputenv(openssl_cnf);
> +    }
> +
> +    if (_wgetenv(L"OPENSSL_ENGINES") == NULL)
> +    {
> +        _wputenv(openssl_engines);
> +    }
> +
> +    if (_wgetenv(L"OPENSSL_MODULES") == NULL)
> +    {
> +        _wputenv(openssl_modules);
> +    }
> +}
> +
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 5d3371a0..4a992d91 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -327,7 +327,13 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
>  int
>  openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
>
> -bool impersonate_as_system();
> +/*
> + * openvpn_swprintf() is currently only used by Windows code paths
> + * and when enabled for all platforms it will currently break older
> + * OpenBSD versions lacking vswprintf(3) support in their libc.
> + */
> +bool
> +openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t* const format, ...);
>
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> --
> 2.23.0.windows.1
>


-- 
-Lev

