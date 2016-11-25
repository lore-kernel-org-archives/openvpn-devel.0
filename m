MIME-Version: 1.0
In-Reply-To: <d94eadcd-06ca-0691-0add-147ac00ab063@...515...>
References: <d94eadcd-06ca-0691-0add-147ac00ab063@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 24 Nov 2016 23:40:09 -0500
Message-ID: <CAKuzo_iu-Q2CNtd=cjMxSGvVQZ_u_9uVMcOpbDpFrMcOrTFXhA@...278...>
Content-Type: multipart/alternative; boundary=001a114d8ca4c61766054218b8e0
Subject: Re: [Openvpn-devel] Test installer with installer,
 openvpn-gui and openvpnserv2 improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114d8ca4c61766054218b8e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 24, 2016 at 5:26 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Here's a Windows new test installer for 2.4_beta1:
>
> <https://build.openvpn.net/downloads/snapshots/openvpn-
> install-2.4_beta1-I902.exe>
>
> The changes compared to standard 2.4_beta1 installers are:
>
> 1) Installer works on both 32-bit and 64-bit Windows
> - https://github.com/OpenVPN/openvpn-build/pull/44
>

Tested on 32 bit and 64 bit systems and both installs went smoothly. Great
job. Reg values under the HKLM\Software\OpenVPN key (exe_path etc.) are not
updated -- guess that is expected.

Not tested on XP.

Ukranian localization patch needs some positioning tweaks  (see comments
added to the PR).

All else look good.

Selva

--001a114d8ca4c61766054218b8e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Nov 24, 2016 at 5:26 AM, Samuli=
 Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." ta=
rget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D":3ei" class=3D"a3s aXjCH m15895e1718e456e0">Here&#=
39;s a Windows new test installer for 2.4_beta1:<br>
<br>
&lt;<a href=3D"https://build.openvpn.net/downloads/snapshots/openvpn-instal=
l-2.4_beta1-I902.exe" rel=3D"noreferrer" target=3D"_blank">https://build.op=
envpn.net/<wbr>downloads/snapshots/openvpn-<wbr>install-2.4_beta1-I902.exe<=
/a>&gt;<br>
<br>
The changes compared to standard 2.4_beta1 installers are:<br>
<br>
1) Installer works on both 32-bit and 64-bit Windows<br>
- <a href=3D"https://github.com/OpenVPN/openvpn-build/pull/44" rel=3D"noref=
errer" target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn-build/pull=
/44</a></div></blockquote></div><br>Tested on 32 bit and 64 bit systems and=
 both installs went smoothly. Great job. Reg values under the HKLM\Software=
\OpenVPN key (exe_path etc.) are not updated -- guess that is expected.</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Not teste=
d on XP.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a">Ukranian localization patch needs some positioning tweaks =C2=A0(see com=
ments added to the PR).</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">All else look good.</div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Selva</div></div>

--001a114d8ca4c61766054218b8e0--

