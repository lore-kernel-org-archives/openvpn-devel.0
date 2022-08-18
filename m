Date: Thu, 18 Aug 2022 07:55:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv3UOco92s2j57dy@...1296...>
References: <20220817233248.137722-1-a@...2181...>
 <20220818001905.176039-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XPjR02UnnPFtm1Bs"
Content-Disposition: inline
In-Reply-To: <20220818001905.176039-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] push-peer-info: rearrange function
 generating peer info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--XPjR02UnnPFtm1Bs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Aug 18, 2022 at 02:19:05AM +0200, Antonio Quartulli wrote:
> This patch is supposed to implement no function change.
> The only change in behaviour that can be observed is the IV_/UV_ variables
> being printed in different order compared to before applying this patch.

I agree with the goal of making this more readable, but that we now have
*two* loops through the environment is not improving things.  It's just
making the function loooong.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XPjR02UnnPFtm1Bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/dQ5AAoJEB2Cnv7KVigSakAMAIZ+2Ap/ESBkjziufqFSunth
DAVTgMA8ZtxjYKsBGO1WCyFP3bxABD8tjKXVZu6uqOnu/Vwx9cRs7yEDwUcn76zo
Y/pmhw7YRPSFbwr7ouTOE/l1NLunIDe/0eQbIXbwVe1pv/yYjb5WHkUbKIkcBpIM
Vgd2WUmwWC0mMsWke+Dm+lLufKrpmlz7Obgj7OzKO4umDgCrUzMYbIp6SB1g9Lhc
l2jjdYZa7dWUdbd8g7voumTAqRnMDWJwnlOwmlEM/HQjLf3IMicgXau0Lg1EsbZJ
Q5rnO1J+WcrqI8mXO4tBf3q/h2gE6WUe1wY3hj/6sQRXVcpiuWG9l0TYm3iszLMs
CysAyXJXCipmFSAtieYyKMXWfC6XstMIQXAz0d6dc3PDrEvhqqrfB5nGY9+66FAZ
LiHhpzxB+AXN6FYChhYPkbtC23xdsKP4t7aODPCWtHkbbNiBCVFJYqGUeDkZ2d/H
omr0LlFYvw6TYE2dAUgAhsUBeK9ZYCzNFviAGGf7SA==
=6pzi
-----END PGP SIGNATURE-----

--XPjR02UnnPFtm1Bs--

