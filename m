MIME-Version: 1.0
Date: Sat, 20 Feb 2016 11:51:41 +0530
Message-ID: <CAP=zTkN_=4PVZUxz6pGNYQ3=JTxJ0emjRC+_PbtYd5Zix-kc6A@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11402324f42457052c2d9c8b
Subject: [Openvpn-devel] Disabling Encryption/Decryption ONLY at the server
	level
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a11402324f42457052c2d9c8b
Content-Type: text/plain; charset=UTF-8

Is there a way to disable encryption/decryption functionality only at the
server level. What kind of code changes are needed at the server level?

This is just for analysis purposes.
If the client sends encrypted and encapsulated packets to the VPN server
gateway, it should forward only decapsulated packets.


-- 
Regards
Shubham Chauhan

--001a11402324f42457052c2d9c8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Is there a way to disable encryption/decryption funct=
ionality only at the server level. What kind of code changes are needed at =
the server level?</div><div><br></div><div>This is just for analysis purpos=
es.</div><div>If the client sends encrypted and encapsulated packets to the=
 VPN server gateway, it should forward only decapsulated packets.</div><br =
clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><div dir=
=3D"ltr">Regards<br>Shubham Chauhan<br></div></div>
</div>

--001a11402324f42457052c2d9c8b--

