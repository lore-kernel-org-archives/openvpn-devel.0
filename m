MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 9 Dec 2016 12:38:49 -0500
Message-ID: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
Content-Type: multipart/alternative; boundary=001a113762324b7be505433d3b88
Subject: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113762324b7be505433d3b88
Content-Type: text/plain; charset=UTF-8

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

More info here (https://github.com/OpenVPN/openvpn-gui/issues/105)

Thanks,

Selva

--001a113762324b7be505433d3b88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br>A comment=C2=A0 on the GUI =
github page said:<br><br></div>&quot;For ISO27001 certification, we are not=
 allowed to let users save their=20
VPN passwords locally. Is there a way to remove or disable the &#39;save=20
password&#39; box upon authentication ?&quot;<br><br></div>Although I sugge=
sted to use an up script to delete the saved password, the GUI displaying a=
 checkbox to save password may not be acceptable to some setups. Any idea h=
ow widespread a concern is this? Note that the GUI saves it encrypted. Pers=
onally I believe not saving passwords encourages users to choose weak passw=
ords, but we could make the GUI respect any --auth-nocache in the config.<b=
r><br></div>More info here (<a href=3D"https://github.com/OpenVPN/openvpn-g=
ui/issues/105">https://github.com/OpenVPN/openvpn-gui/issues/105</a>)<br><b=
r></div><div>Thanks,<br><br></div>Selva<br></div>

--001a113762324b7be505433d3b88--

