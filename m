Message-ID: <52D003F2.5050109@...1227...>
Date: Fri, 10 Jan 2014 15:30:10 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<20140110140728.GD226@...1296...>
In-Reply-To: <20140110140728.GD226@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vr1MLFSrBbdJfC6DIA9dV0anLFqlHooXm"
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vr1MLFSrBbdJfC6DIA9dV0anLFqlHooXm
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 10.01.14 15:07, schrieb Gert Doering:
> Hi,
>
> On Fri, Jan 10, 2014 at 02:51:48PM +0100, Arne Schwabe wrote:
>> That is very weird. I would expect it to fail for both cases in the same
>> way. The codepath should trigger the same ASSERT(0) in both cases (or
>> work in both).=20
> ... unless something is overwriting to->ai_family, for example by copying
> a too-large address structure.  There is a trac bug about --multihome that
> says we're using the wrong size (#327) which could be an indication.
>
> (I have not yet investigated #327 more closely - that one is about=20
> sendmsg(), but maybe we do bad things on receive as well)
>
But

[AF_INET6]::ffff:87.238.42.150:47707

and=20

[AF_INET6]2a02:c0:100:0:9e8e:99ff:fed1:5243:56277

should be same the same size and handled both the same way from OpenVPN sin=
ce they are both IPv6.

Arne



--vr1MLFSrBbdJfC6DIA9dV0anLFqlHooXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLQA/gACgkQe8+cMNS4zReHUgCgkgXXIz+Puzn9aPgTpCA/zJWu
vHoAoIcnUcgRPN0VFOioZ7ikKo/jqq8t
=a/u4
-----END PGP SIGNATURE-----

--vr1MLFSrBbdJfC6DIA9dV0anLFqlHooXm--

