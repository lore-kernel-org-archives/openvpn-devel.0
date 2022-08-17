Date: Wed, 17 Aug 2022 21:07:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv08aDKqUMOwJ4Us@...1296...>
References: <20220817131817.467-1-timo@...2669...>
 <202208171418.27HEIdol040022@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fkwrYCtWy7dAO8C/"
Content-Disposition: inline
In-Reply-To: <202208171418.27HEIdol040022@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dco: disable DCO if --user
 specified but unable to retain capabilities
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

--fkwrYCtWy7dAO8C/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 17, 2022 at 04:18:39PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> Thanks.  Bernhard has already tested this on his Debian/NM testing=20
> environment and confirms it fixes the issues seen in=20
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1017379
>=20
> I've added a bit of explanatory text to the commit message (quite a=20
> bit of blurb, actually, but the issue was confusing us enough that
> this might help future readers).
>=20
> Your patch has been applied to the master branch.
>=20
> commit da31c1654c8534658157cfe9c9de5750ee752608
> Author: Timo Rothenpieler
> Date:   Wed Aug 17 15:18:17 2022 +0200
>=20
>      dco: disable DCO if --user specified but unable to retain capabiliti=
es

I really hate to say this... but... we seem to be calling this function
for incoming MULTI connects:

I have an UDP p2mp server with "--user nobody + DCO", which starts up=20
fine (because it has root and can set CAP_NET_ADMIN), but on incoming
client connects, it goes there *again*, and then fails:

Aug 17 21:00:18 ubuntu2004 tun-udp-p2mp[2167001]: freebsd-14-amd64/194.97.1=
40.5:23821 --user specified but lacking CAP_SETPCAP. Cannot retain CAP_NET_=
ADMIN. Disabling data channel offload
Aug 17 21:00:18 ubuntu2004 tun-udp-p2mp[2167001]: freebsd-14-amd64/194.97.1=
40.5:23821 MULTI: client has been rejected due to incompatible DCO options
Aug 17 21:00:19 ubuntu2004 tun-udp-p2mp[2167001]: freebsd-14-amd64/194.97.1=
40.5:23821 PUSH: Received control message: 'PUSH_REQUEST'
Aug 17 21:00:19 ubuntu2004 tun-udp-p2mp[2167001]: freebsd-14-amd64/194.97.1=
40.5:23821 Delayed exit in 5 seconds
Aug 17 21:00:19 ubuntu2004 tun-udp-p2mp[2167001]: freebsd-14-amd64/194.97.1=
40.5:23821 SENT CONTROL [freebsd-14-amd64]: 'AUTH_FAILED' (status=3D1)


This is hairy mess of checks, double checks, and too many checks...
(a quick fix would be to add "if (getuid() =3D=3D 0 && o->user && ...)" to
ensure this is only called if we haven't already changed user id, but
it still feels wrong)

Better suggestions where to move "this is something we only care at
startup, not at per-instance config" checks?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fkwrYCtWy7dAO8C/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/TxoAAoJEB2Cnv7KVigS5m0MAKt6tGh8lkrBFmOlUs4Ge035
72bU63ZzVAdRHsKlqJgNZogtnZYrWroUb9JrRfmMQ5zfosHNYqtLy1r+HVMk84hp
i82mSROvdV8sqgbmtDs3Ndv81qfj5Z5oNB4/oeo5Cm+ZbaSxsQar1NrPXIDdyrqD
oEaslD5lFPgMdr+P9tq5BhpSTW2vnKimH1erP484V9i/qJIt2AK4eNeENt6DoVC8
/RPvvEpqc+wIYQHcca2H/9iW1MUBFF4LT80FfmVsTwtEK4nDyjCfPpfmWhZHrhtK
a+P/2SFxuPfcwz9ua28MOwwZgtjOWxg5NenPZ1uoVvExDOFt35z7bAv516sTIdWc
VaVqMDpxoBYFV4CNZrfoIIDUjeBYLruz/k/YCsYsmAIYrGZFBRngsfMXZQG7mDRx
ZiyozdN1F+7l7Hc5Agtws5UkdWBfqp6Sr8dBPFazGLWHGiwMAA6PDorDDGU/BML6
d/s7KhyWRzd/wCjp1ir+CWYna8nz7PLec7x3MPhZew==
=05Ug
-----END PGP SIGNATURE-----

--fkwrYCtWy7dAO8C/--

