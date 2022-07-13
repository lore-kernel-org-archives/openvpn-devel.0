Date: Wed, 13 Jul 2022 14:05:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ys61F3NAxa62QFIW@...1296...>
References: <20220713083404.13227-2-kprovost@...2661...>
 <202207131200.26DC0UW9083066@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZLlzJlZcFXajD+/n"
Content-Disposition: inline
In-Reply-To: <202207131200.26DC0UW9083066@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Handle exceeding
 'max-clients'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: openvpn-devel@lists.sourceforge.net

--ZLlzJlZcFXajD+/n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 13, 2022 at 02:00:30PM +0200, Gert Doering wrote:
> Quite obvious in hindsight ;-) - good catch.
>=20
> Your patch has been applied to the master branch.
>=20
> commit 6e47cadd6219a8a9da8c2c1558652bbbbf274a10

Apologies.  My tree was not clean, so this commit ID is wrong.

I noticed before pushing, but after having sent this e-mail - so the
right commit ID for this is

commit ac14d90e7e5a80c57d064b1d3a5deb1db63b0911 (HEAD -> master)
Author: Kristof Provost <kp@...1376...>
Date:   Wed Jul 13 10:34:04 2022 +0200

    Handle exceeding 'max-clients'

which goes on top of

commit ad085464b15d63324846d0a5151141f58ccb5a34
Author: Antonio Quartulli <a@...2181...>
Date:   Mon Jul 11 14:23:48 2022 +0200

    options: don't export local function pre_connect_save()

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZLlzJlZcFXajD+/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJizrUXAAoJEB2Cnv7KVigS9zAL/258jvRSUZQ+edZEIZIvQxsU
XMXj/Dnk9uZDqcfPSMNsKO6kHkHEcOhPY7EVY8qS8F6DKmIH+f3wQToWwtk+gKle
tD3mS/VgGhoUYKX6GEgwXD+JVA810J2TGZEGAouz4RohVwgKCjo5/lUDQ9Z++ieh
mmzF0sqcFVlJH+D4pARwRAt38A2lR4JmPFgPLPBgXNZQwYfHKAtIP7tzoQOgOfcA
DK6nqBfudfq4WcWVK62r9D0GeO5+Fb8U2Acd+HLowbGl9bD5lFjYD8yGUc1RaKb4
DbJEFNwIaeW2TXJuB7hq4Bjl/SMqR6W1K26CunzZKu3P3JAernBloBVuMv/yaRJF
1Zesdkk1sJ7YRE8fxacyQD0IL6VNDVKbxa1jKwM4xbR4Av/jrHbLldHWUB8qkWlf
KXMnGFE4qaaikej/eKoZ2ic9SQa5vfef38TbFbf+eX0DUdoF4qWBoUsnarn6seRz
8ElGY6yASVvf3U5QQurDNCzwJ0wbUsz9S4ZC0C6gAg==
=lBc1
-----END PGP SIGNATURE-----

--ZLlzJlZcFXajD+/n--

