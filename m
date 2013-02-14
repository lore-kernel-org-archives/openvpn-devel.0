Message-ID: <511CE09C.1010600@...1227...>
Date: Thu, 14 Feb 2013 14:03:24 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <511CC1F1.6010409@...1114...>
In-Reply-To: <511CC1F1.6010409@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2NAFRGOHDGLPLLKUPHJVF"
Subject: Re: [Openvpn-devel] RFC - Usefulness of the --tls-remote semantic
 warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NAFRGOHDGLPLLKUPHJVF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 14.02.13 11:52, schrieb David Sommerseth:
> Hi,
>
> This is just a minor issue which has been annoying me a little bit.
> I've attached a patch which ensures that the --tls-remote semantic
> warning is only printed once.
>
> However, I wonder how useful that warning really is these days.  Do
> we really need that warning?  The warning comes from this commit [1]:
>
> commit c04bc0223c9b17f203555b933cbeedbf3b343c0e
> Author: james <james@...1807...>
> Date:   Sun Jul 27 18:20:52 2008 +0000
>
>     Added additional warnings for:
>=20=20=20=20=20
>     * --tls-remote -- some people misunderstand the semantics
>=20=20=20=20=20
>     * --script-security -- warn if script-security will allow user-defined
>       scripts to be called, and also warn separately if passwords may be
>       passed to scripts via the environment
>=20=20=20=20=20
> It's from 2008.  I see that in some cases this warning is needed, but I
> also think people need to read the man pages when things doesn't work as
> expected.  Not that we need to hand-hold people the whole way through.
>
> If we find that all of these warnings are not that useful any more, I'd
> rather suggest that we revert the commit above.  Otherwise we can also
> consider to just remove the --tls-remote warning completely.
>
> Any thoughts?
>
>
I think we can remove the script-security warnings completely. I never
found the --tls-remote useful either.

Arne


------enig2NAFRGOHDGLPLLKUPHJVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEc4KMACgkQe8+cMNS4zRembwCgiLV2Ny0Y70s02My2kQbzgUaY
GmIAoLLZCmXn5hnkzsNuw92PhbvzisNn
=aUhq
-----END PGP SIGNATURE-----

------enig2NAFRGOHDGLPLLKUPHJVF--

