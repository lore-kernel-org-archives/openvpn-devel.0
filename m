Message-ID: <1592940762.4768.52.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 23 Jun 2020 12:32:42 -0700
In-Reply-To: <20200623192627.GA11911@...1296...>
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
 <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
 <20200623184733.GK1431@...1296...>
 <20200623192627.GA11911@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-E7qSaFaDq3HSc8zLdR2j"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=-E7qSaFaDq3HSc8zLdR2j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-23 at 21:26 +0200, Gert Doering wrote:
> Hi,
>=20
> On Tue, Jun 23, 2020 at 08:47:33PM +0200, Gert Doering wrote:
> > On Tue, Jun 23, 2020 at 11:36:49PM +0500, ???????? ??????????????
> > wrote:
> > > Also, I think we should out log.txt in case of failure.
> >=20
> > Indeed, this would help.
>=20
> Yep.
>=20
> The "make distcheck" travis instance is now happy, but the "1.0.2u +=20
> enable-small" instance is still unhappy.
>=20
> James, are you triggering on specific openvpn messages?  "--enable-
> small"
> changes these (trimming some warnings and help texts).  Can you test
> with
> "configure --enable-small", please?
>=20
> https://travis-ci.org/github/OpenVPN/openvpn/builds/701385033?utm_med
> ium=3Dnotification&utm_source=3Demail

Yes, that's it.  The problem is the message output by openssl is

2020-06-23 19:28:46 OpenSSL: error:0B080074:lib(11):func(128):reason(116)

Instead of:

2020-06-23 12:30:43 OpenSSL: error:0B080074:x509 certificate routines:X509_=
check_private_key:key values mismatch

I think I can make the grep work with the former.

James

--=-E7qSaFaDq3HSc8zLdR2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXvJY2gAKCRDnQslM7pis
hVnhAP9gvu6i4ph/GoDOCptFNF1xK+32toDQribEl40CgudVzgEAma9XPDOnaK7b
0pqY6Rn5gZA6OzvFaf5TdgrZ7rSDgJw=
=z0I3
-----END PGP SIGNATURE-----

--=-E7qSaFaDq3HSc8zLdR2j--


