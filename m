Date: Mon, 4 Oct 2021 12:52:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YVrc/1PV72e1WcNC@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EkxU/amoyhAJa5OC"
Content-Disposition: inline
Subject: [Openvpn-devel] [dbelyavs@...1347...: OpenSSH with OpenSSL 3.0:
 preventing loss of remote access]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--EkxU/amoyhAJa5OC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(this is mainly for Arne and Selva, but I've decided to post it to
the list to raise awareness).

OpenSSL 3.0 seems to bring "interesting" surprises with their provider
thingie, and openssl.cnf - not sure if this is at all relevant for=20
OpenVPN, but it sounds as if it might be.

gert

----- Forwarded message from Dmitry Belyavskiy <dbelyavs@...1347...> -----

Date: Mon, 4 Oct 2021 10:57:28 +0200
From: Dmitry Belyavskiy <dbelyavs@...1347...>
To: OpenSSH Devel List <openssh-unix-dev@...2635...>
Subject: OpenSSH with OpenSSL 3.0: preventing loss of remote access

Hello,

TL;DR. Bad openssl config can break remote access to the system via SSH.

OpenSSL 3.0 doesn't provide any crypto primitives itself. It is done via
the providers' mechanism. The provider should be loaded and activated to
make some algorithms and RNG available.

The default provider is a bit special. If no providers are activated
explicitly, the default one is activated implicitly. (See details in
https://github.com/openssl/openssl/issues/16249). Its activation is
commented out in the config file. If anybody tries to activate a legacy
provider and doesn't uncomment the default provider activation, the system
becomes almost unsuitable for work and not remotely accessible anymore.

I am pretty sure that there will be enough people who because either not
reading the documentation or just being in a hurry will turn the remote
accessibility off.

To prevent it, the viable option is explicitly load the default provider in
openssh if necessary.
We can check if it is necessary in several ways. First, we can check if the
default or FIPS provider is already loaded. Second, we could check that any
algorithm (I'd prefer some of the AES-CTR family) is available, and load
the default provider if not, implying that it the selected algorithm is
implemented in the provider carrying also some sort of key exchange
algorithm, RNG, etc. I have a tentative patch for this purpose.

There also may be an option to add an explicit switch
'FallbackToDefaultProvider yes' to the openssh configuration.

Please, any feedback is welcome.

--=20
Dmitry Belyavskiy
_______________________________________________
openssh-unix-dev mailing list
openssh-unix-dev@...2635...
https://lists.mindrot.org/mailman/listinfo/openssh-unix-dev


----- End forwarded message -----

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EkxU/amoyhAJa5OC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhWtz/AAoJEB2Cnv7KVigS+Q4L/jhjjQ7eu51iyf4TjZ3Mp/jJ
GBMk4eso9cuJ70loZnCv1TkXaPoYwdAON8RrD+E7KotxVEl1Y37OfitCBBKlEqFM
/Heib3wqpm+QY7zJ/FrIaRjvc2azf9FhZp9a8gfQupxGLlGAfiRYttffWJDGYgGc
+nKKYeXRDo3+lC6iOmktAlgxgz65uG3CKirzd+9kHMtI7pgmMtb+xNlC29ZZB7XC
RJH2001F+9IcM9Gq69dPg/8qb81OagvlnGUUnGBTpXf8PegUR3uxK0uw+qxLlnoB
RHNrtpWyFunIXjsI0YEeuErAIt8G2qrb1N1N5zWFu7wIw/TAwcZMrUaY8QFqj6Re
XcjVVbuawNj5A+/XtIAODkkXbYQaSyWXQPhONRTIbNbafq/QT9qKV6e9KRY64G4e
1lyh0gI3AEI+9NkyCi/5JxjtVlNBaUOUFKxcsYjj0u/dDf7PJnDJ+/nT8hNjvbKS
oP7zhG8509kjpVY9/3KcrCWtRVUhVuLPO44vPrYwxQ==
=Likb
-----END PGP SIGNATURE-----

--EkxU/amoyhAJa5OC--

