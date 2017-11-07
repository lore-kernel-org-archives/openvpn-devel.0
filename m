MIME-Version: 1.0
In-Reply-To: <20171105223714.7852-1-simon@...2293...>
References: <CAKuzo_iOXui4WDuRqf6-NybpfeWNjKR3GLn7dsw98FoNoSHNMw@...278...>
 <20171105223714.7852-1-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Tue, 7 Nov 2017 00:14:54 -0500
Message-ID: <CAKuzo_gsuMMhThtx4UvWoHP9ipT4x_KEFewBxh00z=h4xkc4ow@...278...>
Content-Type: multipart/alternative; boundary="001a1138e726005c38055d5da8a7"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: Add support for
 multi-instances
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

--001a1138e726005c38055d5da8a7
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Nov 5, 2017 at 5:37 PM, Simon Rozman <simon@...2293...> wrote:
>
> While openvpn.exe can run multiple concurrent processes, openvpnserv.exe
> is usually only one single globally unique running process.
>
> This patch extends openvpnserv.exe to support multiple service instances
> in parallel allowing side-by-side OpenVPN installations.
>
> Alternate instances must be installed as `SERVICE_WIN32_OWN_PROCESS`
> (Type 0x10) and must use the newly introduced service command line
> parameter:
> -instance <name> <id>
> <name> can be `automatic` or `interactive`.

Looks good and works as promised.

Some comments + nitpicking below.

> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 4123d0f..ff5c1a2 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -44,7 +44,7 @@
>  #define false 0
>
>  static SERVICE_STATUS_HANDLE service;
> -static SERVICE_STATUS status;
> +static SERVICE_STATUS status = { SERVICE_WIN32_SHARE_PROCESS };

While this is correct, making use of C99's designated init like

      {.dwServiceType = SERVICE_WIN32_SHARE_PROCESS}

would be better and clearer.

<snip>

>      if (!exit_event)
>      {
>          MsgToEventLog(M_ERR, TEXT("CreateEvent failed"));
> @@ -327,8 +327,8 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
>                                    TEXT("%s\\%s"), settings.log_dir,
log_file);
>
>                  /* construct command line */
> -                openvpn_sntprintf(command_line, _countof(command_line),
TEXT(PACKAGE " --service %s 1 --config \"%s\""),
> -                                  EXIT_EVENT_NAME,
> +                openvpn_sntprintf(command_line, _countof(command_line),
TEXT("openvpn --service \"%s_exit_1\" 1 --config \"%s\""),
> +                                  service_instance,

The change PACKAGE -> openvpn is not a regression because the
first word of command line (argv[0]) is not used while launching the
process,
right? Instead, the exe_path is used to find the executable.

However, argv[0] will no longer track PACKAGE but stay fixed at "openvpn".
Hopefully no one cares. I'm fine with this as official builds see no
difference.

<snip>

> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 0d162e8..649a9a8 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -53,7 +53,7 @@
>  #define ERROR_MESSAGE_TYPE     0x20000003
>
>  static SERVICE_STATUS_HANDLE service;
> -static SERVICE_STATUS status;
> +static SERVICE_STATUS status = { SERVICE_WIN32_SHARE_PROCESS };

same as above... {.dwServiceType = ... }

<snip>

> diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
> index b79e999..232b33e 100644
> --- a/src/openvpnserv/service.c
> +++ b/src/openvpnserv/service.c
> @@ -223,46 +223,77 @@ out:
>  int
>  _tmain(int argc, TCHAR *argv[])
>  {
> -    SERVICE_TABLE_ENTRY dispatchTable[] = {
> +    SERVICE_TABLE_ENTRY dispatchTable_shared[] = {
>          { automatic_service.name, ServiceStartAutomatic },
>          { interactive_service.name, ServiceStartInteractive },
>          { NULL, NULL }
>      };
> +    const SERVICE_TABLE_ENTRY *dispatchTable = dispatchTable_shared;
>
>      openvpn_service[0] = automatic_service;
>      openvpn_service[1] = interactive_service;
>
> -    if (argc > 1 && (*argv[1] == TEXT('-') || *argv[1] == TEXT('/')))
> +    for (int i = 1; i < argc; i++)
>      {
> -        if (_tcsicmp(TEXT("install"), argv[1] + 1) == 0)
> +        if (*argv[i] == TEXT('-') || *argv[i] == TEXT('/'))
>          {
> -            return CmdInstallServices();
> -        }
> -        else if (_tcsicmp(TEXT("remove"), argv[1] + 1) == 0)
> -        {
> -            return CmdRemoveServices();
> -        }
> -        else if (_tcsicmp(TEXT("start"), argv[1] + 1) == 0)
> -        {
> -            BOOL is_auto = argc < 3 || _tcsicmp(TEXT("interactive"),
argv[2]) != 0;
> -            return CmdStartService(is_auto ? automatic : interactive);
> -        }
> -        else
> -        {
> -            goto dispatch;
> +            if (_tcsicmp(TEXT("install"), argv[i] + 1) == 0)
> +            {
> +                return CmdInstallServices();
> +            }
> +            else if (_tcsicmp(TEXT("remove"), argv[i] + 1) == 0)
> +            {
> +                return CmdRemoveServices();
> +            }
> +            else if (_tcsicmp(TEXT("start"), argv[i] + 1) == 0)
> +            {
> +                BOOL is_auto = argc < i + 2 ||
_tcsicmp(TEXT("interactive"), argv[i + 1]) != 0;
> +                return CmdStartService(is_auto ? automatic :
interactive);
> +            }
> +            else if (argc > i + 2 && _tcsicmp(TEXT("instance"), argv[i]
+ 1) == 0)
> +            {
> +                /* When running as an alternate instance, we are invoked
as
> +                 * SERVICE_WIN32_OWN_PROCESS - we are the one and only
> +                 * service in this process. The dispatch table should
> +                 * reflect that.
> +                 */
> +                static const SERVICE_TABLE_ENTRY
dispatchTable_automatic[] = {
> +                    { TEXT(""), ServiceStartAutomaticOwn },
> +                    { NULL, NULL }
> +                };

Agreed this array has to live beyond the for loop, but why static? Statics
live for ever while this need not exist beyond the function. Putting it at
the
top where dispatchTable_shared is defined (or anywhere before the loop)
as a non-static variable would be the way to go?

> +                static const SERVICE_TABLE_ENTRY
dispatchTable_interactive[] = {
> +                    { TEXT(""), ServiceStartInteractiveOwn },
> +                    { NULL, NULL }
> +                };

Same here.

<snip>

Finally, we could add the instance name to the eventlog output.
MsgToEventLog
prints errors as "APPNAME error: ...." where APPNAME is "openvpnserv".
E.g., add " (instance_name)" after APPNAME?

Thanks,

Selva

--001a1138e726005c38055d5da8a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On Sun, Nov 5, 2017 at 5:37 PM, Simon Rozman &l=
t;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a=
>&gt; wrote:<br>&gt;<br>&gt; While openvpn.exe can run multiple concurrent =
processes, openvpnserv.exe<br>&gt; is usually only one single globally uniq=
ue running process.<br>&gt;<br>&gt; This patch extends openvpnserv.exe to s=
upport multiple service instances<br>&gt; in parallel allowing side-by-side=
 OpenVPN installations.<br>&gt;<br>&gt; Alternate instances must be install=
ed as `SERVICE_WIN32_OWN_PROCESS`<br>&gt; (Type 0x10) and must use the newl=
y introduced service command line<br>&gt; parameter:<br>&gt; -instance &lt;=
name&gt; &lt;id&gt;<br>&gt; &lt;name&gt; can be `automatic` or `interactive=
`.<div><br></div><div>Looks good and works as promised.<br></div><div><br><=
/div><div>Some comments + nitpicking below.</div><div><br>&gt; diff --git a=
/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c<br>&gt; index 41=
23d0f..ff5c1a2 100644<br>&gt; --- a/src/openvpnserv/automatic.c<br>&gt; +++=
 b/src/openvpnserv/automatic.c<br>&gt; @@ -44,7 +44,7 @@<br>&gt; =C2=A0#def=
ine false 0<br>&gt;<br>&gt; =C2=A0static SERVICE_STATUS_HANDLE service;<br>=
&gt; -static SERVICE_STATUS status;<br>&gt; +static SERVICE_STATUS status =
=3D { SERVICE_WIN32_SHARE_PROCESS };<br><br>While this is correct, making u=
se of C99&#39;s designated init like</div><div><br>=C2=A0 =C2=A0 =C2=A0 {.d=
wServiceType =3D SERVICE_WIN32_SHARE_PROCESS}<br><br></div><div>would be be=
tter and clearer.<br><br></div><div>&lt;snip&gt;</div><div><br>&gt; =C2=A0 =
=C2=A0 =C2=A0if (!exit_event)<br>&gt; =C2=A0 =C2=A0 =C2=A0{<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MsgToEventLog(M_ERR, TEXT(&quot;CreateEvent fail=
ed&quot;));<br>&gt; @@ -327,8 +327,8 @@ ServiceStartAutomatic(DWORD dwArgc,=
 LPTSTR *lpszArgv)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TEXT(&quot;%s\\%s&quot;), settings.log_dir, log_file);<br>&gt;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* construct =
command line */<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0openvpn_sntprintf(command_lin<wbr>e, _countof(command_line), TEXT(PAC=
KAGE &quot; --service %s 1 --config \&quot;%s\&quot;&quot;),<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXIT_EVENT_NAME,<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openvpn_sntprintf(command_l=
in<wbr>e, _countof(command_line), TEXT(&quot;openvpn --service \&quot;%s_ex=
it_1\&quot; 1 --config \&quot;%s\&quot;&quot;),<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0service_instance,<br><br><div>The change PACKAGE=
 -&gt; openvpn is not a regression because the</div><div>first word of comm=
and line (argv[0]) is not used while launching the process,</div><div>right=
? Instead, the exe_path is used to find the executable.=C2=A0</div><div><br=
></div><div>However, argv[0] will no longer track PACKAGE but stay fixed at=
 &quot;openvpn&quot;.</div><div>Hopefully no one cares. I&#39;m fine with t=
his as official builds see no difference.</div><div><br>&lt;snip&gt;</div><=
div><br>&gt; diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpns=
erv/interactive.<wbr>c<br>&gt; index 0d162e8..649a9a8 100644<br>&gt; --- a/=
src/openvpnserv/interactive.<wbr>c<br>&gt; +++ b/src/openvpnserv/interactiv=
e.<wbr>c<br>&gt; @@ -53,7 +53,7 @@<br>&gt; =C2=A0#define ERROR_MESSAGE_TYPE=
 =C2=A0 =C2=A0 0x20000003<br>&gt;<br>&gt; =C2=A0static SERVICE_STATUS_HANDL=
E service;<br>&gt; -static SERVICE_STATUS status;<br>&gt; +static SERVICE_S=
TATUS status =3D { SERVICE_WIN32_SHARE_PROCESS };<br><br>same as above... {=
.dwServiceType =3D ... }<br><br></div><div>&lt;snip&gt;</div><div>=C2=A0<br=
>&gt; diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c<br=
>&gt; index b79e999..232b33e 100644<br>&gt; --- a/src/openvpnserv/service.c=
<br>&gt; +++ b/src/openvpnserv/service.c<br>&gt; @@ -223,46 +223,77 @@ out:=
<br>&gt; =C2=A0int<br>&gt; =C2=A0_tmain(int argc, TCHAR *argv[])<br>&gt; =
=C2=A0{<br>&gt; - =C2=A0 =C2=A0SERVICE_TABLE_ENTRY dispatchTable[] =3D {<br=
>&gt; + =C2=A0 =C2=A0SERVICE_TABLE_ENTRY dispatchTable_shared[] =3D {<br>&g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ <a href=3D"http://automatic_service.=
name" target=3D"_blank">automatic_service.name</a>, ServiceStartAutomatic }=
,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ <a href=3D"http://interactive=
_service.name" target=3D"_blank">interactive_service.name</a>, ServiceStart=
Interactive },<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL }<br>=
&gt; =C2=A0 =C2=A0 =C2=A0};<br>&gt; + =C2=A0 =C2=A0const SERVICE_TABLE_ENTR=
Y *dispatchTable =3D dispatchTable_shared;<br>&gt;<br>&gt; =C2=A0 =C2=A0 =
=C2=A0openvpn_service[0] =3D automatic_service;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0openvpn_service[1] =3D interactive_service;<br>&gt;<br>&gt; - =C2=A0 =C2=
=A0if (argc &gt; 1 &amp;&amp; (*argv[1] =3D=3D TEXT(&#39;-&#39;) || *argv[1=
] =3D=3D TEXT(&#39;/&#39;)))<br>&gt; + =C2=A0 =C2=A0for (int i =3D 1; i &lt=
; argc; i++)<br>&gt; =C2=A0 =C2=A0 =C2=A0{<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (_tcsicmp(TEXT(&quot;install&quot;), argv[1] + 1) =3D=3D 0)<br>&gt=
; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*argv[i] =3D=3D TEXT(&#39;-&#39;) || *ar=
gv[i] =3D=3D TEXT(&#39;/&#39;))<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{=
<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CmdInstallServic=
es();<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; - =C2=A0 =C2=A0 =C2=A0=
 =C2=A0else if (_tcsicmp(TEXT(&quot;remove&quot;), argv[1] + 1) =3D=3D 0)<b=
r>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return CmdRemoveServices();<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (_tcsicmp(TEXT(&quot;s=
tart&quot;), argv[1] + 1) =3D=3D 0)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{<=
br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BOOL is_auto =3D argc &l=
t; 3 || _tcsicmp(TEXT(&quot;interactive&quot;), argv[2]) !=3D 0;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CmdStartService(is_auto ? a=
utomatic : interactive);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&=
gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto dispatch;<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (_tcsicmp(TEXT(&quot;install&quot;=
), argv[i] + 1) =3D=3D 0)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n CmdInstallServices();<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (_tcsicmp(TEXT=
(&quot;remove&quot;), argv[i] + 1) =3D=3D 0)<br>&gt; + =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0{<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return CmdRemoveServices();<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else =
if (_tcsicmp(TEXT(&quot;start&quot;), argv[i] + 1) =3D=3D 0)<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BOOL is_auto =3D argc &lt; i + 2 || _tcsicmp=
(TEXT(&quot;interactive&quot;), argv[i + 1]) !=3D 0;<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CmdStartService(is_auto=
 ? automatic : interactive);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (argc &g=
t; i + 2 &amp;&amp; _tcsicmp(TEXT(&quot;instance&quot;), argv[i] + 1) =3D=
=3D 0)<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* When running as an a=
lternate instance, we are invoked as<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * SERVICE_WIN32_OWN_PROCESS - we are the one an=
d only<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =
service in this process. The dispatch table should<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * reflect that.<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static const SERVICE_TABLE_ENTRY =
dispatchTable_automatic[] =3D {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ TEXT(&quot;&quot;), ServiceStartAut=
omaticOwn },<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{ NULL, NULL }<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0};<div><br></div><div>Agreed this array has to live=
 beyond the for loop, but why static? Statics</div><div>live for ever while=
 this need not exist beyond the function. Putting it at the</div><div>top w=
here dispatchTable_shared is defined (or anywhere before the loop)</div><di=
v>as a non-static variable would be the way to go?</div><div><br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static const SERVICE_TA=
BLE_ENTRY dispatchTable_interactive[] =3D {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ TEXT(&quot;&quot;), Servi=
ceStartInteractiveOwn },<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, NULL }<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};</div><div><br></div><div>Same here=
.</div><div><br></div><div>&lt;snip&gt;</div><div><br></div><div>Finally, w=
e could add the instance name to the eventlog output. MsgToEventLog</div><d=
iv>prints errors as &quot;APPNAME error: ....&quot; where APPNAME is &quot;=
openvpnserv&quot;.</div><div>E.g., add &quot; (instance_name)&quot; after A=
PPNAME?</div><div><br></div><div>Thanks,</div><div><br></div><div>Selva<br>=
</div></div></div></div>

--001a1138e726005c38055d5da8a7--

