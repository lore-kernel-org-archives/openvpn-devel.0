MIME-Version: 1.0
From: Qi Zhang <nemozqqz@...277...>
Date: Sat, 22 Jul 2017 21:58:12 +0800
Message-ID: <CACtAv3-fW=Pw_gW42D=a8091qDK5BeDp0=hiv3oce2P4bmnp2w@...278...>
Content-Type: multipart/alternative; boundary="94eb2c123f1a69592f0554e85f0b"
Subject: [Openvpn-devel] Default file permission of the unix domain socket
 for management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--94eb2c123f1a69592f0554e85f0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've noticed the default file permission of the unix domain socket for
OpenVPN mgmt interface on my linux is srwxrwxrwx.
"default' I mean management-client-user is not set
*.*
Is this default permission secure ?  Other process might connect to the
interface and causing DoS ?

I find that *umask(0)* is used in this socket_bind_unix
<https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/socket.c#L3882>
function and I think that's the reason for the defautl 777 permission.

I also observe that some Android OpenVPN apps create the unix domain socket
as the permission of 777.
I guess the reason is that mgmt socket is created by the native OpenVPN
library, not by the Java code.
Also, I think the OpenVPN process on Android won't know the user to set
management-client-user

So, I think the default file permission of unix domain socket is insecure
*. Will umask(077) solve this problem?*

Thx.
--=20
=E5=BC=A0=E5=A5=87
Anything worth doing is worth attaching your name to.

--94eb2c123f1a69592f0554e85f0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>I&#39;ve noticed the default file=
 permission of the unix domain socket for OpenVPN mgmt interface on my linu=
x is srwxrwxrwx.<br>&quot;default&#39; I mean management-client-user is not=
 set<b>.<br></b></div>Is this default permission secure ?=C2=A0 Other proce=
ss might connect to the interface and causing DoS ?<br><br></div>I find tha=
t <b>umask(0)</b> is used in this<a href=3D"https://github.com/OpenVPN/open=
vpn/blob/master/src/openvpn/socket.c#L3882"> socket_bind_unix</a> function =
and I think that&#39;s the reason for the defautl 777 permission.<br><br></=
div>I also observe that some Android OpenVPN apps create the unix domain so=
cket as the permission of 777.<br></div>I guess the reason is that mgmt soc=
ket is created by the native OpenVPN library, not by the Java code.<br></di=
v><div>Also, I think the OpenVPN process on Android won&#39;t know the user=
 to set management-client-user</div><div><br></div>So, I think the default =
file permission of unix domain socket is insecure<b>. Will umask(077) solve=
 this problem?<br></b><div><div><div><div><br clear=3D"all"><div><div><div>=
<div><div>Thx.<br></div><div>-- <br><div class=3D"gmail_signature">=E5=BC=
=A0=E5=A5=87<br>Anything worth doing is worth attaching your name to.</div>
</div></div></div></div></div></div></div></div></div></div>

--94eb2c123f1a69592f0554e85f0b--

