MIME-Version: 1.0
In-Reply-To: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 9 Dec 2016 23:18:54 +0500
Message-ID: <CAFHpkQGGVjM2mWHKc0Bd-0E_ymT4UVKdP_CvX9r2FhodLCAGBQ@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4e752abc05433dc90c
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7bf10b4e752abc05433dc90c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

9 =D0=B4=D0=B5=D0=BA. 2016 =D0=B3. 22:40 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Selva Nair" <selva.nair@...277...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

Hi,

A comment  on the GUI github page said:

"For ISO27001 certification, we are not allowed to let users save their VPN
passwords locally. Is there a way to remove or disable the 'save password'
box upon authentication ?"

Although I suggested to use an up script to delete the saved password, the
GUI displaying a checkbox to save password may not be acceptable to some
setups. Any idea how widespread a concern is this? Note that the GUI saves
it encrypted. Personally I believe not saving passwords encourages users to
choose weak passwords, but we could make the GUI respect any --auth-nocache
in the config.



There might be some interest for FIPS or ISO27001 variants, we may run some
questionary to investigate that.

It also makes sense to make default openvpn software to satisfy those
standards. I've idea is it possible or not.


More info here (https://github.com/OpenVPN/openvpn-gui/issues/105)

Thanks,

Selva

------------------------------------------------------------
------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--047d7bf10b4e752abc05433dc90c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">9 =D0=B4=D0=B5=D0=BA. 2016 =D0=B3. 22:40 =D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Selva Nair&quot; &lt=
;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquot=
e class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr"><div><div><div><div>Hi,<br><br>A comment=C2=
=A0 on the GUI github page said:<br><br></div>&quot;For ISO27001 certificat=
ion, we are not allowed to let users save their=20
VPN passwords locally. Is there a way to remove or disable the &#39;save=20
password&#39; box upon authentication ?&quot;<br><br></div>Although I sugge=
sted to use an up script to delete the saved password, the GUI displaying a=
 checkbox to save password may not be acceptable to some setups. Any idea h=
ow widespread a concern is this? Note that the GUI saves it encrypted. Pers=
onally I believe not saving passwords encourages users to choose weak passw=
ords, but we could make the GUI respect any --auth-nocache in the config.<b=
r></div></div></div></blockquote></div></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">There might be some inter=
est for FIPS or ISO27001 variants, we may run some questionary to investiga=
te that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It also makes s=
ense to make default openvpn software to satisfy those standards. I&#39;ve =
idea is it possible or not.</div><div dir=3D"auto"><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><di=
v><div><br></div>More info here (<a href=3D"https://github.com/OpenVPN/open=
vpn-gui/issues/105" target=3D"_blank">https://github.com/OpenVPN/<wbr>openv=
pn-gui/issues/105</a>)<br><br></div><div>Thanks,<br><br></div>Selva<br></di=
v>
<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today.<a href=3D"http://sdm.link/xeonphi" rel=3D"norefe=
rrer" target=3D"_blank">http://sdm.link/xeonphi</a><br>____________________=
__________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div></div>

--047d7bf10b4e752abc05433dc90c--

