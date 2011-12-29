Date: Thu, 29 Dec 2011 15:24:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111229142454.GV5060@...1296...>
References: <A273A2F6519C0D42BFF02CA9C6A825112D003F02@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D003F72@...1531...>
	<20111213092241.GO18948@...1296...>
	<1CED409804E2164C8104F9E623B08B90128ACE5B0A@...1436...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005928@...1531...>
	<4EE863A2.5010302@...1114...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005B6D@...1531...>
	<0E891FB5E6304C73BB4338093E409304@...139...>
	<A273A2F6519C0D42BFF02CA9C6A825112D005C00@...1531...>
	<A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D00A3D3@...1534...>
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 22, 2011 at 10:07:42AM +0000, Tiran Kaskas wrote:
> It seems like I am through with the vpn initialization, and seems like th=
e session is created successfully.
> Now, I start sending data to some server from the client side (I have an =
application which opens a socket to google.com and sends some data).
> I do see the packet is received on the server side and decrypted successf=
ully (virtual address is the client's tun ip).

Cool :-)

> I see the server reads this packet from the link adapter(ethernet), and w=
rites it to the tun adapter.
> Looking at the tun adapter (using wireshark), I see a packet is there wit=
h:
> source ip: client's tun ip
> destination ip: the google ip

That's good.

> The problem is that nothing happens from this point.

Most likely, the Linux kernel side of things is dropping the packet because
"ip forwarding" is not turned on - so it's not a router, and will not
forward packets destined to someone else's address.

What you need to do is:

 - make sure that your linux server is forwarding packets to its gateway
 - make sure that the answer packets from google (etc) are routed *back*
   to your linux server
     - either your external router knows how to route the client subnet
       back to the openvpn machine
     - or you need to turn on NAT (masquerading) on the openvpn server, so=
=20
       that google will see all requests coming from the openvpn server's
       IP address

Some useful info is here:

http://www.secure-computing.net/wiki/index.php/OpenVPN/Routing


> I am missing something, pretty sure about that, but do not know what...
> I know that when the server write this packet to the TUN, it means the=20
> packet is injected into the OS ip stack, as if it was received from the=20
> outside.=20

Exactly.

> But who will take care of actually sending it to the destination=20
> address? Am I missing some routing configuration?

Linux needs to know that it is to be a router:

 # echo 1 >/proc/sys/net/ipv4/ip_forward

and it needs to have routes toward the destination.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTvx4NakuBuNlUUl1AQIH9wQAr+xj8VCwigM5Bo+BYeL9cpTX1hVDC/7E
ejHG3UsCvRxh9W9YdFRuAjd7UVqqwXXqZRQie+36b72ihUoyCAs0wzVWFuwRVx7i
fylwxZnESvl7DUPzXyMYCE1PgligiTF4RBRdpqpVth3XxIpo6rZ3i8EoCvJ1MyT4
8EtbT6h1LCQ=
=X5KK
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--

