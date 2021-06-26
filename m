MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 26 Jun 2021 12:34:27 +0500
Message-ID: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
Content-Type: multipart/alternative; boundary="00000000000007cb5c05c5a64ab5"
Subject: [Openvpn-devel] is this expected when using "--dev null" ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000007cb5c05c5a64ab5
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm using "null" for testing (to avoid modifiyng routes and interfaces).
current master tells me

2021-06-26 07:27:03 net_iface_mtu_set: rtnl: cannot get ifindex for null:
No such device (errno=19)
2021-06-26 07:27:03 Linux can't set mtu (1500) on null
2021-06-26 07:27:03 Exiting due to fatal error


is this considered as a feature or bug ?



cheers,
Ilya

--00000000000007cb5c05c5a64ab5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,<div><br></div><div>I&#39;m using &=
quot;null&quot; for testing (to avoid modifiyng=C2=A0routes and interfaces)=
. current master tells me</div><div>=C2=A0</div><div><div>2021-06-26 07:27:=
03 net_iface_mtu_set: rtnl: cannot get ifindex for null: No such device (er=
rno=3D19)</div><div>2021-06-26 07:27:03 Linux can&#39;t set mtu (1500) on n=
ull</div><div>2021-06-26 07:27:03 Exiting due to fatal error</div></div><di=
v><br></div><div><br></div><div>is this considered as a feature or bug ?</d=
iv><div><br></div><div><br></div><div><br></div><div>cheers,</div><div>Ilya=
</div><div><br></div></div></div>

--00000000000007cb5c05c5a64ab5--

