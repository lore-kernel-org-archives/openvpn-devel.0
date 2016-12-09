Date: Fri, 9 Dec 2016 14:33:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161209133326.GC78624@...1296...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
	<CAKuzo_ga48WDGd-g8Xp=L1NbXf0Naez1ZRN3FhcyL247bK72Rg@...278...>
	<20161209074250.GQ78624@...1296...>
	<CAKuzo_jH1YChyAjpH_rZDoU40fHS-U+hkr6kROoKV2HCigK2iA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="icsXL8FABjDeMLkQ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jH1YChyAjpH_rZDoU40fHS-U+hkr6kROoKV2HCigK2iA@...278...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--icsXL8FABjDeMLkQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 09, 2016 at 08:24:24AM -0500, Selva Nair wrote:
> On Fri, Dec 9, 2016 at 2:42 AM, Gert Doering <gert@...1296...> wrote:
>=20
> >   if (a>0)
> >      { do_this(); }
> >   else
> >      { do_that(); }
> >
>=20
> In such cases I would normally skip all braces, in spite of all the
> arguments against it... But that's just me.

We've decided that we always want braces, "because apple goto bug",
but also because there's a slippery slope towards surprising bugs.


if (foo)
   return 3;
else
   if (bar)
       do_something(); return 2;
   else
       return 4;

(maybe a non-convincing example because "obviously buggy")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--icsXL8FABjDeMLkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSrKlAAoJEB2Cnv7KVigSACsL/j2dwrfxJAkJk/r6urkwVvpW
MuzvdJ9NEGYDuD9B94KIvTSBodx9Al1LkTL4En+CcK8uC675I0BE0kJfIHcH52fD
c2U26NipcrkDWOSr5fd7SH2vbtP6Z2wlWuuK6d5M9GTtnJmb3g98my6OArTyfWvG
UuDXLDMR4j6KIwivFJGXg6JSXwO6dFaqTcutP3ac3iz3UQB1vJtBturCMPpNrJiF
Bz9S62tPb5uUqudGH/t8Ej4GCCNq8ZSnTTaGc2LwOtowk2ftB599NZrqnhMOAQvv
bQ7Gw0WqY6u1kuFdJQ6tcJ1AgFiJ74DO2dtprw2E+UeAwA0Og0FocdIMwVJS8nrH
IjvvBwdG5kBQNitykj47v0eUIx6KjpoDM6ei1Gw/xy51nkdK+3R4lWrP7WcDtbIP
2/K9RQiR5Ce83OBfIiNX0yFi04+xEEpZkjBYu1OWl8pyMRPP8Q1dLbCKxXEHAlvu
cGDCNbOEWUSLYyeu9mqV1lik3mNs2TDyE4EV/ZPgFQ==
=S0qz
-----END PGP SIGNATURE-----

--icsXL8FABjDeMLkQ--

