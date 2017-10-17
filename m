MIME-Version: 1.0
In-Reply-To: <20171013095008.8288-1-simon@...2293...>
References: <99D61A626FDA8A4B90A270669121BE108580F7E3@...2294...>
 <20171013095008.8288-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Tue, 17 Oct 2017 12:56:55 -0400
Message-ID: <CAKuzo_hLD9EXEf=qc_C6aYK2BN0wX--5sra4ZQ_JD2=hVFJOeg@...278...>
Content-Type: multipart/alternative; boundary="001a1138e726e6a003055bc103ee"
Subject: Re: [Openvpn-devel] [PATCH] Uniform swprintf() across MinGW and
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

--001a1138e726e6a003055bc103ee
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Oct 13, 2017 at 5:50 AM, Simon Rozman <simon@...2293...> wrote:

> Legacy _snwprintf() and snwprintf() functions replaced with ISO C
> swprintf().
>
> Assigning _snwprintf() return value to unused variable was also removed
> at one occasion.
> ---
>  src/openvpn/tun.c             |  2 +-
>  src/openvpnserv/interactive.c | 20 ++++++++++----------
>  src/openvpnserv/validate.c    |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 3639718..25831ce 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -4622,7 +4622,7 @@ get_adapter_index_method_1(const char *guid)
>      DWORD index;
>      ULONG aindex;
>      wchar_t wbuf[256];
> -    _snwprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
> +    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>      wbuf [SIZE(wbuf) - 1] = 0;
>      if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
>      {
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 0b57eb9..0169617 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -277,7 +277,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count,
> LPHANDLE events)
>       * Same format as error messages (3 line string) with error = 0 in
>       * 0x%08x format, PID on line 2 and a description "Process ID" on
> line 3
>       */
> -    _snwprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
> +    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%s", 0, pid, msg);
>      buf[_countof(buf) - 1] = '\0';
>
>      WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, events);
> @@ -403,8 +403,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir,
> const WCHAR *options)
>
>          if (!CheckOption(workdir, 2, argv_tmp, &settings))
>          {
> -            snwprintf(buf, _countof(buf), msg1, argv[0], workdir,
> -                      settings.ovpn_admin_group);
> +            swprintf(buf, _countof(buf), msg1, argv[0], workdir,
> +                     settings.ovpn_admin_group);
>              buf[_countof(buf) - 1] = L'\0';
>              ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
>          }
> @@ -422,15 +422,15 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir,
> const WCHAR *options)
>          {
>              if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
>              {
> -                snwprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
> -                          settings.ovpn_admin_group);
> +                swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
> +                         settings.ovpn_admin_group);
>                  buf[_countof(buf) - 1] = L'\0';
>                  ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1,
> &exit_event);
>              }
>              else
>              {
> -                snwprintf(buf, _countof(buf), msg2, argv[i],
> -                          settings.ovpn_admin_group);
> +                swprintf(buf, _countof(buf), msg2, argv[i],
> +                         settings.ovpn_admin_group);
>                  buf[_countof(buf) - 1] = L'\0';
>                  ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1,
> &exit_event);
>              }
> @@ -1067,7 +1067,7 @@ RegisterDNS(LPVOID unused)
>
>      if (GetSystemDirectory(sys_path, MAX_PATH))
>      {
> -        _snwprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
> +        swprintf(ipcfg, MAX_PATH, L"%s\\%s", sys_path, L"ipconfig.exe");
>          ipcfg[MAX_PATH-1] = L'\0';
>      }
>
> @@ -1707,8 +1707,8 @@ RunOpenvpn(LPVOID p)
>      else if (exit_code != 0)
>      {
>          WCHAR buf[256];
> -        int len = _snwprintf(buf, _countof(buf),
> -                             L"OpenVPN exited with error: exit code =
> %lu", exit_code);
> +        swprintf(buf, _countof(buf),
> +                 L"OpenVPN exited with error: exit code = %lu",
> exit_code);
>          buf[_countof(buf) - 1] =  L'\0';
>          ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
>      }
> diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
> index f6a97e9..653bd12 100644
> --- a/src/openvpnserv/validate.c
> +++ b/src/openvpnserv/validate.c
> @@ -65,7 +65,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR
> *fname, const settings_t *s)
>      /* convert fname to full path */
>      if (PathIsRelativeW(fname) )
>      {
> -        snwprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
> +        swprintf(tmp, _countof(tmp), L"%s\\%s", workdir, fname);
>          tmp[_countof(tmp)-1] = L'\0';
>          config_file = tmp;
>      }
>

Apart from making MSVC compliant,  this unifies varied usages of
snwprintf's in the code, converts all into the standard swprintf, and still
works with mingw-w64.

Compile tested using mingw-w64 4.0.4 in ubuntu 16.04 and using
3.1.0 in ubuntu 14.04[*]

ACK

Selva

[*] Ubuntu 14.04 needs some tweaks to correctly compile and link
for reasons unrelated to this patch.

--001a1138e726e6a003055bc103ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Fri, Oct 13, 2017 at 5:50 AM, Simon Rozman <span dir=3D"ltr">&lt;<=
a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Legacy _snwprintf() and =
snwprintf() functions replaced with ISO C<br>
swprintf().<br>
<br>
Assigning _snwprintf() return value to unused variable was also removed<br>
at one occasion.<br>
---<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
=C2=A0src/openvpnserv/interactive.c | 20 ++++++++++----------<br>
=C2=A0src/openvpnserv/validate.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A03 files changed, 12 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 3639718..25831ce 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -4622,7 +4622,7 @@ get_adapter_index_method_1(con<wbr>st char *guid)<br>
=C2=A0 =C2=A0 =C2=A0DWORD index;<br>
=C2=A0 =C2=A0 =C2=A0ULONG aindex;<br>
=C2=A0 =C2=A0 =C2=A0wchar_t wbuf[256];<br>
-=C2=A0 =C2=A0 _snwprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TCPIP_%S&quot;=
, guid);<br>
+=C2=A0 =C2=A0 swprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TCPIP_%S&quot;, =
guid);<br>
=C2=A0 =C2=A0 =C2=A0wbuf [SIZE(wbuf) - 1] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0if (GetAdapterIndex(wbuf, &amp;aindex) !=3D NO_ERROR)<b=
r>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 0b57eb9..0169617 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -277,7 +277,7 @@ ReturnProcessId(HANDLE pipe, DWORD pid, DWORD count, LP=
HANDLE events)<br>
=C2=A0 =C2=A0 =C2=A0 * Same format as error messages (3 line string) with e=
rror =3D 0 in<br>
=C2=A0 =C2=A0 =C2=A0 * 0x%08x format, PID on line 2 and a description &quot=
;Process ID&quot; on line 3<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 _snwprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%s&quo=
t;, 0, pid, msg);<br>
+=C2=A0 =C2=A0 swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x\n%s&quot;=
, 0, pid, msg);<br>
=C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D &#39;\0&#39;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0WritePipeAsync(pipe, buf, wcslen(buf) * 2, count, event=
s);<br>
@@ -403,8 +403,8 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, cons=
t WCHAR *options)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!CheckOption(workdir, 2, argv_tmp, &a=
mp;settings))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(buf, _countof(buf), ms=
g1, argv[0], workdir,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 settings.ovpn_admin_group);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(buf, _countof(buf), msg=
1, argv[0], workdir,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0settings.ovpn_admin_group);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D =
L&#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ReturnError(pipe, ERROR_STA=
RTUP_DATA, buf, 1, &amp;exit_event);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -422,15 +422,15 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, co=
nst WCHAR *options)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (wcscmp(L&quot;--config&=
quot;, argv[i]) =3D=3D 0 &amp;&amp; argc-i &gt; 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(buf, _co=
untof(buf), msg1, argv[i+1], workdir,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 settings.ovpn_admin_group);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(buf, _cou=
ntof(buf), msg1, argv[i+1], workdir,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0settings.ovpn_admin_group);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[_countof(=
buf) - 1] =3D L&#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ReturnError(p=
ipe, ERROR_STARTUP_DATA, buf, 1, &amp;exit_event);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(buf, _co=
untof(buf), msg2, argv[i],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 settings.ovpn_admin_group);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(buf, _cou=
ntof(buf), msg2, argv[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0settings.ovpn_admin_group);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[_countof(=
buf) - 1] =3D L&#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ReturnError(p=
ipe, ERROR_STARTUP_DATA, buf, 1, &amp;exit_event);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1067,7 +1067,7 @@ RegisterDNS(LPVOID unused)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (GetSystemDirectory(sys_path, MAX_PATH))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 _snwprintf(ipcfg, MAX_PATH, L&quot;%s\\%s&quot=
;, sys_path, L&quot;ipconfig.exe&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(ipcfg, MAX_PATH, L&quot;%s\\%s&quot;,=
 sys_path, L&quot;ipconfig.exe&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipcfg[MAX_PATH-1] =3D L&#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1707,8 +1707,8 @@ RunOpenvpn(LPVOID p)<br>
=C2=A0 =C2=A0 =C2=A0else if (exit_code !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WCHAR buf[256];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D _snwprintf(buf, _countof(buf),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;OpenVPN exited with error: exit code =
=3D %lu&quot;, exit_code);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(buf, _countof(buf),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;OpenV=
PN exited with error: exit code =3D %lu&quot;, exit_code);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[_countof(buf) - 1] =3D=C2=A0 L&#39;\0=
&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ReturnError(pipe, ERROR_OPENVPN_STARTUP, =
buf, 1, &amp;exit_event);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c<br>
index f6a97e9..653bd12 100644<br>
--- a/src/openvpnserv/validate.c<br>
+++ b/src/openvpnserv/validate.c<br>
@@ -65,7 +65,7 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname,=
 const settings_t *s)<br>
=C2=A0 =C2=A0 =C2=A0/* convert fname to full path */<br>
=C2=A0 =C2=A0 =C2=A0if (PathIsRelativeW(fname) )<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 snwprintf(tmp, _countof(tmp), L&quot;%s\\%s&qu=
ot;, workdir, fname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 swprintf(tmp, _countof(tmp), L&quot;%s\\%s&quo=
t;, workdir, fname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp[_countof(tmp)-1] =3D L&#39;\0&#39;;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_file =3D tmp;<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Apart from making=
 MSVC compliant, =C2=A0this unifies varied usages of</div><div>snwprintf&#3=
9;s in the code, converts all into the standard swprintf, and still</div><d=
iv>works with mingw-w64.=C2=A0</div><div><br></div><div>Compile tested usin=
g mingw-w64 4.0.4 in ubuntu 16.04 and using=C2=A0</div><div>3.1.0 in ubuntu=
 14.04[*]</div><div><br></div><div>ACK</div><div><br></div><div>Selva</div>=
<div><br></div><div>[*] Ubuntu 14.04 needs some tweaks to correctly compile=
 and link</div><div>for reasons unrelated to this patch.</div></div></div><=
/div>

--001a1138e726e6a003055bc103ee--

