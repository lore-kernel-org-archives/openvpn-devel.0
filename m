Message-ID: <52B8607E.9050202@...1085...>
Date: Mon, 23 Dec 2013 10:10:38 -0600
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <l8qvsn$jif$1@...1062...> <52B2D210.1090004@...515...>
In-Reply-To: <52B2D210.1090004@...515...>
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/19/13 05:01, Samuli Sepp=E4nen wrote:
> Do you think easy-rsa 3.0 would be a drop-in replacement for 2.0 by the
> time we push out the OpenVPN 2.4 alpha(s)? I believe that'll happen in
> Q1 next year. I can package easy-rsa 3.0 for deb/rpm distros as well as
> add it to the NSIS installer for Windows.

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yes, this is very doable, and an -rc2 is pending shortly to allow
testing with the recent changes. In particular I have been informed
Tunnelblick requires the 0.9.8 OpenSSL support, so this will be good to
release for review at large.

The functionality now is a replacement for all v2 features available
today under Windows since PKCS#11 was targeted to Unix-alikes and
wouldn't have worked without modification anyway. Some of the features
like nsCertType extensions are not the default in v3, and updated
documentation will make upgrade differences very clear.

I toyed a bit with including PKCS#11 support at a basic level for 3.0,
but simply porting the existing v2 setup won't work well with splitting
the keypair and request generation (allows new requests from existing
keypairs) which is a potential goal for 3.1 for improved flexibility.

In light of the complexity involved with external tokens, I don't think
PKCS#11 makes sense to ship with 3.0, but as distro-specific additions
for a 3.1 release. This too will be made clear in the documentation.

- --
Josh Cepek

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSuF+DAAoJENcx2Xpgb9Rjh2AMALTiOVvYuNjxoEPFRPDpUC1/
gyyJ4Om1hn2Q2/CDxl+NPOPdjBJxzcPv1DUE8yn489YtNeXBkKHf7y0OqGrQ0Ltp
7z+50sXYkQGy3Q5GJkziTbnQMKLyFlZuSurjMr9X9HCx/QMAWzoX+jnor0EYF7Cd
bVLYDJtyY7OYgyPOQ0Z/nKWh0UY3RSv86+QGHNtaxLqbhQUAPE3/XC09pvQRFxy8
7SuxbkSkGVoSsx4/09e0ZmTkD3d+ou14px9YQZbGx2sDxvxJSlobr2kUP8ucJsqB
vn9gArKwspfygRfQY/soDPb9paCGFEEbHDhzECKW6XtvUGmc7g0EJp7z54NaLXlP
wMv4BkI+i4xXaalKx3opsl8EFlH+CmnIALt3+Yhq59vKDkLeWTX4WkrhCXjeBzmK
wm4bdmD3SmIo0pKamIV4z1wXFxrjM3cVNcaFKcctzyzKPqb4KQXhBRwCO1vXmma9
YQW9YIFDZ3BC07pveUemodOrWf8eSQoZFAd3lUg6QA=3D=3D
=3D4aoX
-----END PGP SIGNATURE-----


