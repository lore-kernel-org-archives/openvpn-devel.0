Date: Thu, 20 Oct 2016 16:42:34 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161020084234.GR12558@...2182...>
References: <20161019062231.2845-1-a@...2181...>
	<20161019062231.2845-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <20161019062231.2845-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] openssl: implement crl-persist
 related functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--w2JjAQZceEVGylhD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Oct 19, 2016 at 02:22:31PM +0800, Antonio Quartulli wrote:
> Implement the functions needed by the crl-persist logic when openssl
> is enabled. Such functions are used in the ssl_verify module.
>=20
> Note that the CRL file is stored in an adhoc data structure and no
> openssl specific object is used. The data structure being used is a
> sorted array or serials that can later be looked up in log(N) with
> a binary search, thus guaranteeing a fast lookup operation.
>=20
> Such data structure may be changed in the future with an optimized
> openssl specific object.
>=20
> Tests have been performed by using a CRL file having size 143MB.
> Original delay upon client connection was around 5-8 seconds.
> With this patch the delay gets close to 0.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

As discussed on IRC, it might be better to first change the CRL handling co=
de in
the OpenSSL module to use the internal routines provided by the OpenSSL lib=
rary.
(apparently a patch to implement this change is in the work on somebody els=
e's
desk)


At that point my patch could be changed to re-use the same code instead of
implementing my own optimized logic.


Note: also OpenSSL uses a sorted array + bsearch for CRL handling, therefore
the performance of OpenSSL vs my approach should be similar.


Does anybody else have any opinion against this?



Cheers,

--=20
Antonio Quartulli

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCIN3AAoJEJ6F1zG2JyOsyLQP/2ytWsYqBXrdUSWqpqmX8lxU
3Nce4yRBeJJKEVLIf5HUz5j62zOWZim/lKIqAhmP/awr+s9/rdD/tPUNBB16Xfu+
lpJvDWF4gDfwI0V7oaDSm8BsXDYxyucOnpQQFpi0tNSSxVRTF4v3AJdbwaE2/rLg
E5Hi6q/n8X3+k/3Iy+nfo0UHIpXoD08D9+ZdjSZid8KQ6DHs3F7MirURrtBQRdJA
4HwgfBSvjWntDRYmvVShX9Wuj11oKL3dt/SSV7e8ueSTIDUMpwHfr2TIhS+r9T/+
KA8XEimHCGSZ/XZZ3aD9DwDp55UI9ufN5U7l8mcrYaOT0OhMaf5x5wEOp/Yy+a9J
qA2LuqgpCyhMMeCu9oCTDMUp8pfz2Aezepr6Wp27TrtP6N+s/Qe933ZYXK/31VUe
yx5h77dByIsbFe6HCVcdJqYTiEWgVl3vVnQ59tq2pirYGry2bCqSj7zrh05oWCCH
9PMwJx01IaYJPbHjZif56iIMiA5dHEuUV7QiP8/DkBpLDV+Dzu1L4apF3mS/9zm3
ynVjjeQh3BxpW102V/maH4Vg56iiBUhcjnlPLB1q+OpYezbiUjy+zYCyozAB1hHa
CK+QpdVWW24VttlWArLMTJqKl/rIng/2uYHyGbrQvp5Ifk0NcINnFYg7vQaZ0gPw
5WWjfUi40A04fo8pgP/P
=fsEt
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--

