References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
	<CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4fba3b6f-cffe-6e7a-71f8-c654721c0235@...2080...>
Date: Thu, 19 Jan 2017 20:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="C0htLX5wrJjFpNI3kpxEpFWQ48D4DoS3w"
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl,
 --wrap support in linker
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C0htLX5wrJjFpNI3kpxEpFWQ48D4DoS3w
Content-Type: multipart/mixed; boundary="vXmIc40iaMQgBDM26v1jtFNOMEAGCr5nx";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <4fba3b6f-cffe-6e7a-71f8-c654721c0235@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl, --wrap support in
	linker
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
	<CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>
In-Reply-To: <CAKuzo_g+PPAfxUZMAmE0L4JKk7Wwp6Y58VfdAJGQA5Ys6j52OQ@...278...>

--vXmIc40iaMQgBDM26v1jtFNOMEAGCr5nx
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 19/01/17 16:32, Selva Nair wrote:
> Hi,
>=20
> Thanks for the comments.
>=20
> On Thu, Jan 19, 2017 at 9:41 AM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     Any reason to have this AC_DEFINE?  That puts HAVE_LD_WRAP_SUPPORT in=
to
>     config.h, which I don't think makes much sense.  If we don't have --w=
rap
>     support, would we have #ifdef HAVE_LD_WRAP_SUPPORT in the C code at a=
ll?
>=20
>=20
> Repeating from related discussion on the PR page: AC_DEFINE is indeed
> meant to add a  preprocessor define (available to sources through
> config.h). We do not have a use for it right now but we could --- say
> one could provide an alternative to __wrap_xxx() in source, not sure how
> though.

Exactly.  There might be some possibilities, but I don't have a good
idea currently.  And I see even fewer possibilities where #ifdef around
this would be a solution.  I think a solution would require to compile
and link a different set of source code providing a similar feature,
which would anyway need to be primarily handled via configure.ac and
Makefile.am.

And considering this is limited to the LLVM linker and works fine with
at least the GNU linker, I don't think we will spend too much time
tackling this now.

> So currently its just a preprocessor define that provides a solution
> waiting for a problem. If the consensus is not to define it, fine with me.

I have no issues adding such an AC_DEFINE when we have a good use-case
for it.  But if we don't need it now, I think it's best to keep things
as simple as possible, in particular in the autotools stuff which can
already be quite confusing.


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--vXmIc40iaMQgBDM26v1jtFNOMEAGCr5nx--

--C0htLX5wrJjFpNI3kpxEpFWQ48D4DoS3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgRVaAAoJEIbPlEyWcf3yREkQAIRNnT7XIhcF+RE6tEcj6cbS
x5xo34OADy0k1fg+5Mj0T+56eY4JprJZBAxqj+hQt+w9kN3+CTXYnquZ2kkdcbaI
Ro5ACNMxd3FtIS2XBqBiU/GViX8wFXRoGO6UlghFMcRqxrSYdBLZQHxxNtbF5bxX
WImiuvu0aQcJ7xURHUuE+GJM/nS+uRG0hfGsajp3BLR4HMNp/UnIiCzzMqBg2Ge3
PHBQcGEfXqic38LIy7gQhYwIk37NI2NPSIEqAuPgYhgKBVmZA1M4GEPK8owAitXR
byCfvV5n10LcEq4pXb5Ky6Ks6DK4pbkbv+yks0eo+qMnRAGMZrrUTTtXSzaOQHxJ
jrkwyOiFg57KzHGUmBusW6rU535ZbtzVy9bTkJXJAnx8PmaTRQ97at4z4cw/xLlN
ZUqUpxFoPRbM7ZM7uw2E6PIJ/bxaslh+ok3MewNvuuS90oeaEfGMLeXN7xN/LovO
tIeTW5+NtbSgdEW8QtWG0m4q9pPJVIqVe7NTPqKtB5B8uImANr5FHsrer2LXn0f3
4g7F3cuAl5knM+V+w9n1zUrxNsqB2j3g8Cye407+gsIaiJKdD1wo63K2RB9mmQ5i
VhjweJUHcOwiaUqQZ2pnAb0hei9cX12NVMVaarwXK8hL+K1FIx4Dg9vZ7/nCUfaN
9mCG3vqUpwxYVyBhjLds
=i7we
-----END PGP SIGNATURE-----

--C0htLX5wrJjFpNI3kpxEpFWQ48D4DoS3w--

