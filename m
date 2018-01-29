Date: Mon, 29 Jan 2018 09:25:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180129082521.GI69387@...1296...>
References: <1516909261-31623-1-git-send-email-selva.nair@...277...>
 <1516909261-31623-2-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z8fvYVVi1MVTXPE1"
Content-Disposition: inline
In-Reply-To: <1516909261-31623-2-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Prompt for signature using
 '>PK_SIGN' if the client supports it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--z8fvYVVi1MVTXPE1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 25, 2018 at 02:41:01PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Increase the management version from 1 to 2
> - If the client announces support for management version > 1
>   prompt for signature using >PK_SIGN to which the client
>   responds using 'pk-sig'
>   Older (current) clients will be continued to be prompted
>   by '>RSA_SIGN' and can respond using 'rsa-sig'
> - Remove an unused rsa_sig buffer-list variable
>=20
> This facilitates a transparent transition to PK_SIG and future deprecation
> of RSA_SIGN

I'm a bit confused about the sequence of patches here.  Is this one depende=
nt
on one of the other PK_SIGN related patches?  Or standalone and could be
applied to master "as is"?

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--z8fvYVVi1MVTXPE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJabtpwAAoJEB2Cnv7KVigSTeAL/1xiNLyYbb6jU6mdeWlfmmBh
4s8wjBK1G1GBjWE1O3OAlVEhZ6nCTYAfeUAZx8GJODFQLLKoXc3hg5ArS+e9cI4k
7XG/KV5/RUBjh9FfgnGXaw/fhOoh81YGYkr2XemYi3egGxsLQJWsfGnY+cRzuWOo
h+Umx0wsPcloAfvtct/EyyUyODLvsaZpXr9PTy8+6p8SL7/ad4QNrYeGx2YnDBnB
4UINf0bnga1NblENmcWPXRiYedk8CDY1JaX4hBxmgA6tgr/OPLo38qqY7pOaKh8a
OmCeKGrJNDbjS3dh2RhbQwXz3a85xpMyyHmr4X2Gvx/qIMEA/8TwpaklL5cE6qnm
f6mLNEG6J0ZniZVsa5ntdaVai25Da0NwB1d4O/kkEcywv5pIxlNmZ8ZgTNTObUEC
McFzlc/kabmBcfdB/oSPSZcKK3pTsqjd/8p2HVElI1gvSYOTTIvrAOcIe7bcNB8/
dSU44594eUQqf6JJfczlwmAzQX8fDWzVbrmc2LOwww==
=XYRZ
-----END PGP SIGNATURE-----

--z8fvYVVi1MVTXPE1--

