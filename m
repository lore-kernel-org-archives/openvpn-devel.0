MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 19 Jun 2016 13:41:02 +0500
Message-ID: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d31c8470eb705359d8c61
Subject: [Openvpn-devel] what is the best way of skipping tests when openvpn
 configured --disable-crypto ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d31c8470eb705359d8c61
Content-Type: text/plain; charset=UTF-8

Hello,

when playing with travis-ci, I encountered that t_lpback.sh and t_cltsrv.sh
fails on "make check" if openvpn is configured with --disable-crypto
(because --genkey is not available)

what would be the best ?

1) run 'openvpn --help' and grep for --genkey ?
2) check exit code of 'openvpn --genkey' ?
3) run 'openvpn --show-ciphers' and see it is empty ?
4) somehow determine exact configure options ? (I haven't found a way yet)

Cheers,
Ilya Shipitsin

--047d7b5d31c8470eb705359d8c61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br><br></div>when playing with travis-ci,=
 I encountered that t_lpback.sh and t_cltsrv.sh fails on &quot;make check&q=
uot; if openvpn is configured with --disable-crypto (because --genkey is no=
t available)<br><br></div><div>what would be the best ?<br><br></div><div>1=
) run &#39;openvpn --help&#39; and grep for --genkey ?<br></div><div>2) che=
ck exit code of &#39;openvpn --genkey&#39; ?<br></div><div>3) run &#39;open=
vpn --show-ciphers&#39; and see it is empty ?<br></div><div>4) somehow dete=
rmine exact configure options ? (I haven&#39;t found a way yet)<br><br></di=
v><div>Cheers,<br></div><div>Ilya Shipitsin<br></div><div><br></div></div>

--047d7b5d31c8470eb705359d8c61--

