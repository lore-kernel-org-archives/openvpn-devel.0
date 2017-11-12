Date: Sun, 12 Nov 2017 17:23:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171112162344.GG958@...1296...>
References: <201708291322.v7TDMcY3029206@...2300...>
 <20170829190353.GX70062@...1296...>
 <201708300839.v7U8dklY019715@...2300...>
 <ed6292e5-2877-7ca8-bf7b-80fe8e7da72e@...1227...>
 <201708310611.v7V6Bj1f010862@...2300...>
 <80a5d2fc-819c-76d7-f51d-2a2d476bf31a@...1937...>
 <201709201059.v8KAxOc2014584@...2300...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3EG2G0wNthkGfxoY"
Content-Disposition: inline
In-Reply-To: <201709201059.v8KAxOc2014584@...2300...>
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Casper.Dik@...2299...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3EG2G0wNthkGfxoY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

noob speaking... so we're upgrading our VM build/test environmend, and
have added an 11.3 VM (based on the "Oracle Solaris 11.3 VM Template=20
for Oracle VM VirtualBox" nicely provided by Oracle).

Of course, GCM modes now core dump (=3D good to test :-) )...

On Wed, Sep 20, 2017 at 12:59:24PM +0200, Casper.Dik@...2299... wrote:
> The fix was also delivered in Solaris 11.3 SRU 24 which was released=20
> somewhere in the last week.
>=20
> # pkg list -H entire openssl
> entire                                            0.5.11-0.175.3.24.0.4.0=
    i--
> library/security/openssl                          1.0.2.11-0.175.3.24.0.4=
.0  i--

What I have after what I thought would do the updating ("pkg install entire=
")
is:

vagrant@...2321...:/tmp/openvpn$ pkg list -H entire openssl
entire                                            0.5.11-0.175.3.1.0.5.2   =
  i--
library/security/openssl                          1.0.1.16-0.175.3.0.0.30.0=
  i--

... so is there a way to get from there to "11.3 SRU 24" from the
inside of the VM?  Or do you need to download something manually, have=20
a maintenance contract, etc.?

(Too many things changed in the organizational structure since I used an
"original Solaris" last time - that was OpenSolaris 10...)

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3EG2G0wNthkGfxoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaCHWQAAoJEB2Cnv7KVigScwEL/i1UgXNSup4F6rxki6wS545B
1heaEvTndN65LNCMhFbC8SH5Z2z8SgC8bpZQkQ4lUx1pUUi3xtM6aZr+PJLjklos
CKhxYNzxYr1TsdgWEfrqdVSwDPcJkr3NsjBJpyQf2m1tfF4go8M6vXb/Hyv/Aptd
H4UhfLNCF2CwLDq6hAjnuzsQ/XwS+SDQZMPfkGV89JdxhL6xkE2aJkZpXxH+g3f3
e20h1mif2l3OChgjssYQUWWAbO8v/FGGOdHqCZ3REzIznDL0zXE+/mUGR9ho0j7p
2/ey7rIzLTr71VjaM5CUu8lZDKW2Wg870upXxWgIgMxmWu1h8c0hPbYY+fnW6QVa
0v4FWp5PagErJcDOlC7IP2v2Km8ueUktLnFN45OA3K7ndy/8ndZtAjyhkIL/MB5V
N7B6DMA/xajQnfAbUtP/HBMfzxxqCLjluMEOTviC4yAUNxhUL+3lf9e1bpspWETu
2nTXIVe4sFC0fA+AKpVOG8SdwHahcWJr7Wx6hPFZrw==
=VeRv
-----END PGP SIGNATURE-----

--3EG2G0wNthkGfxoY--

