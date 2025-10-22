Date: Wed, 22 Oct 2025 07:55:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aPhx4vGvodCxQ6KW@...1296...>
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
 <aPfhwvsB8Sk27GME@...1296...>
 <38497401-3a75-4885-8d0f-349c837d14a2@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JXcMVKODTJFiuVI9"
Content-Disposition: inline
In-Reply-To: <38497401-3a75-4885-8d0f-349c837d14a2@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] tcp: apply CLOEXEC to accepted socket,
 not listener
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Joshua Rogers <contact@...2949...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--JXcMVKODTJFiuVI9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 21, 2025 at 10:34:21PM +0200, Arne Schwabe wrote:
> Before commiting we have to check that port-share does not rely on this
> behaviour to pass the fd the forked instances. I didn't check right now.

Good point.  I have a port-share test instance, will test.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JXcMVKODTJFiuVI9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo+HHiAAoJEB2Cnv7KVigSCzwMAJENldRGo1fd9vTTh/cR6fI/
tPZTDAEcUz/yPWQjFXwbla8zcYVD1GCWwhpVQpzv9NVG6qKLRPzdSpoEotT9zT3V
naF4jHfBS3JZS5Es4IehpnN//tFGkvwtf50V8/9tM1LV5ARjqIU45xwc0Ltfl7bN
TlqHj4neFzO5kl6KKkMT4WRvZij4z0ESKxRhOoO7bpXa4l9ZYLBKedZqsP1rqo96
2wzOPVzImdzk9ipicViFuz5RhWaLFOjx/gPlFfmKJe95L5IwnDY0AYL4EGKRbSt+
n7DVtCnBofQzG7CLh8Voq/XRuKX7Y5Q3reZdAJCrnwINXivAOb/k2Pqt46iIk8MZ
IVGfMFQotcoAmVFRaNjI6FJa0+OE0BZamClF/fTGLlTazkG/6uqbS3CrX7L2gQDb
mJqvDJ7AxtBGk7S/LnOD5wDIC+1Y4LFbiUI3BLMrtHtkBr16/I6cuaj84Y+/6e3z
cMekFww2G0rN1tRfvFKbyntrpZGgHJhsc+uXK9Q3zw==
=tnQP
-----END PGP SIGNATURE-----

--JXcMVKODTJFiuVI9--

