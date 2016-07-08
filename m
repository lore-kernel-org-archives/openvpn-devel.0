Date: Fri, 8 Jul 2016 19:24:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160708172423.GO78279@...1296...>
References: <20160708075524.26b81b44f7069d75256c531b0c1ba101.470311a15d.mailapi@...2149...>
	<2514f480-3a44-cd26-72b4-cd793d66d640@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bxF9Dep5HzwGj9mC"
Content-Disposition: inline
In-Reply-To: <2514f480-3a44-cd26-72b4-cd793d66d640@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Segmentation Fault
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--bxF9Dep5HzwGj9mC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 08, 2016 at 06:18:08PM +0200, Jan Just Keijser wrote:
> https://build.opensuse.org/package/view_file/network:vpn/openvpn/openvpn-=
fips140-2.3.2.patch?expand=3D1

It seems to mostly replace all "md5_..." stuff with "sha1_..." functions
(looks very much like find-and-replace to me...) *and* it adds a special
fips function call that allows MD5 in certain circumstances...

+  /* FIPS 140-2 explicitly allows MD5 for the use in PRF although it is not
+   * to be used anywhere else */
+  if(kt =3D=3D EVP_md5() && prf_use)
+    HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);


The main usage we have for md5 is the PUSH_OPTION hash comparison - which=20
is really not a "crypto" thing, just a "hash that is around to be used",
and it's a local thing - so changing that all to sha1_* will not harm
interoperability.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bxF9Dep5HzwGj9mC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV3/hx6kuBuNlUUl1AQIrdwP+J8NgORGE1PA0maIglHss+5AG4t/RbnXO
I6Xxr5vTJAxvIiozYcFUK772pQgRrYwClZUibghXVG7GO00X9PF6MDkcTQhyWq6k
Y7a7SfdbArt/pVgdBDlJBPpNCrAxlq9mBUXbgewUht0XttrvOpX0mePRNTEx+XiY
eXYpTkgXLVQ=
=v9xC
-----END PGP SIGNATURE-----

--bxF9Dep5HzwGj9mC--

