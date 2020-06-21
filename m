Message-ID: <1592752234.3694.3.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 21 Jun 2020 08:10:34 -0700
In-Reply-To: <20200621085315.GN1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-OfO7TActBHwRpwOFhUW6"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-OfO7TActBHwRpwOFhUW6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-06-21 at 10:53 +0200, Gert Doering wrote:
> Hi,
>=20
> On Thu, May 28, 2020 at 03:59:20PM -0700, James Bottomley wrote:
> > Testing engines is problematic, so one of the prerequisites built
> > for the tests is a simple openssl engine that reads a non-standard
> > PEM guarded key.  The test is simply can we run a client/server
> > configuration with the usual sample key replaced by an engine key.
> > The trivial engine prints out some operations and we check for
> > these in the log to make sure the engine was used to load the key
> > and that it correctly got the password.
> >=20
> > Signed-off-by: James Bottomley <James.Bottomley@...2376...
> > om>
> >=20
> > ---
> > v5: do not hard code dynamic library extension into openssl.cnf
> > (MacOS)
> > v4: add OPENSSL_config(NULL) so debian checks will work
> > v3: added this patch
> > ---
>=20
> So, how can we continue with this one?  The engine key code is in,
> the unit test code not.
>=20
> Arne, James, can we converge on something here?

Could someone just test the proposed updated v6 patch on a Mac?

https://sourceforge.net/p/openvpn/mailman/message/37031113/

  If it works then we have something that functions on both platforms
and we don't need to worry about windows until someone runs unit tests
there.

> I would like something "as simple as possible", aka "little configure
> magic" - if that means "MacOS engine is built and loaded as .so and
> not .dynlib, but the test passes" I would prefer it over "more
> configure.ac magic"
> -
> but if this is what it takes, I'm fine as well.

Right, that's what the patch in the url does: uses .so on both mac and
linux.

James

--=-OfO7TActBHwRpwOFhUW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXu94agAKCRDnQslM7pis
hR4sAQC/2oczjN0tzlmzYjfP+/zK4w+oeCAOQutNs2mtG6JvvQD/UOq+CUeCzZVu
4TEA1b/GRlurQWrNqrWIP+XBTmgpliM=
=FmOi
-----END PGP SIGNATURE-----

--=-OfO7TActBHwRpwOFhUW6--


