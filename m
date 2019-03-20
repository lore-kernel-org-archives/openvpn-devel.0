References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
Date: Wed, 20 Mar 2019 09:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K0smtSRU0mF4FYW5mT7viBCb7vaT7NNy3"
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K0smtSRU0mF4FYW5mT7viBCb7vaT7NNy3
Content-Type: multipart/mixed; boundary="3MnCNje3Luftpj1Cb3AIE1Cc5GGoHHzU4";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
In-Reply-To: <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>

--3MnCNje3Luftpj1Cb3AIE1Cc5GGoHHzU4
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 18/03/2019 22:30, tincanteksup wrote:
> Hi,
>=20
> this situation has been hanging around for so long is this brief note
> really enough? Considering that the manual has numerous other URLs why
> not include this URL here:
> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
>=20
> We already have this:
> https://community.openvpn.net/openvpn/wiki/SWEET32
>=20

the problem with URLs is that they become obsolete and we need to
re-patch the manual in order to update them (or ensure the URL always
work/redirect to something).


However, I was thinking that a WARNING in the log when parsing a
dhcp-option without any script configured (on non-windows platform) may
also be beneficial.

Not many people will read it, but at least it will be there to be seen
at the first attempt of understanding what's wrong.

What do you think?

This said, the warning could/should be implemented as a separate patch.

Regards,

--=20
Antonio Quartulli


--3MnCNje3Luftpj1Cb3AIE1Cc5GGoHHzU4--

--K0smtSRU0mF4FYW5mT7viBCb7vaT7NNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlyR8xcACgkQ9FVsWUWD
Dm1Akw//YP8b9VIAA0GkybkPVpCigf5n6Y8wXbuGv8SyC5fnCVN2fv+/HcbZKs/y
UBKFh8A8zo2hTkM41VYKY5YUBcyKY0wQ+lJ+4qU+lWc7OdMfhzSe3/dIBecw02pQ
RTGxZS4KYdWoYNUkclrVqRrpmLrMsE/LWDQmZM16GodeSZjjhP8XicYxuEzHyvg1
pAT57a+M2/lCRcDmqYsyNYpyv/WYDkBJB+f89gl9wQoZn8yTxt8AMBNqMSe2Cpqn
dHcqdabjgLIc5CQ/o4dVZcIBCsWVdnSWm5BqMwriAqs5G3tFmc1cu6rsCMGAP6C+
yDjHdgVHwTz/PhrpmBthJGsp1F+1NhKfDJthClVWY0WUARf6GlHhdE7CTSPWrHrX
nW9Q+wA/RlRjxmxNVdCBJNwwp6q3vERWUmU6YMnT+YE0+zSmB37aClRHbU4M3Ajc
xFlJESL0oNmFqUgfPl2NjcdOpRKQReObcjvm59EqNCbRqAn7epsVjZUcFPorbDdy
krhaQjlPmFdgDE4QyIw1QN8sJFVrx8ppJnjboC0igCmP9CO0PB2zKnCsX1oEu9lv
jUfFWDrWbuFBzXhNU5Wdz2sy1+m8Ua3t3xMUFs447x7SpJ69O3GQTrtqTDvoTay5
H0LuFdOGdaBG8CZqe06TTT95DNLa8ce/dW9jeR2NZ646pKhEGfU=
=xTcK
-----END PGP SIGNATURE-----

--K0smtSRU0mF4FYW5mT7viBCb7vaT7NNy3--

