From: James Bekkema <james@...1918...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_0C09E4CF-2F6C-442F-9D65-C06D04953DE0"
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Mon, 23 Jul 2018 13:45:54 +1000
Message-Id: <429EB687-EB2D-4C67-B3EA-0A3BECA640B1@...1918...>
Subject: [Openvpn-devel] [PATCH] Resolves small IV_GUI_VER typo in the
 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_0C09E4CF-2F6C-442F-9D65-C06D04953DE0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

According to the source code, the environment variable for the GUI version =
should be IV_GUI_VER, rather than IV_UI_VER. This patch simply fixes this s=
mall typo in the docs.

Signed-off-by: James Bekkema <james@...1918...>

Thanks,
James

--
James Bekkema
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

--Apple-Mail=_0C09E4CF-2F6C-442F-9D65-C06D04953DE0
Content-Disposition: attachment;
	filename=doc-iv_ui_ver.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="doc-iv_ui_ver.diff"
Content-Transfer-Encoding: quoted-printable

=46rom=204cf63cad794a3dd56839ac89f854abefc2dad1d4=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Bekkema=20<james@...1918...>=0A=
Date:=20Mon,=2023=20Jul=202018=2011:56:58=20+1000=0ASubject:=20[PATCH]=20=
Resolves=20small=20IV_GUI_VER=20typo=20in=20the=20documentation.=0A=0A=
---=0A=20doc/openvpn.8=20|=202=20+-=0A=201=20file=20changed,=201=20=
insertion(+),=201=20deletion(-)=0A=0Adiff=20--git=20a/doc/openvpn.8=20=
b/doc/openvpn.8=0Aindex=2046ea58b6..b102fd88=20100644=0A---=20=
a/doc/openvpn.8=0A+++=20b/doc/openvpn.8=0A@@=20-3071,7=20+3071,7=20@@=20=
IV_NCP=3D2=20\-\-=20negotiable=20ciphers,=20client=20supports=0A=20=
pushed=20by=20the=20server,=20a=20value=20of=202=20or=20greater=20=
indicates=20client=0A=20supports=20AES\-GCM\-128=20and=20AES\-GCM\-256.=0A=
=20=0A-IV_UI_VER=3D<gui_id>=20<version>=20\-\-=20the=20UI=20version=20of=20=
a=20UI=20if=20one=20is=0A+IV_GUI_VER=3D<gui_id>=20<version>=20\-\-=20the=20=
UI=20version=20of=20a=20UI=20if=20one=20is=0A=20running,=20for=20example=20=
"de.blinkt.openvpn=200.5.47"=20for=20the=0A=20Android=20app.=0A=20=0A--=20=
=0A2.17.1=0A=0A=

--Apple-Mail=_0C09E4CF-2F6C-442F-9D65-C06D04953DE0--

