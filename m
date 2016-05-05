MIME-Version: 1.0
Date: Thu, 5 May 2016 15:56:21 +0530
Message-ID: <CAP=zTkNE-53SstE=tobE9xKWbpT=ERgstxQNy0EqxrN4GMs0Eg@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a114036780d3615053215c6ab
Subject: [Openvpn-devel] SSL handshake and OpenVPN config cipher none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--001a114036780d3615053215c6ab
Content-Type: text/plain; charset=UTF-8

Hello,

I had a doubt about the cipher none config in OpenVPN.
I realized that OpenVPN initiates an SSL handshake, even if I choose not to
use any encryption-decryption operations through the cipher none config. It
chooses a particular cipher in the handshake as well.

Is it supposed to happen this way? If yes then why does this exactly
happen? What is the significance of the SSL/TLS handshake and negotiating a
session, if I am not using any encryption?


-- 
Regards
Shubham Chauhan
2013099
B.Tech CSE

--001a114036780d3615053215c6ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>I had a doubt about the ci=
pher none config in OpenVPN.</div><div>I realized that OpenVPN initiates an=
 SSL handshake, even if I choose not to use any encryption-decryption opera=
tions through the cipher none config. It chooses a particular cipher in the=
 handshake as well.</div><div><br></div><div>Is it supposed to happen this =
way? If yes then why does this exactly happen? What is the significance of =
the SSL/TLS handshake and negotiating a session, if I am not using any encr=
yption?</div><div><br clear=3D"all"><div><br></div>-- <br><div><div dir=3D"=
ltr">Regards<br>Shubham Chauhan<br>2013099<br>B.Tech CSE</div></div>
</div></div>

--001a114036780d3615053215c6ab--

