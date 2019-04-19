MIME-Version: 1.0
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Fri, 19 Apr 2019 13:38:58 +0200
Message-ID: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
Content-Type: multipart/alternative; boundary="00000000000024f8be0586e091f9"
Subject: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net

--00000000000024f8be0586e091f9
Content-Type: text/plain; charset="UTF-8"

Hello all,

I've been looking at https://community.openvpn.net/openvpn/ticket/880 for a
while now, and was wondering if there'd been any answers to this problem
yet. It appears that mbedtls (according to krzee the problem disappeared
when using OpenSSL, but since I use OpenVPN-NL that's not an option for me)
refuses to answer a PUSH request for a connection it considers to already
exist. As a result, a reconnect (e.g. after a client reboot) will stall
until the reconnect timer exceeds the server's time-out, after which the
server closes the connection, and accepts the following reconnect attempt.
Reconnect from a 2.3.9 client is stalled indefinitely, since the re-connect
seems fixed at 2 seconds.

Using nobind will also solve the issue, since the server will see it as a
new connection, but I'm not sure nobind is a proper solution for everyone.

Any thoughts on this matter? Is it true that this only happens with
mbedtls, and as such should this issue be taken up with that community in
stead of this one? Any idea on why the server would refuse a PUSH request
for an already existing connection?

Kind regards,

Pieter Hulshoff

--00000000000024f8be0586e091f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hello all,</div><div class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif">I&#39;ve been looking a=
t=C2=A0<a href=3D"https://community.openvpn.net/openvpn/ticket/880" style=
=3D"font-family:Arial,Helvetica,sans-serif">https://community.openvpn.net/o=
penvpn/ticket/880</a>=C2=A0for a while now, and was wondering if there&#39;=
d been any answers to this problem yet. It appears that mbedtls (according =
to krzee the problem disappeared when using OpenSSL, but since I use OpenVP=
N-NL that&#39;s not an option for me) refuses to answer a PUSH request for =
a connection it considers to already exist. As a result, a reconnect (e.g. =
after a client reboot) will stall until the reconnect timer exceeds the ser=
ver&#39;s time-out, after which the server closes the connection, and accep=
ts the following reconnect attempt. Reconnect from a 2.3.9 client is stalle=
d indefinitely, since the re-connect seems fixed at 2 seconds.</div><div cl=
ass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br>=
</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,san=
s-serif">Using nobind will also solve the issue, since the server will see =
it as a new connection, but I&#39;m not sure nobind is a proper solution fo=
r everyone.</div><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif">Any thoughts on this matter? Is it true th=
at this only happens with mbedtls, and as such should this issue be taken u=
p with that community in stead of this one? Any idea on why the server woul=
d refuse a PUSH request for an already existing connection?</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-s=
erif">Kind regards,</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif">Pieter Hulshoff</div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div>=
</div>

--00000000000024f8be0586e091f9--

