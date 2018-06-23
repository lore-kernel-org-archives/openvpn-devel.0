Date: Sat, 23 Jun 2018 20:16:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180623181648.GU57262@...1296...>
References: <201806231209.w5NC9AhF028415@...2054...>
 <20180623121503.4080-1-gert@...1296...>
 <20180623173104.GT57262@...1296...>
 <CAKuzo_iE0zU_6+19+V0QSSbU0sBpSYtJU48uLaS_ireoj81n8Q@...278...>
 <0afcdadf-9270-a709-35bc-66318e58f8f5@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2r9at8cGmvB+qaMS"
Content-Disposition: inline
In-Reply-To: <0afcdadf-9270-a709-35bc-66318e58f8f5@...2181...>
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
To: Antonio Quartulli <a@...2181...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2r9at8cGmvB+qaMS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 24, 2018 at 02:12:29AM +0800, Antonio Quartulli wrote:
> > That should be enough, but we could get fancy and use -1L and compare
> > the result against sprintf(str, "%lu", -1L)
>=20
> I just recommended something similar on IRC.
> I think it would make sense to "validate" argv_printf* against sprintf.
> Not just for %lu but also for the other formats. This way we know our
> code is doing what sprintf would also do.

I'll go for the "just 1" thing so we have something.=20=20

If one of you feels bored, I'm happy to test something more fancy :-) -
but I do not feel particularily like "coming up with fancy tests for
argv.c" today.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2r9at8cGmvB+qaMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLo6QAAoJEB2Cnv7KVigSZ2YMAKqNJbxI6TdOtiLDPI4rYvqm
a9cEqbdtSsg75rRgDfEzaZNdNRPPo6pmK3eOY8MADiAxAkVA+0WDkpbd5cAQl+8/
U3YXJdzyD1N1JI1N6WNKd6UZY7wXNem1w7Skfslj9myGijkfaT2MlcWiFPF/dy2N
H/eSMALygEgzG/T5CR0rXEqpTg0zpInEPm//1igi6ks/FqDc1zolwIWjER7vzlKM
NzMqB8iO46wPf4kNPuk27qTnttaCiQhXfFMKiez7Ok1N9rbeHJUm6LErTwKLfCND
FWsiAHd52QW53YpwC1tZVDkj3XDIR6I5rWn9vThwWCKWKAWv7L/M2Vk4mxcjSCu/
zQNGyg+wGiYfgYHqNE/A6YIpxZqDAVd2XBQWX9XgDD49oAhC8/MBHI+SGOioBAWz
wXGnWA/lvZqD++SwWLdyjj6NvoxV3naVfY0PDUr5JYgH3jDMXAiz/tUdV7369z+Q
i+Nbxevshexz46q1/G4PcCKYarOyX+C9dXW4Vz4coA==
=j6uk
-----END PGP SIGNATURE-----

--2r9at8cGmvB+qaMS--

