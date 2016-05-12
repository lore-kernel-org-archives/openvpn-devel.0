MIME-Version: 1.0
Date: Thu, 12 May 2016 15:35:53 +0530
Message-ID: <CAP=zTkOq090k4ihgGBL_Ewp2Eq=M8TzDLEYqtwGCa1sh7MBwGw@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11c36ed6b309e00532a24d14
Subject: [Openvpn-devel] getting destination IP address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--001a11c36ed6b309e00532a24d14
Content-Type: text/plain; charset=UTF-8

Hi,

I have a setup where a client connects to a VPN server and then tries to
connect to a backend server through the OpenVPN tunnel.
So, if I try reaching out to the backend server from my client, the request
goes through the VPN server machine via the tunnel.
Is there a way to get the IP address of the backend server in the source
code, when a client is trying to get connected to one? Is there a way to
read the destination IP address of the final backend machine after the
packet is decapsulated and decrypted at the VPN server end?
Can it be done through the OpenVPN source code? If yes, please let me know?
If no, what alternatives are there?

Thanks in advance.
-- 
Regards
Shubham Chauhan

--001a11c36ed6b309e00532a24d14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>I have a setup where a client=
 connects to a VPN server and then tries to connect to a backend server thr=
ough the OpenVPN tunnel.<br></div><div>So, if I try reaching out to the bac=
kend server from my client, the request goes through the VPN server machine=
 via the tunnel.</div><div>Is there a way to get the IP address of the back=
end server in the source code, when a client is trying to get connected to =
one? Is there a way to read the destination IP address of the final backend=
 machine after the packet is decapsulated and decrypted at the VPN server e=
nd?=C2=A0</div><div>Can it be done through the OpenVPN source code? If yes,=
 please let me know? If no, what alternatives are there?</div><div><br>Than=
ks in advance.</div><div>-- <br><div class=3D"gmail_signature"><div dir=3D"=
ltr">Regards<br>Shubham Chauhan<br></div></div>
</div></div>

--001a11c36ed6b309e00532a24d14--

