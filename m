Date: Thu, 23 Jun 2016 19:52:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623175201.GJ79504@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<CAKuzo_jrwK47wDtoLNCZXP8-OG0izGmjZRrDb5vdT5shhY7FMQ@...278...>
	<20160610165515.GG62247@...1296...>
	<CAKuzo_gkAX-5USrRi8sMvwtbxiJxCwgoi4KTOC1qtU0fpHHTvQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMorpr61ug7CvG36"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gkAX-5USrRi8sMvwtbxiJxCwgoi4KTOC1qtU0fpHHTvQ@...278...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--RMorpr61ug7CvG36
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sat, Jun 18, 2016 at 03:41:22PM -0400, Selva Nair wrote:
> > > This is possible, but the case for progressively increasing the resta=
rt
> > > pause is not very strong. Can we get some feedback from people who se=
rve
> > > 1000's of users?
> >
> > I would generally consider it polite behaviour... (also, it might save
> > the client from filled-up disks...) - didn't think of exponential back-=
off
> > yet, but that would certainly be another approach to consider.
> >
> > I have no idea how complicated it would be to implement, though.
>=20
> Filling up the client log with repeated retries is a concern, indeed.
>=20
> Although a proper implementation needs the failed reconnect count per
> ip/port combination which we do not currently keep track of, I think a
> heuristic count may be good enough. One could use something like this:
>=20
> n =3D c->options.unsuccessful_attempts
> m =3D c->options.connection_list->len
> rc =3D n/m   (a rough measure of retries per remote)
> timeout =3D the_default_timeout << MIN(rc, 10)  (exponential up to ~ 5000
> seconds).
> throw a SIGHUP if rc exceeds some value (resets n and starts over)
>=20
> The retry count will be over-stated for situations like one remote name
> that resolves to many IPs, but avoiding that requires more work.. Any
> thoughts?

I'm not sure I understand the math.  Let me try to reword.

So it would increase "n" for each failed attempt, setting it to "0" if
one succeeds (so the reconnect after a session aborts would start "fresh").

Leaving out "m" for the time being, "retry time" would then get scaled by=20
2^rc (capped by 2^10), so the initial 5s would become 10s, 20s, ... 5000s
(this is not "timeout" as in "the unified TCP connection timeout" but the
retry timer firing after one connection attempt is aborted).


So, now we have 4 different remotes.  You're scaling the exponent by 1/4
here, so the retry timer would be

  5s 5s 5s 5s 10s 10s 10s 10s 20s 20s 20s 20s ...

then (or, phrased differently, "one round uses the unscaled timer, the
next round across all remotes uses 2^1, the third round uses 2^2").


If I understood the math right, I think this would be useful behaviour ;-)
- fast failover if multiple remotes are there, exponentially slowing down
if all remotes have been tried.  Plus, fairly easy to implement as nearly
all needed values are already around.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RMorpr61ug7CvG36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2whwKkuBuNlUUl1AQIUOwP/TzzD3fYKpO81idLU+CPQNyQb3SgsBuM/
6tOQz4woppr1s1AnZhcrxsL0ZA9F+W1840Af7sImdGQj4VTDTFcJt/HVjA4HQSKz
/t1uJp1ZsqLchMosr6MvOMuAYxrwpr+qQWBQ5w4tkRIWBx4IlOrKZSxnNB8RjtMJ
iPNi1b6Rtaw=
=VnWQ
-----END PGP SIGNATURE-----

--RMorpr61ug7CvG36--

