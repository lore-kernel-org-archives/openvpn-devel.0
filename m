Date: Wed, 5 Apr 2017 22:42:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170405204236.GM93896@...1296...>
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4gNoFi8SKrkInYGX"
Content-Disposition: inline
In-Reply-To: <86ef0241-5144-206a-4691-6713434fdaa4@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--4gNoFi8SKrkInYGX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 05, 2017 at 07:00:54PM +0100, debbie10t wrote:
> > Optional option does not mean that it is disabled by default. If you
> > don't the randomness you would need to do:
> >
> > reneg-sec 3600 3600
> >
> > the optional argument also allows it to fine tune it to your needs.
>=20
> As the reason for --reneg-sec is to specify how long a key should exist,
> I don't see any further need to make the "random window" be specifically
> configurable .. The reneg-sec period will remain as specified (def 3600)
> except for the first run, where --reneg-sec is started from a random=20
> time between now and then.  There after returning to "normal" with full=20
> randomisation of all connected clients --reneg-sec being spread over the=
=20
> *entire* period of --reneg-sec nn and not some unnecessary window.

Setups with 2FA will have to re-enter auth credentials on reneg.  Having
OpenVPN all of a sudden default to "it could be asking 5 minutes after
connection for the credentials again" is massive annoyance - and brings
no real benefit anyway.

It makes sense to jitter reneg-sec somewhat (like, 10%-ish), but changing
behaviour too much is not bringing much benefit - you don't need to=20
spread the reneg over the whole period anyway, as different clients=20
connect and disconnect at different times anyway.  Just if all of them
connect at the same time, the identically-timed renegs are a problem.


I like Arne's and David's suggestion - the existing option "as is" will
enable X% jitter, while a second parameter can specify a more specific
range.  Following Arne's argument about users and percent math, it might=20
indeed be better to have "min max" here ("3500 3600"), because that is
really easy to understand and explain.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4gNoFi8SKrkInYGX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY5Va8AAoJEB2Cnv7KVigSCTYMALM9E77w1Dw+gN8TVFyuYWRQ
1XQ7aZeOFbJkjCirlJXAqoXemHfrsb/3aE56hkxKlteMHnfm2ehkxD7IovLw+lGJ
tBubH9fLDjfscAf7c9L5CCxveTBjwI3IaGCsKiRWz8ODAJLGf1AXnO5yMFXHzJ9G
FCgZdyrMxK+Uuht9e9WXqdWcmmNgxFD2CASUGjTUYgofpqHr5FTQIGk0TKkzjPfl
uN62FKKuYmFVyTaCYC1drpIiMa8kY9jmM/uuZ2Mv3U3xf1AmceuiTOFG8UT0njso
Vai8DHLIzUeSfBpMQG4sY5CDNqenLxGWnlfLR9fitq+h5DMQoaxeyRIoioKqd48m
pPMhp22Y7NUOVWUw9aa00i2mdIyLM4o1mDlZwkUqkA2lTJqeZMcRS/81Onn5OHKY
c/JCc2zhCk0w9SeFg9sVPfuGfcbk560tvkP5QeBxbNprYa6CpKiHiagwKxpLdTHX
SxrNqqI6lrINtmBYxg4gnN9KYRFtbOgXVxzPL/BNwg==
=GXJR
-----END PGP SIGNATURE-----

--4gNoFi8SKrkInYGX--

