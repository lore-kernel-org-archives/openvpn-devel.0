Date: Wed, 31 May 2017 11:28:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170531092817.GH97029@...1296...>
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e9pZk6dkd7RNnQPj"
Content-Disposition: inline
In-Reply-To: <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e9pZk6dkd7RNnQPj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 31, 2017 at 11:14:33AM +0200, David Sommerseth wrote:
> On 31/05/17 09:02, Gert Doering wrote:
> > Hi,
> >=20
> > On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
> >> If we really do care for supporting 0.9.8, in release/2.4 - I can give
> >> this an ACK.  Otherwise, I think it might be better to backport
> >> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.
> >=20
> > You are the one that objects most violently if we break users' expectat=
ions
>=20
> Yes and no.  In regards to end users, I am very careful.  In regards to
> package maintainers, I am less weary as they won't distribute failing
> builds to end users.  This change hits package building, not the end user.

Well, this is a somewhat simplistic world view, with "package builders"
and "package installers".

People are stuck on older enterprise distributions, for whatever reasons,=20
but want a newer openvpn version - so they get the source bundle, and=20
compile.  Which is a perfectly fine deployment model - and we should not=20
break things in 2.4.3 that worked just fine in 2.4.2 for them (unless=20
there is a strong reason, like "we have a vulnerability here that we=20
cannot fix unless we abandon an older API").

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--e9pZk6dkd7RNnQPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZLoyxAAoJEB2Cnv7KVigSy9UMAKCTBp9RK76juzQ8NNHQRk9P
VmBGvxli5DAv7Bi0x+j15SguU+Ezm+0whXpXEBE2jiLNjoaohayXCo4V5TTp20hg
2ibmApcoG90zMKqclwW8BmxOUyAsXXINVjVJdv2dHsINXvznKWEUQscCPJpvIF2f
OhViQAkVz3Sw3QIYJupjCqUPVhJtFbfLv14SvJjtsYkVY0BadUpw0XSwXfgSF7gL
ZX/LJigmbpkdANnABwV/SFvJRRArjmMXiWMI8VASdCYvbTxch1A0uvTy1Z9JyDv7
WrFdJdtq+Ke9jaiJ53TowOJ+FXyGSyxq1XGBdDbeiHkFgEZLBcI8WMpGUApu7N9u
5WZHQirmvAVaVvQdrueq4nXypGVir40U/n9E+r1gAUdlJJhi+u9Biorlq15P7NcJ
bwv2GD9KF+Jo155i/x1tqbFoccF2ICcoY+J5ob3TVkw/PLenxN4cGYCvjSm9bjmW
pH1k5GF9wtlcR05uCxNr0IRmxJYgF0ea5rf7sDnFgg==
=Cjmt
-----END PGP SIGNATURE-----

--e9pZk6dkd7RNnQPj--

