Date: Thu, 1 Feb 2018 08:27:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180201072731.GU69387@...1296...>
References: <20180120164114.12478-1-steffan@...1856...>
 <20180126105803.26646-1-steffan@...1856...>
 <CAKuzo_iwkWNzJqRN24LUTaL4G0B_nnDTpCMRAwSrQ_srMzLDxg@...278...>
 <12ec1e85-3ded-86e3-002b-bd98ec2c8372@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Cp72eN6HUuZZoDF"
Content-Disposition: inline
In-Reply-To: <12ec1e85-3ded-86e3-002b-bd98ec2c8372@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Enable stricter compiler warnings by
 default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4Cp72eN6HUuZZoDF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 01, 2018 at 07:34:44AM +0100, Steffan Karger wrote:
> > Just one thing: if we support compilers other than gcc/clang (say,
> > xlc) this would need a test like AX_CHECK_COMPILE_FLAG().
>=20
> Hm, I don't think we do for configure.ac.  We do sort-of support MSVC,
> but that doesn't use this build system.  Gert, David, any opinions?

Well, on systems that have no gcc, configure will use whatever it finds
- on Solaris this could be some Sun CC, on AIX it will be xlc.  We should
not break that gratuitously.

So, gcc-specific flags need a test on whether they work with "OS cc"

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--4Cp72eN6HUuZZoDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJacsFiAAoJEB2Cnv7KVigSj7UL/14ueWGHBdtUJoogLy6lrduv
Ud2kL60+XcZsUUSvnt5h/DvYcc/bjZX5QSHn4WTZKiyvR0KQa0seMAQwcXYAy2tB
0YWkclNVBKWbloetJoy+due8QVfMXgnmeHM8mTTXbAQpPLOFEn8QEWnOgWsyAQS8
0XCH1C5aHTl6MwAfAvdZpZdFRyBC/RxmgdeCVe6bJqamiiMMb91ZciPSnLZwawNF
PdUrJzXa016qKiYqUfJZeISZn7R39cwuhciBtzvkaKptCmmye9hR5UjR11Xtdmfx
zEFwd3slVYakgbJ3H4rBlM8iOKY0mFQNUtA5TzUjVFEdzxSQNQAyXbNOjAA4pIry
iQjkwbQCW6/3A49T1Dc6SR8IumPzrM3CNqbYgw0nE32gePs40ZyUjdu8iHFGkivl
BgkLKnUi8woVFNfIT42OqtsQ8Q5FJPKhyb2PxeXKV/d76c+aiyjbT2pz+H6QK6Uu
/m/dOdKDpd7C5sns2qtLEt5zOUCLTlCn5Lksl7Q2lA==
=xs9M
-----END PGP SIGNATURE-----

--4Cp72eN6HUuZZoDF--

