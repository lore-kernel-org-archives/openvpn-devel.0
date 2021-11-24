MIME-Version: 1.0
References: <CAKuzo_gy8WZUH__KcofJ3_WP4uwy9FGh5mfho-1h1TsDbQENyQ@...278...>
 <20211119015548.687-1-lstipakov@...277...>
In-Reply-To: <20211119015548.687-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Nov 2021 00:54:01 -0500
Message-ID: <CAKuzo_jF9FQ4+G0T1mnnwBGPOb933BHGiCfCL9LbjUMxAkpKWQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f1c89205d1827c0d"
Subject: Re: [Openvpn-devel] [PATCH v4] Load OpenSSL config on Windows from
 trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000f1c89205d1827c0d
Content-Type: text/plain; charset="UTF-8"

Hi,

Looks good in my tests using the msvc artifacts from
https://github.com/lstipakov/openvpn/actions/runs/1496339867#artifacts.

Loads config from <install-root>\ssl\openssl.cnf and engines specified with
relative paths load from <install-root>\ssl\engines. So the env vars are
being seen by OpenSSL and being used as expected.

I wasted quite some time using the msvc-built executable with mingw
compiled OpenSSL libraries (I was being lazy copying only openvpn.exe). For
some reason OpenSSL doesn't detect the env vars in this case --- process
explorer shows its all set right, but the library doesn't load openssl.cnf.
Not worth exploring further, I guess.

Testing OPENSSL_MODULES path is left for later when a 3.0 build with MSVC
is available.

Some nits below which may be ignored.

On Tue, Nov 23, 2021 at 2:31 PM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Commits
>
>  - 92535b6 ("contrib/vcpkg-ports: add openssl port with
> --no-autoload-config option set (CVE-2121-3606)")
>  - 447cfb4 ("crypto_openssl.c: disable explicit initialization on Windows
> (CVE-2121-3606)")
>
> disabled OpenSSL config loading functionality, which could be
> exploited by loading config from untrusted locations.
>
> This feature might be useful for some users. This brings it back
> and sets OpenSSL enviroment variables
>
>  OPENSSL_CONF, OPENSSL_ENGINES, OPENSSL_MODULES
>
> which are used to load config, engines and modules, to a trusted location.
> The location is constructed based on installation path, read from registry
> on startup.
> If installation path cannot be read, Windows\System32 is used as a
> fallback.
>
> While on it, remove unused "bool impersonate_as_system();" declaration.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v4:
>   - make set_openssl_env_vars() code more succint
>   - use security-enhanced _wputenv_s/_wgetenv_s
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
>  src/openvpn/win32.c                           | 88 +++++++++++++++++++
>  src/openvpn/win32.h                           |  8 +-
>  7 files changed, 95 insertions(+), 32 deletions(-)
>
> diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> index 89f6a279..dd3c6c0a 100644
> --- a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> +++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
> @@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
>  if(PORT STREQUAL "lz4")
>      set(VCPKG_LIBRARY_LINKAGE static)
>  endif()
> -
> -set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
> diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> index d860eed6..7036ed2d 100644
> --- a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> +++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
> @@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
>  if(PORT STREQUAL "lz4")
>      set(VCPKG_LIBRARY_LINKAGE static)
>  endif()
> -
> -set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
> diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
> b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
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
> @@ -310,29 +310,6 @@ openvpn_snprintf(char *str, size_t size, const char
> *format, ...)
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
> -openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t
> *const format, ...)
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
> index 6cff17b2..ee4d3f66 100644
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
> @@ -1509,4 +1517,84 @@ send_msg_iservice(HANDLE pipe, const void *data,
> size_t size,
>      return ret;
>  }
>
> +bool
> +openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t*
> const format, ...)
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
> +    openvpn_swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\"
> PACKAGE_NAME);

+
> +    LONG status = RegOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, 0,
> KEY_READ, &key);
> +    if (status != ERROR_SUCCESS)
> +    {
> +        return res;
> +    }
> +
> +    /* The default value of REG_KEY is the install path */
> +    status = RegGetValueW(key, NULL, NULL, RRF_RT_REG_SZ, NULL,
> (LPBYTE)path, &size);
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
> +        openvpn_swprintf(install_path, _countof(install_path), L"%ls",
> ssl_fallback_dir);
> +    }
> +
> +    if ((install_path[wcslen(install_path) - 1]) == L'\\')
> +    {
> +        install_path[wcslen(install_path) - 1] = L'\0';
> +    }
> +
> +    static struct {
> +        WCHAR* name;
> +        WCHAR* value;
> +    } ossl_env[] = {
> +        {L"OPENSSL_CONF", L"openssl.cnf"},
> +        {L"OPENSSL_ENGINES", L"engines"},
> +        {L"OPENSSL_MODULES", L"modules"}
> +    };
>

As you defined this inside the function, it doesn't have to be static.
Also, name and value could be const. Our preferred style is "TYPE *val",
not the "TYPE* val" used here and elsewhere in the patch. Neither are worth
a v5, IMO.


> +
> +    for (size_t i = 0; i < SIZE(ossl_env); ++i)
> +    {
> +        size_t size = 0;
> +
> +        _wgetenv_s(&size, NULL, 0, ossl_env[i].name);
> +        if (size == 0)
> +        {
> +            WCHAR val[MAX_PATH] = {0};
> +            openvpn_swprintf(val, _countof(val), L"%ls\\ssl\\%ls",
> install_path, ossl_env[i].value);
> +            _wputenv_s(ossl_env[i].name, val);
> +        }
> +    }
> +}
> +
>  #endif /* ifdef _WIN32 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 5d3371a0..4a992d91 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -327,7 +327,13 @@ bool send_msg_iservice(HANDLE pipe, const void *data,
> size_t size,
>  int
>  openvpn_execve(const struct argv *a, const struct env_set *es, const
> unsigned int flags);
>
> -bool impersonate_as_system();
> +/*
> + * openvpn_swprintf() is currently only used by Windows code paths
> + * and when enabled for all platforms it will currently break older
> + * OpenBSD versions lacking vswprintf(3) support in their libc.
> + */
> +bool
> +openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t*
> const format, ...);


Now there is a duplicate declaration in buffer.h which could be removed.
Multiple declarations is not an error, so let it be...


>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
>

Acked-by: Selva Nair <selva.nair@...277...>

--000000000000f1c89205d1827c0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Looks good in my t=
ests using the msvc artifacts from=C2=A0 <a href=3D"https://github.com/lsti=
pakov/openvpn/actions/runs/1496339867#artifacts" target=3D"_blank">https://=
github.com/lstipakov/openvpn/actions/runs/1496339867#artifacts</a>.=C2=A0</=
div><div><br></div><div>Loads config from &lt;install-root&gt;\ssl\openssl.=
cnf and engines specified with relative paths load from &lt;install-root&gt=
;\ssl\engines. So the env vars are being seen by OpenSSL and being used as =
expected.</div><div><br></div><div>I wasted quite some time using the msvc-=
built executable with mingw compiled OpenSSL libraries (I was being lazy co=
pying only openvpn.exe). For some reason OpenSSL doesn&#39;t detect the env=
 vars in this case --- process explorer shows its all set right, but the li=
brary doesn&#39;t load openssl.cnf. Not worth exploring further, I guess.</=
div><div>=C2=A0=C2=A0</div></div><div>Testing OPENSSL_MODULES path is left =
for later when a 3.0 build with MSVC is available.</div><div><br></div><div=
>Some nits=C2=A0below which may be ignored.<br></div><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Nov 23, 2021 at 2:31 PM Lev Stipakov &lt;<a href=3D=
"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev=
 Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...2146...=
...</a>&gt;<br>
<br>
Commits<br>
<br>
=C2=A0- 92535b6 (&quot;contrib/vcpkg-ports: add openssl port with --no-auto=
load-config option set (CVE-2121-3606)&quot;)<br>
=C2=A0- 447cfb4 (&quot;crypto_openssl.c: disable explicit initialization on=
 Windows (CVE-2121-3606)&quot;)<br>
<br>
disabled OpenSSL config loading functionality, which could be<br>
exploited by loading config from untrusted locations.<br>
<br>
This feature might be useful for some users. This brings it back<br>
and sets OpenSSL enviroment variables<br>
<br>
=C2=A0OPENSSL_CONF, OPENSSL_ENGINES, OPENSSL_MODULES<br>
<br>
which are used to load config, engines and modules, to a trusted location.<=
br>
The location is constructed based on installation path, read from registry =
on startup.<br>
If installation path cannot be read, Windows\System32 is used as a fallback=
.<br>
<br>
While on it, remove unused &quot;bool impersonate_as_system();&quot; declar=
ation.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v4:<br>
=C2=A0 - make set_openssl_env_vars() code more succint<br>
=C2=A0 - use security-enhanced _wputenv_s/_wgetenv_s<br>
<br>
=C2=A0v3:<br>
=C2=A0 - do not assume that installation path ends with directory separator=
<br>
=C2=A0 - set enviroment variables only if they&#39;re not already set<br>
=C2=A0 - bring back explicit initialization on Windows (might be needed on<=
br>
=C2=A0 =C2=A0 some cases)<br>
=C2=A0 - slightly revamp commit message<br>
<br>
=C2=A0v2:<br>
=C2=A0 - add missing &quot;static&quot; modifier to set_openssl_env_vars() =
declaration<br>
spotted by gcc<br>
<br>
=C2=A0.../vcpkg-triplets/arm64-windows-ovpn.cmake=C2=A0 =C2=A0|=C2=A0 2 -<b=
r>
=C2=A0contrib/vcpkg-triplets/x64-windows-ovpn.cmake |=C2=A0 2 -<br>
=C2=A0contrib/vcpkg-triplets/x86-windows-ovpn.cmake |=C2=A0 2 -<br>
=C2=A0src/openvpn/buffer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 -----<br>
=C2=A0src/openvpn/crypto_openssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 -<br>
=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 88 +++++++++++++++++++<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +-<br>
=C2=A07 files changed, 95 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake b/contrib/vcpk=
g-triplets/arm64-windows-ovpn.cmake<br>
index 89f6a279..dd3c6c0a 100644<br>
--- a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake<br>
+++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake<br>
@@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)<br>
=C2=A0if(PORT STREQUAL &quot;lz4&quot;)<br>
=C2=A0 =C2=A0 =C2=A0set(VCPKG_LIBRARY_LINKAGE static)<br>
=C2=A0endif()<br>
-<br>
-set(OPENSSL_NO_AUTOLOAD_CONFIG ON)<br>
diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake b/contrib/vcpkg-=
triplets/x64-windows-ovpn.cmake<br>
index d860eed6..7036ed2d 100644<br>
--- a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake<br>
+++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake<br>
@@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)<br>
=C2=A0if(PORT STREQUAL &quot;lz4&quot;)<br>
=C2=A0 =C2=A0 =C2=A0set(VCPKG_LIBRARY_LINKAGE static)<br>
=C2=A0endif()<br>
-<br>
-set(OPENSSL_NO_AUTOLOAD_CONFIG ON)<br>
diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake b/contrib/vcpkg-=
triplets/x86-windows-ovpn.cmake<br>
index c1ea6ef3..7d3bf340 100644<br>
--- a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake<br>
+++ b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake<br>
@@ -5,5 +5,3 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)<br>
=C2=A0if(PORT STREQUAL &quot;lz4&quot;)<br>
=C2=A0 =C2=A0 =C2=A0set(VCPKG_LIBRARY_LINKAGE static)<br>
=C2=A0endif()<br>
-<br>
-set(OPENSSL_NO_AUTOLOAD_CONFIG ON)<br>
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c<br>
index c82d3d4d..54e758af 100644<br>
--- a/src/openvpn/buffer.c<br>
+++ b/src/openvpn/buffer.c<br>
@@ -310,29 +310,6 @@ openvpn_snprintf(char *str, size_t size, const char *f=
ormat, ...)<br>
=C2=A0 =C2=A0 =C2=A0return (len &gt;=3D 0 &amp;&amp; len &lt; size);<br>
=C2=A0}<br>
<br>
-/*<br>
- * openvpn_swprintf() is currently only used by Windows code paths<br>
- * and when enabled for all platforms it will currently break older<br>
- * OpenBSD versions lacking vswprintf(3) support in their libc.<br>
- */<br>
-<br>
-#ifdef _WIN32<br>
-bool<br>
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *con=
st format, ...)<br>
-{<br>
-=C2=A0 =C2=A0 va_list arglist;<br>
-=C2=A0 =C2=A0 int len =3D -1;<br>
-=C2=A0 =C2=A0 if (size &gt; 0)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_start(arglist, format);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D vswprintf(str, size, format, arglist);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_end(arglist);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 str[size - 1] =3D L&#39;\0&#39;;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return (len &gt;=3D 0 &amp;&amp; len &lt; size);<br>
-}<br>
-#endif<br>
-<br>
=C2=A0/*<br>
=C2=A0 * write a string to the end of a buffer that was<br>
=C2=A0 * truncated by buf_printf<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index c9dc9d0a..ef520928 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -154,13 +154,11 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0void<br>
=C2=A0crypto_init_lib(void)<br>
=C2=A0{<br>
-#ifndef _WIN32<br>
=C2=A0#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L)<br>
=C2=A0 =C2=A0 =C2=A0OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0OPENSSL_config(NULL);<br>
=C2=A0#endif<br>
-#endif /* _WIN32 */<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If you build the OpenSSL library and OpenVPN with<br>
=C2=A0 =C2=A0 =C2=A0 * CRYPTO_MDEBUG, you will get a listing of OpenSSL<br>
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
index 6cff17b2..ee4d3f66 100644<br>
--- a/src/openvpn/win32.c<br>
+++ b/src/openvpn/win32.c<br>
@@ -101,6 +101,12 @@ struct semaphore netcmd_semaphore; /* GLOBAL */<br>
=C2=A0 */<br>
=C2=A0static char *win_sys_path =3D NULL; /* GLOBAL */<br>
<br>
+/**<br>
+ * Set OpenSSL environment variables to a safe directory<br>
+ */<br>
+static void<br>
+set_openssl_env_vars();<br>
+<br>
=C2=A0void<br>
=C2=A0init_win32(void)<br>
=C2=A0{<br>
@@ -110,6 +116,8 @@ init_win32(void)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0window_title_clear(&amp;window_title);<br>
=C2=A0 =C2=A0 =C2=A0win32_signal_clear(&amp;win32_signal);<br>
+<br>
+=C2=A0 =C2=A0 set_openssl_env_vars();<br>
=C2=A0}<br>
<br>
=C2=A0void<br>
@@ -1509,4 +1517,84 @@ send_msg_iservice(HANDLE pipe, const void *data, siz=
e_t size,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+bool<br>
+openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t* con=
st format, ...)<br>
+{<br>
+=C2=A0 =C2=A0 va_list arglist;<br>
+=C2=A0 =C2=A0 int len =3D -1;<br>
+=C2=A0 =C2=A0 if (size &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_start(arglist, format);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D vswprintf(str, size, format, arglist);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_end(arglist);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 str[size - 1] =3D L&#39;\0&#39;;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return (len &gt;=3D 0 &amp;&amp; len &lt; size);<br>
+}<br>
+<br>
+static BOOL<br>
+get_install_path(WCHAR *path, DWORD size)<br>
+{<br>
+=C2=A0 =C2=A0 WCHAR reg_path[256];<br>
+=C2=A0 =C2=A0 HKEY key;<br>
+=C2=A0 =C2=A0 BOOL res =3D FALSE;<br>
+=C2=A0 =C2=A0 openvpn_swprintf(reg_path, _countof(reg_path), L&quot;SOFTWA=
RE\\&quot; PACKAGE_NAME);</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
+<br>
+=C2=A0 =C2=A0 LONG status =3D RegOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, =
0, KEY_READ, &amp;key);<br>
+=C2=A0 =C2=A0 if (status !=3D ERROR_SUCCESS)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* The default value of REG_KEY is the install path */<br>
+=C2=A0 =C2=A0 status =3D RegGetValueW(key, NULL, NULL, RRF_RT_REG_SZ, NULL=
, (LPBYTE)path, &amp;size);<br>
+=C2=A0 =C2=A0 res =3D status =3D=3D ERROR_SUCCESS;<br>
+<br>
+=C2=A0 =C2=A0 RegCloseKey(key);<br>
+<br>
+=C2=A0 =C2=A0 return res;<br>
+}<br>
+<br>
+static void<br>
+set_openssl_env_vars()<br>
+{<br>
+=C2=A0 =C2=A0 const WCHAR* ssl_fallback_dir =3D L&quot;C:\\Windows\\System=
32&quot;;<br>
+<br>
+=C2=A0 =C2=A0 WCHAR install_path[MAX_PATH] =3D { 0 };<br>
+=C2=A0 =C2=A0 if (!get_install_path(install_path, _countof(install_path)))=
<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if we cannot find installation path from th=
e registry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* use Windows directory as a fallback<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_swprintf(install_path, _countof(instal=
l_path), L&quot;%ls&quot;, ssl_fallback_dir);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if ((install_path[wcslen(install_path) - 1]) =3D=3D L&#39;\\=
&#39;)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 install_path[wcslen(install_path) - 1] =3D L&#=
39;\0&#39;;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 static struct {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR* name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR* value;<br>
+=C2=A0 =C2=A0 } ossl_env[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {L&quot;OPENSSL_CONF&quot;, L&quot;openssl.cnf=
&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {L&quot;OPENSSL_ENGINES&quot;, L&quot;engines&=
quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {L&quot;OPENSSL_MODULES&quot;, L&quot;modules&=
quot;}<br>
+=C2=A0 =C2=A0 };<br></blockquote><div><br></div><div>As you=C2=A0defined t=
his inside the function, it=C2=A0doesn&#39;t=C2=A0have to be static. Also, =
name and value could be const. Our preferred style is &quot;TYPE *val&quot;=
, not the &quot;TYPE* val&quot; used here and elsewhere in the patch. Neith=
er are worth a v5, IMO.</div><div>=C2=A0=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; SIZE(ossl_env); ++i)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _wgetenv_s(&amp;size, NULL, 0, ossl_env[i].nam=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WCHAR val[MAX_PATH] =3D {0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_swprintf(val, _countof(v=
al), L&quot;%ls\\ssl\\%ls&quot;, install_path, ossl_env[i].value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _wputenv_s(ossl_env[i].name, val=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h<br>
index 5d3371a0..4a992d91 100644<br>
--- a/src/openvpn/win32.h<br>
+++ b/src/openvpn/win32.h<br>
@@ -327,7 +327,13 @@ bool send_msg_iservice(HANDLE pipe, const void *data, =
size_t size,<br>
=C2=A0int<br>
=C2=A0openvpn_execve(const struct argv *a, const struct env_set *es, const =
unsigned int flags);<br>
<br>
-bool impersonate_as_system();<br>
+/*<br>
+ * openvpn_swprintf() is currently only used by Windows code paths<br>
+ * and when enabled for all platforms it will currently break older<br>
+ * OpenBSD versions lacking vswprintf(3) support in their libc.<br>
+ */<br>
+bool<br>
+openvpn_swprintf(wchar_t* const str, const size_t size, const wchar_t* con=
st format, ...);=C2=A0</blockquote><div><br>Now there is a duplicate declar=
ation in buffer.h which could be removed. Multiple declarations is not an e=
rror, so let it be...</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
=C2=A0#endif /* ifndef OPENVPN_WIN32_H */<br>
=C2=A0#endif /* ifdef _WIN32 */<br></blockquote><div><br></div><div>Acked-b=
y: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank"=
>selva.nair@...277...</a>&gt;</div></div></div>

--000000000000f1c89205d1827c0d--

