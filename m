MIME-Version: 1.0
References: <20211118205229.303-1-lstipakov@...277...>
 <20211118212945.478-1-lstipakov@...277...>
In-Reply-To: <20211118212945.478-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Nov 2021 11:38:43 -0500
Message-ID: <CAKuzo_hQK-Hqk_LqUegkugZAZiEBjPVqtH5qVfONhWZ-zT9FpQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000d589e805d17760b7"
Subject: Re: [Openvpn-devel] [PATCH v2] Load OpenSSL config on Windows from
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

--000000000000d589e805d17760b7
Content-Type: text/plain; charset="UTF-8"

Hi,

+1 for setting these env vars. I will test this but some quick comments

On Tue, Nov 23, 2021 at 10:08 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Commit 7e33127d5 ("contrib/vcpkg-ports: remove openssl port")
> disabled OpenSSL config loading to prevent loading config
> from untrusted locations.
>
> Config loading feature might be useful for some users. This
> brings it back, and sets OpenSSL enviroment variables
>
>  OPENSSL_CONF, OPENSSL_ENGINES, OPENSSL_MODULES
>
> which are used to load config, engines and modules, to a trusted location.
> The location is built based on installation path, read from registry on
> startup.
> If installation path cannot be read, Windows\System32 is used as a
> fallback.
>
> While on it, remove unused "bool impersonate_as_system();" declaration.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2: add missing "static" modifier to set_openssl_env_vars()
> declaration noted by gcc
>
>  .../vcpkg-triplets/arm64-windows-ovpn.cmake   |  2 -
>  contrib/vcpkg-triplets/x64-windows-ovpn.cmake |  2 -
>  contrib/vcpkg-triplets/x86-windows-ovpn.cmake |  2 -
>  src/openvpn/buffer.c                          | 23 ------
>  src/openvpn/win32.c                           | 76 +++++++++++++++++++
>  src/openvpn/win32.h                           |  8 +-
>  6 files changed, 83 insertions(+), 30 deletions(-)
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
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 6cff17b2..ebc7c833 100644
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
> @@ -1509,4 +1517,72 @@ send_msg_iservice(HANDLE pipe, const void *data,
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
>

Does this string concatenation like L"foo" "bar" work correctly on MSVC? I
know it works on mingw, but in the past with the GUI resources we had run
into issues with such usage -- iirc, MSVC wanted L"foo" L"bar".


> +
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
> +    const WCHAR* ssl_fallback_dir = L"C:\\Windows\\System32\\";
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
>

Is this registry value guaranteed to end with the directory separator "\\"?
Should we check it? If so, it may be easier to strip it here and add in the
format with no ending "\\" in the default above.


> +
> +    WCHAR openssl_cnf[MAX_PATH] = {0};
> +    WCHAR openssl_engines[MAX_PATH] = {0};
> +    WCHAR openssl_modules[MAX_PATH] = {0};
>

On linux one needs strings on the heap or const strings for putenv() as it
does not make a copy unlike setenv (with some exceptions).  Does _wputenv
on Windows behave differently? Do local variables work?


> +
> +    openvpn_swprintf(openssl_cnf, _countof(install_path),
> +        L"OPENSSL_CONF=%lsssl\\openssl.cnf", install_path);
> +    openvpn_swprintf(openssl_engines, _countof(openssl_engines),
> +        L"OPENSSL_ENGINES=%lsssl\\engines", install_path);
> +    openvpn_swprintf(openssl_modules, _countof(openssl_modules),
> +        L"OPENSSL_MODULES=%lsssl\\modules", install_path);
> +
> +    _wputenv(openssl_cnf);
> +    _wputenv(openssl_engines);
> +    _wputenv(openssl_modules);
>

I think we should set these only if not already set. Otherwise the user has
no way of overriding these locations which is the original purpose of env
vars.


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
>
>  #endif /* ifndef OPENVPN_WIN32_H */
>  #endif /* ifdef _WIN32 */
> --


Commit message says this brings back config loading but the config loading
in crypto_openssl.c stays disabled for Windows. An oversight?

Selva

--000000000000d589e805d17760b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div><br></div>+1 for=C2=A0setti=
ng these env vars. I will test this but some quick comments<div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 23, 2=
021 at 10:08 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." tar=
get=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:=
lev@...515..." target=3D"_blank">lev@...515...</a>&gt;<br>
<br>
Commit 7e33127d5 (&quot;contrib/vcpkg-ports: remove openssl port&quot;)<br>
disabled OpenSSL config loading to prevent loading config<br>
from untrusted locations.<br>
<br>
Config loading feature might be useful for some users. This<br>
brings it back, and sets OpenSSL enviroment variables<br>
<br>
=C2=A0OPENSSL_CONF, OPENSSL_ENGINES, OPENSSL_MODULES<br>
<br>
which are used to load config, engines and modules, to a trusted location.<=
br>
The location is built based on installation path, read from registry on sta=
rtup.<br>
If installation path cannot be read, Windows\System32 is used as a fallback=
.<br>
<br>
While on it, remove unused &quot;bool impersonate_as_system();&quot; declar=
ation.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v2: add missing &quot;static&quot; modifier to set_openssl_env_vars()=
<br>
declaration noted by gcc<br>
<br>
=C2=A0.../vcpkg-triplets/arm64-windows-ovpn.cmake=C2=A0 =C2=A0|=C2=A0 2 -<b=
r>
=C2=A0contrib/vcpkg-triplets/x64-windows-ovpn.cmake |=C2=A0 2 -<br>
=C2=A0contrib/vcpkg-triplets/x86-windows-ovpn.cmake |=C2=A0 2 -<br>
=C2=A0src/openvpn/buffer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 ------<br>
=C2=A0src/openvpn/win32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 76 +++++++++++++++++++<br>
=C2=A0src/openvpn/win32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +-<br>
=C2=A06 files changed, 83 insertions(+), 30 deletions(-)<br>
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
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c<br>
index 6cff17b2..ebc7c833 100644<br>
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
@@ -1509,4 +1517,72 @@ send_msg_iservice(HANDLE pipe, const void *data, siz=
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
RE\\&quot; PACKAGE_NAME);<br></blockquote><div><br></div><div>Does this=C2=
=A0string concatenation like L&quot;foo&quot; &quot;bar&quot; work correctl=
y on MSVC? I know it works on mingw, but in the past with the GUI resources=
 we had run into issues with such usage -- iirc, MSVC wanted L&quot;foo&quo=
t; L&quot;bar&quot;.</div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
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
32\\&quot;;<br>
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
</blockquote><div><br></div><div>Is this registry value guaranteed to end w=
ith the directory separator &quot;\\&quot;? Should we check it? If so, it m=
ay be easier to strip it here and add in the format with no ending &quot;\\=
&quot; in the default above.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">+<br>
+=C2=A0 =C2=A0 WCHAR openssl_cnf[MAX_PATH] =3D {0};<br>
+=C2=A0 =C2=A0 WCHAR openssl_engines[MAX_PATH] =3D {0};<br>
+=C2=A0 =C2=A0 WCHAR openssl_modules[MAX_PATH] =3D {0};<br></blockquote><di=
v><br></div><div>On linux one needs strings on the heap or const strings fo=
r putenv() as it does not make a copy unlike setenv (with some exceptions).=
=C2=A0 Does _wputenv on Windows behave differently? Do local variables work=
?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+<br>
+=C2=A0 =C2=A0 openvpn_swprintf(openssl_cnf, _countof(install_path),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;OPENSSL_CONF=3D%lsssl\\openssl.cnf&quot=
;, install_path);<br>
+=C2=A0 =C2=A0 openvpn_swprintf(openssl_engines, _countof(openssl_engines),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;OPENSSL_ENGINES=3D%lsssl\\engines&quot;=
, install_path);<br>
+=C2=A0 =C2=A0 openvpn_swprintf(openssl_modules, _countof(openssl_modules),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;OPENSSL_MODULES=3D%lsssl\\modules&quot;=
, install_path);<br>
+<br>
+=C2=A0 =C2=A0 _wputenv(openssl_cnf);<br>
+=C2=A0 =C2=A0 _wputenv(openssl_engines);<br>
+=C2=A0 =C2=A0 _wputenv(openssl_modules);<br></blockquote><div><br></div><d=
iv>I think we should set these only if not already set. Otherwise the user =
has no way of overriding these locations which is the original purpose of e=
nv vars.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
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
st format, ...);<br>
<br>
=C2=A0#endif /* ifndef OPENVPN_WIN32_H */<br>
=C2=A0#endif /* ifdef _WIN32 */<br>
--</blockquote><div><br></div><div>Commit message says this brings back con=
fig loading but the config loading in crypto_openssl.c stays disabled for W=
indows. An oversight?</div><div><br></div><div>Selva</div></div></div></div>

--000000000000d589e805d17760b7--

