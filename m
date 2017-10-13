MIME-Version: 1.0
In-Reply-To: <20171012072440.8704-1-simon@...2293...>
References: <20171012072440.8704-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Thu, 12 Oct 2017 22:18:49 -0400
Message-ID: <CAKuzo_jUnvMkHwHXZ=cAre-=z7WACU0b2qKV27FyymfBTncX=g@...278...>
Content-Type: multipart/alternative; boundary="001a114c86ae38cad2055b64488b"
Subject: Re: [Openvpn-devel] [PATCH] Uniform snwprintf() across MinGW and
 MSVC compilers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c86ae38cad2055b64488b
Content-Type: text/plain; charset="UTF-8"

Hi,

For book keeping its easier if version 2 of a patch is sent to the same
thread as
the original (e.g., use --in-reply-to: <msgid> in git send-email) and
[PATCH v2 01/13]
in header.

Anyway, this one is v2 of [PATCH 01/13]
https://www.mail-archive.com/openvpn-devel@...282...
.net/msg15583.html

On Thu, Oct 12, 2017 at 3:24 AM, Simon Rozman <simon@...2293...> wrote:

> MinGW's snwprintf() is a replacement for ISO C's swprintf() used by
> MSVC.


A confusing statement as MinGW too has 'swprintf' and my suggestion
was to just use 'swprintf' both for mingw and MSVC. Then neither build
would depend on non-standard variants.

That said its fine if you want to keep this as just an MSVC compliance
patch..


> MSVC also provides _snwprintf(), however using it leads to
> unportable code.
>
> After a discussion with Selva Nair on devel mailing list, an agreement
> was reached to use swprintf() for MSVC builds.
>
> This patch uniforms snwprintf() usage while making it compile using
> MinGW and MSVC.
>
> Assigning _snwprintf() return value to unused variable was also removed
> at one occasion.
> ---
>  config-msvc.h                 | 3 ++-
>  src/openvpn/tun.c             | 2 +-
>  src/openvpnserv/interactive.c | 8 ++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/config-msvc.h b/config-msvc.h
> index 0bb153d..c940d15 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -93,9 +93,10 @@
>  #define strncasecmp strnicmp
>  #define strcasecmp _stricmp
>
> -#if _MSC_VER<1900
> +#if _MSC_VER < 1900
>  #define snprintf _snprintf
>  #endif
> +#define snwprintf swprintf


>  #if _MSC_VER < 1800
>  #define strtoull strtoul
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 3639718..9e3ca41 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
>      DWORD index;
>      ULONG aindex;
>      wchar_t wbuf[256];
> -    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
> +    snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>      wbuf [SIZE(wbuf) - 1] = 0;
>      if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
>      {
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 823b25b..a060a06 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -276,7 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count,
> LPHANDLE events)
>       * Same format as error messages (3 line string) with error = 0 in
>       * 0x%08x format, PID on line 2 and a description "Process ID" on
> line 3
>       */
> -    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
> +    snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>      buf[_countof(buf) - 1] = '\0';
>
>      WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
> @@ -1066,7 +1066,7 @@ RegisterDNS(LPVOID unused)
>
>      if (GetSystemDirectory(sys_path, MAX_PATH))
>      {
> -        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
> +        snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
>          ipcfg[MAX_PATH-1] = L'\0';
>      }
>
> @@ -1706,8 +1706,8 @@ RunOpenvpn(LPVOID p)
>      else if (exit_code != 0)
>      {
>          WCHAR buf[256];
> -        int len = _snwprintf(buf, _countof(buf),
> -                             L"OpenVPN exited with error: exit code =
> %lu", exit_code);
> +        snwprintf(buf, _countof(buf),
> +                  L"OpenVPN exited with error: exit code = %lu",
> exit_code);
>          buf[_countof(buf) - 1] =  L'\0';
>          ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
>      }
>

As said above, I would have replaced all _snwprintf and snwprintf by
swprintf and avoided the #define. That has the added advantage that mingw
builds also will no longer depend on the non-standard snwprintf.

Nevertheless I'm ok with this unless someone else objects.

Selva

--001a114c86ae38cad2055b64488b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>For book keeping its easier if vers=
ion 2 of a patch is sent to the same thread as</div><div>the original (e.g.=
, use --in-reply-to: &lt;<span class=3D"" id=3D":3c6.1" tabindex=3D"-1">msg=
id</span>&gt; in git send-email) and [PATCH v2 01/13]</div><div>in header.=
=C2=A0</div><div><br></div><div>Anyway, this one is v2 of [PATCH 01/13]=C2=
=A0</div><div><a href=3D"https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg15583.html" target=3D"_blank">https://www.mail-archive.co=
m/o<wbr><span class=3D"" id=3D":3c6.2" tabindex=3D"-1">penvpn</span>-<span =
class=3D"" id=3D":3c6.3" tabindex=3D"-1">devel</span>@lists.<span class=3D"=
" id=3D":3c6.4" tabindex=3D"-1">sourceforge</span><wbr>.net/msg15583.html</=
a></div><div><br><div><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
>On Thu, Oct 12, 2017 at 3:24 AM, Simon <span class=3D"" id=3D":3c6.5" tabi=
ndex=3D"-1">Rozman</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:simon@...493...=
2293..." target=3D"_blank"><span class=3D"" id=3D":3c6.6" tabindex=3D"-1">s=
imon</span>@<span class=3D"" id=3D":3c6.7" tabindex=3D"-1">rozman</span>.<s=
pan class=3D"" id=3D":3c6.8" tabindex=3D"-1">si</span></a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">MinGW&#39;s snwprint=
f() is a replacement for ISO C&#39;s swprintf() used by<br>
MSVC. </blockquote><div><br></div><div>A confusing statement as <span class=
=3D"" id=3D":3c6.9" tabindex=3D"-1">MinGW</span> too has &#39;swprintf&#39;=
 and my suggestion</div><div>was to just use &#39;swprintf&#39; both for <s=
pan class=3D"" id=3D":3c6.10" tabindex=3D"-1">mingw</span> and <span class=
=3D"" id=3D":3c6.11" tabindex=3D"-1">MSVC</span>. Then neither build</div><=
div>would depend on non-standard variants.</div><div><br></div><div>That sa=
id its fine if you want to keep this as just an=C2=A0<span class=3D"" id=3D=
":3c6.12" tabindex=3D"-1">MSVC</span> compliance patch..</div><div>=C2=A0=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">MSVC also pro=
vides _snwprintf(), however using it leads to<br>
unportable code.<br>
<br>
After a discussion with Selva Nair on devel mailing list, an agreement<br>
was reached to use swprintf() for MSVC builds.<br>
<br>
This patch uniforms snwprintf() usage while making it compile using<br>
MinGW and MSVC.<br>
<br>
Assigning _snwprintf() return value to unused variable was also removed<br>
at one occasion.<br>
---<br>
=C2=A0config-msvc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 3 ++-<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 =
+-<br>
=C2=A0src/openvpnserv/interactive.c | 8 ++++----<br>
=C2=A03 files changed, 7 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/config-msvc.h b/config-msvc.h<br>
index 0bb153d..c940d15 100644<br>
--- a/config-msvc.h<br>
+++ b/config-msvc.h<br>
@@ -93,9 +93,10 @@<br>
=C2=A0#define strncasecmp strnicmp<br>
=C2=A0#define strcasecmp _stricmp<br>
<br>
-#if _MSC_VER&lt;1900<br>
+#if _MSC_VER &lt; 1900<br>
=C2=A0#define snprintf _snprintf<br>
=C2=A0#endif<br>
+#define snwprintf swprintf=C2=A0</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
=C2=A0#if _MSC_VER &lt; 1800<br>
=C2=A0#define strtoull strtoul<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 3639718..9e3ca41 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4622,7 +4622,7 @@ get_adapter_index_method_1(con<wbr>st char *guid)<br>
=C2=A0 =C2=A0 =C2=A0DWORD index;<br>
=C2=A0 =C2=A0 =C2=A0ULONG aindex;<br>
=C2=A0 =C2=A0 =C2=A0wchar_t wbuf[256];<br>
-=C2=A0 =C2=A0 _snwprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TCPIP_%S&quot;=
, guid);<br>
+=C2=A0 =C2=A0 snwprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TCPIP_%S&quot;,=
 guid);<br>
=C2=A0 =C2=A0 =C2=A0wbuf [SIZE(wbuf) - 1] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0if (GetAdapterIndex(wbuf, &amp;aindex) !=3D NO_ERROR)<b=
r>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 823b25b..a060a06 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -276,7 +276,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LP=
HANDLE events)<br>
=C2=A0 =C2=A0 =C2=A0 * Same format as error messages (3 line string) with e=
rror =3D 0 in<br>
=C2=A0 =C2=A0 =C2=A0 * 0x%08x format, PID on line 2 and a description &quot=
;Process ID&quot; on line 3<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 _snwprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%s&quo=
t;, 0, pid, msg);<br>
+=C2=A0 =C2=A0 snwprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%s&quot=
;, 0, pid, msg);<br>
=C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D &#39;\0&#39;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, event=
s);<br>
@@ -1066,7 +1066,7 @@ RegisterDNS(LPVOID unused)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (GetSystemDirectory(sys_path, MAX_PATH))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 _snwprintf(ipcfg, MAX_PATH, L&quot;%s\\%s&quot=
;, sys_path, L&quot;ipconfig.exe&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(ipcfg, MAX_PATH, L&quot;%s\\%s&quot;=
, sys_path, L&quot;ipconfig.exe&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipcfg[MAX_PATH-1] =3D L&#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1706,8 +1706,8 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0else if (exit_code !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WCHAR buf[256];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D _snwprintf(buf, _countof(buf),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;OpenVPN exited with error: exit code =
=3D %lu&quot;, exit_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(buf, _countof(buf),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;Open=
VPN exited with error: exit code =3D %lu&quot;, exit_code);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D=C2=A0 L&#39;\0=
&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ReturnError(pipe, ERROR_OPENVPN_STARTUP, =
buf, 1, &amp;exit_event);<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>As said above, I =
would have replaced all _<span class=3D"" id=3D":3c6.13" tabindex=3D"-1">sn=
wprintf</span> and <span class=3D"" id=3D":3c6.14" tabindex=3D"-1">snwprint=
f</span> by</div><div><span class=3D"" id=3D":3c6.15" tabindex=3D"-1">swpri=
ntf</span> and avoided the #define. That has the added advantage that <span=
 class=3D"" id=3D":3c6.16" tabindex=3D"-1">mingw</span></div><div>builds al=
so will no longer depend on the non-standard <span class=3D"" id=3D":3c6.17=
" tabindex=3D"-1">snwprintf</span>.</div><div><br></div><div>Nevertheless I=
&#39;m <span class=3D"" id=3D":3c6.18" tabindex=3D"-1">ok</span> with this =
unless someone else objects.</div><div><br></div><div><span class=3D"" id=
=3D":3c6.19" tabindex=3D"-1">Selva</span></div></div></div></div></div></di=
v>

--001a114c86ae38cad2055b64488b--

