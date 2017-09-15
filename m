MIME-Version: 1.0
From: Alex K <rightkicktech@...277...>
Date: Fri, 15 Sep 2017 19:23:54 +0300
Message-ID: <CABMULtLadEa8O6OoPoO1183Z2=-A-GV8sxbUUFKDLQzkuDb0CA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0b0d28c3d6c105593cd19a"
Subject: [Openvpn-devel] Per client cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c0b0d28c3d6c105593cd19a
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am testing per client cipher with 2.4.3-1 and patch from
https://community.openvpn.net/openvpn/ticket/845.

As per Gert feedback, seems that when the client has same openvpn
version 2.4.3-1,
I have to disable ncp (using --disable-ncp).

Do I need to apply additional patch to support --disable-ncp? When trying
with current build the client complains that it does not recognize the
option.

Options error: Unrecognized option or missing or extra parameter(s) in
/etc/openvpn/client.conf:42: disable-ncp (2.4.3)


Thanx,
Alex

--94eb2c0b0d28c3d6c105593cd19a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi All, <br><br></div>I=
 am testing per client cipher with 2.4.3-1 and patch from <span class=3D"gm=
ail-im"><a href=3D"https://community.openvpn.net/openvpn/ticket/845" rel=3D=
"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>openvpn/t=
icket/845</a>.<br><br></span></div><span class=3D"gmail-im">As per Gert fee=
dback, seems that when the client has same openvpn version </span>2.4.3-1, =
I have to disable ncp (using --disable-ncp). <br><br></div>Do I need to app=
ly additional patch to support --disable-ncp? When trying with current buil=
d the client complains that it does not recognize the option. <br><br><span=
 style=3D"font-family:monospace,monospace">Options error: Unrecognized opti=
on or missing or extra parameter(s) in /etc/openvpn/client.conf:42: disable=
-ncp (2.4.3)</span><br><br></div></div><br></div>Thanx, <br></div>Alex<br><=
/div>

--94eb2c0b0d28c3d6c105593cd19a--

