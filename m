Date: Fri, 2 Jul 2021 15:13:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210702131347.GS976@...1296...>
References: <20210520151148.2565578-1-arne@...1227...>
 <20210520151148.2565578-6-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ol7WfeVgAfApuYC/"
Content-Disposition: inline
In-Reply-To: <20210520151148.2565578-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 6/9] Introduce S_GENERATED_KEYS state
 and generate keys only when authenticated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--ol7WfeVgAfApuYC/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 20, 2021 at 05:11:45PM +0200, Arne Schwabe wrote:
> Since generating data channel keys does not happen when we have reach the
> S_ACTIVE/S_GOT_KEY state anymore like it used to be before NCP, the
> state that data channel keys deserves its own state in the TLS session
> state machine.

Master as of today (ccee09d1478a) + this patch crashes on p2p --secret

2021-07-02 15:06:31 us=3D336025 Peer Connection Initiated with [AF_INET6]::=
ffff:194.97.140.21:41858
2021-07-02 15:06:31 us=3D336099 WARNING: this configuration may cache passw=
ords in memory -- use the auth-nocache option to prevent this
2021-07-02 15:06:31 us=3D336118 Initialization Sequence Completed

Program received signal SIGSEGV, Segmentation fault.
0x00005555555794c9 in do_up (c=3Dc@...1851...=3D0x7fffffffd660, pulled_opti=
ons=3Dpulled_options@...1851...=3Dfalse,=20
    option_types_found=3Doption_types_found@...1851...=3D0) at init.c:2205
    2205            c->c2.tls_multi->multi_state =3D CAS_CONNECT_DONE;

(gdb) print c->c2.tls_multi
$1 =3D (struct tls_multi *) 0x0


I'm fairly sure it should not do that :-)

Is this fixed in 7/9...9/9?  Or do we need a v3 of this one?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ol7WfeVgAfApuYC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg3xEKAAoJEB2Cnv7KVigSxrkL/RHPvxyBre6O3YutLqaWwcUx
ur9t/hXidhl7XXcdZ3g+2z1Fy5hSXuoLrBC1FEjeuhC4Gci7be/vxn/i4nIlaxHs
GX2i09CGzN2U7AFegyycW6PuWAed6Iy1ODp6YQ05jv45ReOLxGncl+09OVDln7bE
TEk0j1ojsWP9p175GDtRjkLjS8PKvoUy90w0eXvvJd2/SkMBl5DYAkpj2RfLkeAg
aFdWbTtDLztzO3CZBNXUZGDxTzbLoD2njIiEy6kJJZE2VOJbz7JIrGB/cbRAYxHK
RnAzYW7MyR40ApjDV3/ldmpb4/ltmce/4xwT+cDTW0gtJUObZBKTY0/gLTqMPpHv
fIffN5nEILv2iPwOI/AErVmDakT4y0GEBU12aOmgWPiU1pvcpbe47/egeO/8laiA
cTRrP9EYl9T9wBRVO14JGinc2RpOJr9Koi25QVgz5Bqb0wMmtG8wmCM3166NgYF0
iyOsRoS4rUkOn9pvDmRwd4vycqKUbCIFLvGGNfmkkA==
=oWtl
-----END PGP SIGNATURE-----

--ol7WfeVgAfApuYC/--

