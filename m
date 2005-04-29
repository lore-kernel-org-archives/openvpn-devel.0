From: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_8EfcCDXqz6KhJaU"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504291033.00667.ralfluebben@...68...>
Subject: [Openvpn-devel] Radius support (Authentification, Authorization and Accounting)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Apr 29 01:37:10 2005
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_8EfcCDXqz6KhJaU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am interesting in build radius support for OpenVpn.
At the moment I'am thinking about what is the best way.

1. Authentification and Authroization:
I think this already works with the plugin pam_radius_auth.so, is that righ=
t?

But I am interested in more features,
like to get the ip-address and the routes from the RADIUS-Server.
Can this be done with a plugin? Maybe by creating the configurationfiles at=
=20
the start of the connection?=20
Or could this be integrated in the Source Code? I think this would be the b=
est=20
solution.
I hope the fea
2. Accounting:
I need to count the traffic  of a VPN-connection, one the side every traffi=
c=20
which goes from a client to the server (tun0-interface) and one the other=20
side every traffic which goes through the VPN, maybe from one client to=20
another client.
So when I use the counter of the tun-interface, I lose the traffic which go=
es=20
from one client to another. If I count the traffic of the eth-interface I g=
et=20
other traffic, which has nothing to do with the vpn.=20

Maybe someone has some experiences with this topic and give some hints whic=
h=20
is the best way? To do all things in a modul or to do all changes in the=20
source code. and where I have to look in the source code to integrate this=
=20
feature.

I hope there is a gerneal interest in this feature.

For every help I am very grateful.

Ralf L=FCbben




--Boundary-00=_8EfcCDXqz6KhJaU
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta name=3D"qrichtext" content=3D"1" /></head><body style=3D"=
font-size:10pt;font-family:Sans Serif">
<p><span style=3D"font-size:12pt">Hello,</span></p>
<p></p>
<p><span style=3D"font-size:12pt">I am interesting in build radius support =
for OpenVpn.</span></p>
<p><span style=3D"font-size:12pt">At the moment I'am thinking about what is=
 the best way.</span></p>
<p></p>
<p><span style=3D"font-size:12pt">1. Authentification and Authroization:</s=
pan></p>
<p><span style=3D"font-size:12pt">I think this already works with the plugi=
n pam_radius_auth.so, is that right?</span></p>
<p></p>
<p><span style=3D"font-size:12pt">But I am interested in more features,</sp=
an></p>
<p><span style=3D"font-size:12pt">like to get the ip-address and the routes=
 from the RADIUS-Server.</span></p>
<p><span style=3D"font-size:12pt">Can this be done with a plugin? Maybe by =
creating the configurationfiles at the start of the connection? </span></p>
<p><span style=3D"font-size:12pt">Or could this be integrated in the Source=
 Code? I think this would be the best solution.</span></p>
<p><span style=3D"font-size:12pt">I hope the fea</span></p>
<p><span style=3D"font-size:12pt">2. Accounting:</span></p>
<p><span style=3D"font-size:12pt">I need to count the traffic  of a VPN-con=
nection, one the side every traffic which goes from a client to the server =
(tun0-interface) and one the other side every traffic which goes through th=
e VPN, maybe from one client to another client.</span></p>
<p><span style=3D"font-size:12pt">So when I use the counter of the tun-inte=
rface, I lose the traffic which goes from one client to another. If I count=
 the traffic of the eth-interface I get other traffic, which has nothing to=
 do with the vpn. </span></p>
<p></p>
<p><span style=3D"font-size:12pt">Maybe someone has some experiences with t=
his topic and give some hints which is the best way? To do all things in a =
modul or to do all changes in the source code. and where I have to look in =
the source code to integrate this feature.</span></p>
<p></p>
<p><span style=3D"font-size:12pt">I hope there is a gerneal interest in thi=
s feature.</span></p>
<p></p>
<p><span style=3D"font-size:12pt">For every help I am very grateful.</span>=
</p>
<p></p>
<p><span style=3D"font-size:12pt">Ralf L=FCbben</span></p>
<p></p>
<p></p>
<p></p>
<p></p>
</body></html>=

--Boundary-00=_8EfcCDXqz6KhJaU--

