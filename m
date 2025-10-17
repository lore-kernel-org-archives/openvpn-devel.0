Date: Fri, 17 Oct 2025 11:31:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aPIM_OihqRtmMJUO@...1296...>
References: <20251004141935.17815-1-gert@...1296...>
 <202510041605.594G5lcj088673@...2054...>
 <aPIHG1mIkWzafoak@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uCof3Zz9ilS6lC4X"
Content-Disposition: inline
In-Reply-To: <aPIHG1mIkWzafoak@...2685...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: route: Fix a
 unused-but-set-variable warning on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--uCof3Zz9ilS6lC4X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 17, 2025 at 11:06:35AM +0200, Frank Lichtenheld wrote:
> On Sat, Oct 04, 2025 at 06:05:47PM +0200, Gert Doering wrote:
> > This is not my most favourite patch in this series... but the alternati=
ve
> > is "more #ifdefs" (nah) or "more code duplication" (nah).  In these sys=
tem
> > dependent parts, some compromises need to be made...=20
> >=20
> > Didn't actually *test* anything, as it's very explicit not doing anythi=
ng :-)
> > (and BB says "it still compiles and tests fine everywhere").
> >=20
> > Your patch has been applied to the master branch.
>=20
> Can you please also apply this to release/2.6? It applies cleanly and oth=
erwise
> buildbot is unhappy on obsd75. We currently have no easy way to make
> --enable-werror conditional on the branch.

Makes sense.

So here we go:

commit dca6b03098ab0f3ef808c891673305651dc6704a (HEAD -> release/2.6)
Author: Frank Lichtenheld <frank@...2641...>
Date:   Sat Oct 4 16:19:30 2025 +0200

    route: Fix a unused-but-set-variable warning on OpenBSD
=20=20=20=20
    So we could enable -Werror for OpenBSD builds.
=20=20=20=20
    Change-Id: Ic971604beb1320d7b9d6121cd8e8519ccc1a7eb9

"stared at diff", compile tested on OpenBSD 7.6

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uCof3Zz9ilS6lC4X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo8gz8AAoJEB2Cnv7KVigSbJoL/R0ArRoH6WDYceI1WTL+zDZ0
lS3hu6EJYK4IM6nRt6KBEC7SN2RaiNiVLg+HWj3cbzV2VgLh8hViHUWSuIoAFL1U
7sVFTDhxrxJYx7G7ytCSdKC6Yzk1eIA1K9myAJWoXkb28DXNWh7jRgfyEV6qIcz/
0WGIDEI0B+mqdR7twMEI9cjXAwapC7tTF5Eke37faeq2uD3O4DqV+k+5JEZuJXTp
4czXd84ocfpzM2GtCCVPSg0YMgWBGxsRSe4kR4C9r8fSKIbp/vH8TLQOtwLx4gAF
b7nh5V8dpdYEutc5of9s46caDy4T/hVaeX78VZB0OFXOh4efLWMrPA5AID6L92TU
QUOCklkPkt1e5uKJ1Uy7rEWK7KA0YAEllXNeJuAAcei46uwbwgyiVK6XbCH67/7k
Ej77D23uG36RpmKN3PUWcwSOYrlpu68oJsCHek1hkpkIHOglgpi6RSoFlEOZvX5Y
nF4bLdKds2tqKYmo9pYdIjWvdJOkr4zCpT+XPzmiSw==
=42t8
-----END PGP SIGNATURE-----

--uCof3Zz9ilS6lC4X--

