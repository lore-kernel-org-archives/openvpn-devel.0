MIME-Version: 1.0
References: <CAKuzo_gnC6zdR7c-M44M2RQ=xnCcRPMOGaU+AmCJvprOJCnZsw@...278...>
 <CAGyAFMVXg0p7tzLsqm=jmMHnCaq5UcvsOYVGimaie5hpAk6vOQ@...278...>
In-Reply-To: <CAGyAFMVXg0p7tzLsqm=jmMHnCaq5UcvsOYVGimaie5hpAk6vOQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 3 Sep 2020 08:37:21 -0400
Message-ID: <CAKuzo_gFq8JAqp-wSO2p0vWGF_dkEEBv2hL2gi3_M8gWW=FeMg@...278...>
Content-Type: multipart/alternative; boundary="00000000000090851a05ae6804b0"
Subject: Re: [Openvpn-devel] On tap-windows6 adapter installation by
 tapctl.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000090851a05ae6804b0
Content-Type: text/plain; charset="UTF-8"

Hi Lev,

Thanks for confirming. What you tested is exactly what I have in mind.

I suppose you tested it using MSVC. I recall when I worked on creating tap
adapters on the fly (patch abandoned for lack of time) some functions in
newdev.dll did not resolve with mingw and I always had to load them on
runtime. I'll check those hard corners again and submit a patch soonish
(hopefully today).

Selva

On Thu, Sep 3, 2020 at 8:11 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> >
> > As per setupapi.dev.log, it appears that step 4 (d) is failing with some
> access error to the driver store unless elevated to SYSTEM (see Trac 1321).
> This leaves the adapter not fully configured. Hard to say exactly what
> fails as none of the function calls return any error.
>
> I can confirm that. This call
>
> /* Install the device. */
>     if (!SetupDiCallClassInstaller(
>             DIF_INSTALLDEVICE,
>             hDevInfoList,
>             &devinfo_data))
>     {
>         dwResult = GetLastError();
>         msg(M_NONFATAL | M_ERRNO, "%s:
> SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
>         goto cleanup_remove_device;
>     }
>
> produces this error in setupapi.dev.log
>
> >>>  [Configure Driver Package -
> c:\windows\system32\driverstore\filerepository\oemvista.inf_amd64_8a00bc07868b5df3\oemvista.inf]
> >>>  Section start 2020/09/03 12:08:49.525
>       cmd: "C:\Users\lev\Projects\openvpn\x64-Output\Debug\tapctl.exe"
> create
>      sto: Source Filter  = tap0901.ndi
>      sto: Target Filter  = ROOT\NET\0004
>      inf: Class GUID     = {4d36e972-e325-11ce-bfc1-08002be10318}
>      inf: Class Options  = Configurable
> !!!  idb: Failed to open driver package object
> 'oemvista.inf_amd64_8a00bc07868b5df3'. Error = 0x00000005
> <<<  Section end 2020/09/03 12:08:49.558
> <<<  [Exit status: FAILURE(0x00000005)]
>
>
> >>>  [Restart Device - ROOT\NET\0004]
> >>>  Section start 2020/09/03 12:08:49.565
>       cmd: "C:\Users\lev\Projects\openvpn\x64-Output\Debug\tapctl.exe"
> create
>      dvi: Device Status: 0x01802501 [0x0e - 0x00000000]
> !    dvi: Device restart was skipped (NEEDREBOOT/NEEDRESTART).
> <<<  Section end 2020/09/03 12:08:49.588
> <<<  [Exit status: SUCCESS]
>
> > I propose to replace 4(d) with a call to DiInstallDevice() instead. My
> tests show this completes without error.
>
> I can confirm that too. This patch
>
> diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
> index 7cb3dedc..8d071320 100644
> --- a/src/tapctl/tap.c
> +++ b/src/tapctl/tap.c
> @@ -29,6 +29,7 @@
>
>  #include <windows.h>
>  #include <cfgmgr32.h>
> +#include <newdev.h>
>  #include <objbase.h>
>  #include <setupapi.h>
>  #include <stdio.h>
> @@ -38,6 +39,7 @@
>  #pragma comment(lib, "advapi32.lib")
>  #pragma comment(lib, "ole32.lib")
>  #pragma comment(lib, "setupapi.lib")
> +#pragma comment(lib, "newdev.lib")
>  #endif
>
>  const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce,
> { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
> @@ -900,19 +902,13 @@ tap_create_adapter(
>      }
>
>      /* Install the device. */
> -    if (!SetupDiCallClassInstaller(
> -            DIF_INSTALLDEVICE,
> -            hDevInfoList,
> -            &devinfo_data))
> +    if (!DiInstallDevice(NULL, hDevInfoList, &devinfo_data, NULL, 0,
> pbRebootRequired))
>      {
>          dwResult = GetLastError();
> -        msg(M_NONFATAL | M_ERRNO, "%s:
> SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
> +        msg(M_NONFATAL | M_ERRNO, "%s: DiInstallDevice failed",
> __FUNCTION__);
>          goto cleanup_remove_device;
>      }
>
> -    /* Check if a system reboot is required. (Ignore errors) */
> -    check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
> -
>      /* Get network adapter ID from registry. Retry for max 30sec. */
>      dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 30,
> pguidAdapter);
>
> works for both tapctl and MSI installer - created adapters are usable
> by non-admin.
>
> >
> > This also has an advantage that we could call it with driver_info = NULL
> which will force the system to use the latest matching driver. That would
> also eliminate step 3 which is right now very inefficient, though not
> required to fix the problem at hand.
>
> Yeah, I also works for me without
>
> for (DWORD dwIndex = 0;; dwIndex++)
>     {
>
> loop.
>
> >
> > If this sounds sane, I'll submit a patch.
>
> Please do!
>
> --
> -Lev
>

--00000000000090851a05ae6804b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Lev,<div><br></div><div>Thanks for confirming. What you=
 tested is exactly what I have in mind.</div><div><br></div><div>I suppose =
you tested it using MSVC. I recall when I worked on creating tap adapters o=
n the fly (patch abandoned for lack of time) some functions=C2=A0in newdev.=
dll did not resolve with mingw and I always had to load them on runtime. I&=
#39;ll check those hard corners again and submit a patch soonish (hopefully=
 today).</div><div><br></div><div>Selva</div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 8:11 AM=
 Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...1663...=
.</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<br>
&gt;<br>
&gt; As per setupapi.dev.log, it appears that step 4 (d) is failing with so=
me access error to the driver store unless elevated to SYSTEM (see Trac 132=
1). This leaves the adapter not fully configured. Hard to say exactly what =
fails as none of the function calls return any error.<br>
<br>
I can confirm that. This call<br>
<br>
/* Install the device. */<br>
=C2=A0 =C2=A0 if (!SetupDiCallClassInstaller(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIF_INSTALLDEVICE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hDevInfoList,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;devinfo_data))<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dwResult =3D GetLastError();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL | M_ERRNO, &quot;%s:<br>
SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed&quot;, __FUNCTION__);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup_remove_device;<br>
=C2=A0 =C2=A0 }<br>
<br>
produces this error in setupapi.dev.log<br>
<br>
&gt;&gt;&gt;=C2=A0 [Configure Driver Package - c:\windows\system32\driverst=
ore\filerepository\oemvista.inf_amd64_8a00bc07868b5df3\oemvista.inf]<br>
&gt;&gt;&gt;=C2=A0 Section start 2020/09/03 12:08:49.525<br>
=C2=A0 =C2=A0 =C2=A0 cmd: &quot;C:\Users\lev\Projects\openvpn\x64-Output\De=
bug\tapctl.exe&quot; create<br>
=C2=A0 =C2=A0 =C2=A0sto: Source Filter=C2=A0 =3D tap0901.ndi<br>
=C2=A0 =C2=A0 =C2=A0sto: Target Filter=C2=A0 =3D ROOT\NET\0004<br>
=C2=A0 =C2=A0 =C2=A0inf: Class GUID=C2=A0 =C2=A0 =C2=A0=3D {4d36e972-e325-1=
1ce-bfc1-08002be10318}<br>
=C2=A0 =C2=A0 =C2=A0inf: Class Options=C2=A0 =3D Configurable<br>
!!!=C2=A0 idb: Failed to open driver package object<br>
&#39;oemvista.inf_amd64_8a00bc07868b5df3&#39;. Error =3D 0x00000005<br>
&lt;&lt;&lt;=C2=A0 Section end 2020/09/03 12:08:49.558<br>
&lt;&lt;&lt;=C2=A0 [Exit status: FAILURE(0x00000005)]<br>
<br>
<br>
&gt;&gt;&gt;=C2=A0 [Restart Device - ROOT\NET\0004]<br>
&gt;&gt;&gt;=C2=A0 Section start 2020/09/03 12:08:49.565<br>
=C2=A0 =C2=A0 =C2=A0 cmd: &quot;C:\Users\lev\Projects\openvpn\x64-Output\De=
bug\tapctl.exe&quot; create<br>
=C2=A0 =C2=A0 =C2=A0dvi: Device Status: 0x01802501 [0x0e - 0x00000000]<br>
!=C2=A0 =C2=A0 dvi: Device restart was skipped (NEEDREBOOT/NEEDRESTART).<br>
&lt;&lt;&lt;=C2=A0 Section end 2020/09/03 12:08:49.588<br>
&lt;&lt;&lt;=C2=A0 [Exit status: SUCCESS]<br>
<br>
&gt; I propose to replace 4(d) with a call to DiInstallDevice() instead. My=
 tests show this completes without error.<br>
<br>
I can confirm that too. This patch<br>
<br>
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c<br>
index 7cb3dedc..8d071320 100644<br>
--- a/src/tapctl/tap.c<br>
+++ b/src/tapctl/tap.c<br>
@@ -29,6 +29,7 @@<br>
<br>
=C2=A0#include &lt;windows.h&gt;<br>
=C2=A0#include &lt;cfgmgr32.h&gt;<br>
+#include &lt;newdev.h&gt;<br>
=C2=A0#include &lt;objbase.h&gt;<br>
=C2=A0#include &lt;setupapi.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
@@ -38,6 +39,7 @@<br>
=C2=A0#pragma comment(lib, &quot;advapi32.lib&quot;)<br>
=C2=A0#pragma comment(lib, &quot;ole32.lib&quot;)<br>
=C2=A0#pragma comment(lib, &quot;setupapi.lib&quot;)<br>
+#pragma comment(lib, &quot;newdev.lib&quot;)<br>
=C2=A0#endif<br>
<br>
=C2=A0const static GUID GUID_DEVCLASS_NET =3D { 0x4d36e972L, 0xe325, 0x11ce=
,<br>
{ 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };<br>
@@ -900,19 +902,13 @@ tap_create_adapter(<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Install the device. */<br>
-=C2=A0 =C2=A0 if (!SetupDiCallClassInstaller(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIF_INSTALLDEVICE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hDevInfoList,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;devinfo_data))<br>
+=C2=A0 =C2=A0 if (!DiInstallDevice(NULL, hDevInfoList, &amp;devinfo_data, =
NULL, 0,<br>
pbRebootRequired))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dwResult =3D GetLastError();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL | M_ERRNO, &quot;%s:<br>
SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed&quot;, __FUNCTION__);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL | M_ERRNO, &quot;%s: DiInstallD=
evice failed&quot;, __FUNCTION__);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup_remove_device;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* Check if a system reboot is required. (Ignore errors) */<=
br>
-=C2=A0 =C2=A0 check_reboot(hDevInfoList, &amp;devinfo_data, pbRebootRequir=
ed);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* Get network adapter ID from registry. Retry for max =
30sec. */<br>
=C2=A0 =C2=A0 =C2=A0dwResult =3D get_net_adapter_guid(hDevInfoList, &amp;de=
vinfo_data, 30,<br>
pguidAdapter);<br>
<br>
works for both tapctl and MSI installer - created adapters are usable<br>
by non-admin.<br>
<br>
&gt;<br>
&gt; This also has an advantage that we could call it with driver_info =3D =
NULL which will force the system to use the latest matching driver. That wo=
uld also eliminate step 3 which is right now very inefficient, though not r=
equired to fix the problem at hand.<br>
<br>
Yeah, I also works for me without<br>
<br>
for (DWORD dwIndex =3D 0;; dwIndex++)<br>
=C2=A0 =C2=A0 {<br>
<br>
loop.<br>
<br>
&gt;<br>
&gt; If this sounds sane, I&#39;ll submit a patch.<br>
<br>
Please do!<br>
<br>
-- <br>
-Lev<br>
</blockquote></div>

--00000000000090851a05ae6804b0--

