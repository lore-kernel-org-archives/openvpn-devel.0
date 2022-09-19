Date: Mon, 19 Sep 2022 09:11:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YygWLIqh1MIdiZ0m@...1296...>
References: <20220917231030.22565-1-a@...2181...>
 <Yyb07u4pG0Ii9vQf@...1296...>
 <dca91e77-175c-9540-7993-112ca7a4661b@...2181...>
 <YygN5ZRAAMA1xdrj@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kE08ZVEopDzBHHGH"
Content-Disposition: inline
In-Reply-To: <YygN5ZRAAMA1xdrj@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] implement --session-timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--kE08ZVEopDzBHHGH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 19, 2022 at 08:36:21AM +0200, Gert Doering wrote:
> > we don't get here at all, if we have no event object that is timing out.
>=20
> process_coarse_timers() is run once per second, and does not need=20
> additional timers to be called.
>=20
> This new check is added to process_coarse_timers().
>=20
> Why do we need an extra event object, again?

Mmmmh.  I think we actually might need one, to ensure that this fires
only *once*, and we can then do what is needed (like, explicit-exit-notify,
reliable TLS processing, etc.) without raising more SIGTERM on every
future visit here.

(Of course we could avoid this by resetting the session end time, but
then it might be easier to understand if we use the existing mechanisms,
even if a bit heavyweight)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kE08ZVEopDzBHHGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjKBYsAAoJEB2Cnv7KVigSQC0L/jHYmhJxPuDreFNt7bUCs3Zh
RY90A5SgTxHOGeiodpMV3hiOY9PmgNtZRTm1kwHFTFcpstsKN4SVTVHzTJMsZtP/
GwDo27XZsTrW7sKSPzJhLWbXjMlTb0P2Z+wueKXk3hnCIXBUGrGlTZJyepLfbRY8
vAG/z2VxjZ+MpBtD91OWPNOEgrU3K4b3PzIVoSVNrDyUWKquGjbIYnhqfrTSi5CV
78r6qn8dO7a17mkujU7P6FSukjQY3SFZCgucIVGdci0aWWZDp13qrdK4IyT6+iCF
LjhjpNsPB513CIllZ32kKiDwi92N5c4d7mA4y+cWjKug0NL7bTbtO2ToHDRHoFip
MwLmVuNFn7LJs22vAO+34wWsItgFRiI3wsXQxG5faMu6N9PzwnFXTY0hQKZM1Rx7
PKeF5WQm4cMQ6Dg8vdgGx4ie9GeTEoi7tl3RnubJve+puZtC979XdxnQoWEio5X3
R7dwAoHfT4uIwG1Zh8nCegDAflGkCErleTEYLKFtJg==
=hOrg
-----END PGP SIGNATURE-----

--kE08ZVEopDzBHHGH--

