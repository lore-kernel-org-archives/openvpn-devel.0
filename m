Date: Sat, 23 Jun 2018 19:31:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180623173104.GT57262@...1296...>
References: <201806231209.w5NC9AhF028415@...2054...>
 <20180623121503.4080-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H3QWGwNgsl3Q7pDd"
Content-Disposition: inline
In-Reply-To: <20180623121503.4080-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add %d,
 %u and %lu tests to test_argv unit tests.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--H3QWGwNgsl3Q7pDd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 23, 2018 at 02:15:03PM +0200, Gert Doering wrote:
> Some basic integer tests to verify signed, unsigned and
> long unsigned (2^33) printing.

Ditch that patch... this only works on 64bit systems.

What I wanted to see is "yes, it really does long math", but on systems
where sizeof(int) =3D sizeof(long) =3D 4, this will just not do the right
thing.

Do we care?=20=20

Or shall I just have it print "1", so we know "%lu works and prints its=20
argument nicely"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--H3QWGwNgsl3Q7pDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLoPYAAoJEB2Cnv7KVigS6mQL/RSHvSYPDqPTyXWR5pPawMEb
o9aHq+HyWtgMlpBWtTwMTwMa9hqDXYBdXf4emCxL84E7NJuci9TdOJJUsBmXJXLT
0jjNs5NpJQ6gikKMPCmLJk1kWfuIOh8dhDEWKgsiHt0Yt4nfxt3XX0Z+i15LkYYR
HqcGe7BHo3p6YgHYS37xh0eObcvIRRdBELXT5sAEGcGktrNnBRYas+3SUzw9yFff
6M10k+u3HOfHu5dIip+TBeoAtrjka/hpBVRDVed/7ytrYZBiuHQv2cLTRfOGQ3SM
+ARYGX0dTaa2VH4G2rvS1SCJG9Fch8MGLTWWnP039nYRRcownOwid/dICbcPOpSt
Ki4u2ecnrKG1omfG98mZWTlyDvT+XHUUZ7hNfXHFSRLNq99GNEhTH4IgiRXN/cgI
E/hhc2TTcwQDpIJ+VNAZ/mz8EUPubHZG/uim+q+hGRMeE0dWFWxxJlwguAktjRgf
muKv9Jm6olCS+QrnKLzkbTAHkOgUz8PMegCcPjMx7w==
=DGPE
-----END PGP SIGNATURE-----

--H3QWGwNgsl3Q7pDd--

