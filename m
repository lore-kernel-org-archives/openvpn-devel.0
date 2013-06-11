Message-ID: <51B75346.9020702@...1114...>
Date: Tue, 11 Jun 2013 18:41:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEYCsr6idT0VPyR=g5s9dC-AQ3xAbcgeaq7otDa5JTpXaa=Thw@...278...>
In-Reply-To: <CAEYCsr6idT0VPyR=g5s9dC-AQ3xAbcgeaq7otDa5JTpXaa=Thw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2VLTQSRCAWILGCUBWOQOD"
Subject: Re: [Openvpn-devel] delivering a packet through tun file descriptor
 leads to different results
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: wen lui <esolvepolito@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VLTQSRCAWILGCUBWOQOD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/06/13 18:00, wen lui wrote:
> Hi, all:
>=20
>     I encountered a strange problem, my problem is detailed in this link
>=20
> http://stackoverflow.com/questions/16915322/delivering-a-packet-through-t=
un-file-descriptor-leads-to-different-results
>=20
> can anyone help me with this problem?
>=20
> thanks!

The OpenVPN project didn't write the tun/tap driver for Linux (or BSD
and Solaris).  So I would recommend you to check this out with the Linux
kernel networking team, as they most likely have a broader understanding
on how this driver works.

You do use openvpn to create the tun device, but you could just as well
used tunctl for the same operation.

Having all that said ... your program partly works for me - but not
reliably.  I did one code change, I had to use 10.99.0.1/24 as my IP
address to avoid address conflicts.  So I used this line:

    packet =3D create_icmp_pkt(100, "10.99.0.2", "10.99.0.1", 500, 5);

And I had to run your program as root (to gain access to the tun
device).  In addition, I ensured that my firewall was not adding any
obstacles by adding this iptables rule:

    iptables -I INPUT -i tun2 -j ACCEPT

When running your program via strace, it works reliably though.  Which
is surprising.

So I still recommend you to discuss this with the Linux Kernel
networking group.

<http://kernelnewbies.org/ML#head-007c59cc4d4ffcd7aacd7fabb6234d9b5a52c61a>



--=20
kind regards,

David Sommerseth


------enig2VLTQSRCAWILGCUBWOQOD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG3U0kACgkQDC186MBRfrqRAACgpXm/4Y546pQnfif2biNXG/r7
ElQAn3PeA0yX1TGuiSDAT1Lg7KYrAwzE
=oayo
-----END PGP SIGNATURE-----

------enig2VLTQSRCAWILGCUBWOQOD--

