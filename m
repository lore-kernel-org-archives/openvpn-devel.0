Date: Sun, 15 Jan 2023 16:30:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8Qb+mjcXMe035LR@...1296...>
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <af0497ca-b862-6a5c-f5ff-eb0d34a84692@...1227...>
 <0456a9e2e317af58f1aa6947c768ac7853c06485.camel@...2316...>
 <334bc5ad-1d55-208b-bbaf-2233c4708d9f@...1227...>
 <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zf3qsYjD6n+6ongt"
Content-Disposition: inline
In-Reply-To: <f24287289b084285b67fc1a7fb26714fec3f0bbc.camel@...2316...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--zf3qsYjD6n+6ongt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 15, 2023 at 10:22:06AM -0500, James Bottomley wrote:
> >  And then the restrictions become a problem.
>=20
> Only if the library you're linking with isn't a system library, which I
> think we can all agree in not the case on every Linux distribution
> because they all ship both openssl and mbedtls as part of the
> distribution.

The open source world is a bit bigger than "Linux", and not all the other
platforms supported by OpenVPN (none, to be precise) ship mbedTLS as part
of their OS distribution.  Some do not even ship OpenSSL.

ports/pkgsrc/... are very clearly "3rd party components", and not
"part of the OS distribution".  Gentoo ebuilds are something in between.

As much as we'd like to declare this a non-issue, pointing to the system
library exception will not help us solve the problem.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--zf3qsYjD6n+6ongt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjxBv6AAoJEB2Cnv7KVigSw6oL/AyCqNIgc+c8rYQv1n0DWqUj
9YnPGuEwghi14qS6eh0XhY9GCuJugcbWwrPVtZuFFI493LS+lZcGCLJ8dxzkmjTU
TxZuAwbpCGcxz1DcJjV9o5vyPxJ9Mz88Lik0qZqekmNArxVG7EUx25mfXYPfSLYv
2BnoQZpTUsoAsw6K1msEFBOuBT8alXp/yQouuklZ1y5sW2YeAUNErzTGQKoBYpd8
fJroOIlZPrpm0EVpO3dJe9Xciehz6bUkYGmeKWZoXSwRSUMNBdwL8uRGK7kliC7l
ol1SBMiHAAeWM7l43gT9Z2lOsLivWMPgiJJHYAD7oYU6RzlyxSaWIJVfh9mDWOhH
MqTWb+RjgSN8V2d7yWHzrCwrFBNAweN43QeWV4RSJDPqjG0zKdKbS19g7fs+MP/V
eW7DLEE3lEH7PWIA3NeI2DryeK0SU5qqjsorXq36s2axn0AvU97SrplCwH0eapZY
LsExTPfZj61oo2KctjVb82SFaPi69GQbfnrNF6DCSg==
=GHtP
-----END PGP SIGNATURE-----

--zf3qsYjD6n+6ongt--

