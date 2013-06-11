Message-ID: <51B757D2.7030505@...1114...>
Date: Tue, 11 Jun 2013 19:01:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEYCsr6idT0VPyR=g5s9dC-AQ3xAbcgeaq7otDa5JTpXaa=Thw@...278...>
	<51B75346.9020702@...1114...>
	<CAEYCsr6w2St4NxcV65w8+O3CYje8Aczy61qfbM4smf4emZc3jw@...278...>
In-Reply-To: <CAEYCsr6w2St4NxcV65w8+O3CYje8Aczy61qfbM4smf4emZc3jw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2SUKWOTGFQOTJMKJRLLWS"
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
------enig2SUKWOTGFQOTJMKJRLLWS
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/06/13 18:44, wen lui wrote:
> thanks
>=20
> you meant when you run my program, you got a ICMP reply?

Yes, some times I did.  But not reliably.

But just a hint when you mail the Linux mailing lists ... do not top
post.  They'll flog you for that.


--=20
kind regards,

David Sommerseth


> 2013/6/11 David Sommerseth <openvpn.list@...1114...
> <mailto:openvpn.list@...1114...>>
>=20
>     On 11/06/13 18:00, wen lui wrote:
>     > Hi, all:
>     >
>     >     I encountered a strange problem, my problem is detailed in
>     this link
>     >
>     >
>     http://stackoverflow.com/questions/16915322/delivering-a-packet-throu=
gh-tun-file-descriptor-leads-to-different-results
>     >
>     > can anyone help me with this problem?
>     >
>     > thanks!
>=20
>     The OpenVPN project didn't write the tun/tap driver for Linux (or BSD
>     and Solaris).  So I would recommend you to check this out with the Li=
nux
>     kernel networking team, as they most likely have a broader understand=
ing
>     on how this driver works.
>=20
>     You do use openvpn to create the tun device, but you could just as we=
ll
>     used tunctl for the same operation.
>=20
>     Having all that said ... your program partly works for me - but not
>     reliably.  I did one code change, I had to use 10.99.0.1/24
>     <http://10.99.0.1/24> as my IP
>     address to avoid address conflicts.  So I used this line:
>=20
>         packet =3D create_icmp_pkt(100, "10.99.0.2", "10.99.0.1", 500, 5);
>=20
>     And I had to run your program as root (to gain access to the tun
>     device).  In addition, I ensured that my firewall was not adding any
>     obstacles by adding this iptables rule:
>=20
>         iptables -I INPUT -i tun2 -j ACCEPT
>=20
>     When running your program via strace, it works reliably though.  Which
>     is surprising.
>=20
>     So I still recommend you to discuss this with the Linux Kernel
>     networking group.
>=20
>     <http://kernelnewbies.org/ML#head-007c59cc4d4ffcd7aacd7fabb6234d9b5a5=
2c61a>
>=20
>=20
>=20
>     --
>     kind regards,
>=20
>     David Sommerseth



------enig2SUKWOTGFQOTJMKJRLLWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG3V9IACgkQDC186MBRfro8wgCcD/jsfVAvuRdkfIwZf/fi8oU+
MLQAn2PLm3q3TQ99LRrxeTZ/7Y6uzwMK
=bsF1
-----END PGP SIGNATURE-----

------enig2SUKWOTGFQOTJMKJRLLWS--

