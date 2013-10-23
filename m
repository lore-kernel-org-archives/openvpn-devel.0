MIME-Version: 1.0
Date: Wed, 23 Oct 2013 22:50:11 +0800
Message-ID: <CABDcBMk1BvzgOx+8pexTssmmFLgNNWjxxCYqj2nPxOW+iA8AYg@...278...>
From: Steve Cook <stevecookhk@...277...>
Content-Type: multipart/alternative; boundary=047d7bf1656e60040904e969a2d7
Subject: [Openvpn-devel] Linux client cant connect through socks proxy - any
	known workaround?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7bf1656e60040904e969a2d7
Content-Type: text/plain; charset=ISO-8859-1

I can't get openvpn to connect through my socks proxy server, and searching
around seem to find other users with the same problem, but no known
solution.

version:
OpenVPN 2.2.1 x86_64-linux-gnu [SSL] [LZO2] [EPOLL] [PKCS11] [eurephia]
[MH] [PF_INET6] [IPv6 payload 20110424-2 (2.2RC2)] built on Feb 27 2013

My config is setup like this:
client
dev tun
proto tcp
socks-proxy 192.168.147.1 101
remote ec2-xx-xx-xx-xx.compute-1.amazonaws.com 1194
ca ca.crt
cert client1.crt
key client1.key

Socks proxy works fine with other apps, but with openvpn I get the
following:
Oct 23 17:12:46 ovpn-client[1887]: TCP connection established with [AF_INET]
192.168.147.1:101
Oct 23 17:12:51 ovpn-client[1887]: socks_handshake: TCP port read timeout
expired: Operation now in progress (errno=115)

I found an old user list post that suggest this might be due to an issue
that openvpn has with non-blocking IO?
http://comments.gmane.org/gmane.network.openvpn.user/26898

But I don't see anything in the openvpn bug tracker or dev mailing list
archives.

Does this issue ring a bell for anyone? Any known workaround?

thanks
Steve

--047d7bf1656e60040904e969a2d7
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I can&#39;t get openvpn to connect through my socks p=
roxy server, and searching around seem to find other users with the same pr=
oblem, but no known solution.</div><div>=A0</div><div>version:</div><div>Op=
enVPN 2.2.1 x86_64-linux-gnu [SSL] [LZO2] [EPOLL] [PKCS11] [eurephia] [MH] =
[PF_INET6] [IPv6 payload 20110424-2 (2.2RC2)] built on Feb 27 2013</div>
<div>=A0</div><div>My config is setup like this:<br>client<br>dev tun<br>pr=
oto tcp<br><span style=3D"font-weight:bold">socks-proxy 192.168.147.1 101</=
span><br>remote <a href=3D"http://ec2-xx-xx-xx-xx.compute-1.amazonaws.com">=
ec2-xx-xx-xx-xx.compute-1.amazonaws.com</a> 1194<br>
ca ca.crt<br>cert client1.crt<br>key client1.key</div><div>=A0</div><div>So=
cks proxy works fine with other apps, but with openvpn I get the following:=
</div><div>Oct 23 17:12:46 ovpn-client[1887]: TCP connection established wi=
th [AF_INET]<a href=3D"http://192.168.147.1:101">192.168.147.1:101</a><br>
Oct 23 17:12:51 ovpn-client[1887]: socks_handshake: TCP port read timeout e=
xpired: Operation now in progress (errno=3D115)</div><div>=A0</div><div>I f=
ound an old user list post that suggest this might be due to an issue that =
openvpn has with non-blocking IO?</div>
<div><div><a href=3D"http://comments.gmane.org/gmane.network.openvpn.user/2=
6898">http://comments.gmane.org/gmane.network.openvpn.user/26898</a></div><=
div>=A0</div></div><div>But I don&#39;t see anything in the openvpn bug tra=
cker or dev mailing list archives.</div>
<div>=A0</div><div>Does this issue ring a bell for anyone? Any known workar=
ound?</div><div>=A0</div><div>thanks</div><div>Steve<br></div></div>

--047d7bf1656e60040904e969a2d7--

