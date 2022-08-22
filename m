Date: Mon, 22 Aug 2022 20:16:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwPH6uZzbYAJ3UeP@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Bb5jTQ9FbDBSR3k8"
Content-Disposition: inline
In-Reply-To: <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Bb5jTQ9FbDBSR3k8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 22, 2022 at 02:55:09PM +0200, Kristof Provost wrote:
> > Now, back to FreeBSD.
> >
> >   - our code does not try to set metrics on FreeBSD
> >   - my reading of route(8) does not show me anything in that direction
> >     (metric, preference, administrative distance, ...)
> >   - I do not understand FreeBSD internals well enough to know whether
> >     it can be done at all, or not.
> >
> It???s rather poorly (i.e. not) documented, but it is possible to set a=20
> route metric. It???s called a ???weight???, and not actually mentioned=20
> in the man page. Or shown in netstat output.
>=20
> But:
>=20
> 	$ sudo route add 172.16.2.0/24 10.0.2.1
> 	add net 172.16.2.0: gateway 10.0.2.1
> 	$ sudo route add 172.16.2.0/24 -weight 2 10.0.2.254
> 	add net 172.16.2.0: gateway 10.0.2.254

Oh, this is interesting, and good to know.

What is the default weight?  "1"?

> So we can add multiple routes for the same network, as long as they have=
=20
> a different gateway.
>=20
> The usual `netstat -rn` doesn???t show the weight. You have to use the=20
> json/xml output to get it:
>=20
> 	$ netstat -rn --libxo json | jq
> 	???
>                {
>                  "destination": "172.16.2.0/24",
>                  "gateway": "10.0.2.1",
>                  "flags": "UGS",
>                  "flags_pretty": [
>                    "up",
>                    "gateway",
>                    "static"
>                  ],
>                  "weight": 1,
>                  "interface-name": "bnxt0"
>                },

Interesting :-)

[..]
> A higher weight gives a higher priority, so that???s the opposite of=20
> what Linux does with metric, I believe.

Right.  Linux metrics are "lower is better", like a routing protocol=20
cost would do.

[..]
> If I???m understanding everything correctly it should be relatively=20
> simple to extend networking_freebsd.c to also set a weight for each=20
> route it installs.
> We???d have to convert the metric into a weight, which I think we could=20
> do as `weight =3D RT_MAX_WEIGHT - metric` (RT_MAX_WEIGHT is 16777215 /* 3=
=20
> bytes */).
>=20
> Can you try this?

Looks good, might work :-).

Will give this a try as soon as time permits - next 2-3 weeks might not=20
work out.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Bb5jTQ9FbDBSR3k8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjA8fqAAoJEB2Cnv7KVigSmhQMAJYEaHQBC6mO7aetjO+NeuXu
n5m/dojgjM09R18FUjD2V9J7N1cBu2ud09XxdkOBTN9Ya1mXxDijPkwhpd/X6Saf
KlOPVer9Di9zYLZIwYRmT3sPJgmubi3BfjA6ytATsjGL+7E3HcFrIgkKUisJDzsn
tYOnOXu8Is8OOWUH5WTkI64E1LsQ+glCyCJBD0yV9ptIiuEsVfvZYw50kddN2cqH
6HjEi6FM7Z8KErsYnBW62EwJoNtfFcciIQC+VKiNV2zON1rl4YfEZEa/LXKVOKRn
q1ca9XQRDLoCYSPQO4Aqgb+R27QT2y9ChmJmG96V+oRzuhFMszalOdZCljQ4xYbo
CzZN1qQ6xvhCKkE/9VAhhUgY3DkAOhHmsatFpdHclP8ZOKCk8QVsWQCTug9rCNhm
2AIUpmZQXlVmpBGHVWPXCC1gVHbIuENEJwSFiV/+lGiazohxKK25cELQ81Aw+H+i
HAP7cvyUFRsnNy0Pxd6LFuohLoRrASh+Tdhpne7L7Q==
=tU/f
-----END PGP SIGNATURE-----

--Bb5jTQ9FbDBSR3k8--

