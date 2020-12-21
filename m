Date: Mon, 21 Dec 2020 20:11:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20201221191127.GB976@...1296...>
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
 <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mpbdVK9pqhR9zQdg"
Content-Disposition: inline
In-Reply-To: <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mpbdVK9pqhR9zQdg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 21, 2020 at 06:24:36PM +0000, Greg Cox wrote:
> My contention is, a VPN client has enough information from its own certs =
to
> know when its certs are expired and thus not going to work (Yes, there's
> plenty of OTHER reasons a connection can fail, but in a well designed
> setup, the user's certs will go stale long before the server).  It tells
> you this problem in the logs, which folks never read.=20=20

We consciously decided to make this not more prominent (so, warning only,
not error) because the client's machine's time might be wrong - and=20
ultimately it's the server's notion of time that decides if the cert
is valid or not.  So this is a hint, but not a "IT WILL NOT WORK!" hard
error.

> If the software were
> to contain a mechanism to make certain failure cases automatically more
> prominent, particularly for 'simple' users who have GUI clients, it'll be=
 a
> big win for supportability on larger installs.

This is indeed getting into philosophy... we do send different types of
AUTH_FAILED today (like, for token expired).  Maybe we could send an
"AUTH_FAILED,cert expired" and have the client display this?

(I admit that I'm neither an expert on AUTH_FAILED message, nor on
"what is the client doing on variations of it", nor on "what *should*
be the expected outcome?".  Selva, Arne will know more).

> And I realize this is getting into advocacy and away from what's right for
> a -devel list, so I'll stop here on this thread.

I find this a very useful exchange, and I would call it "on-topic on
openvpn-devel".  The openvpn-users list is more about "end user issues",
but what you and Max bring forward is "this is where openvpn could be=20
more helpful for admins" - and we developers want to listen to that :-)

For me, openvpn usually does what I want (and if not, I start threads
like this one, and try to either code it myself or convince one of the
others that "we!" want to have this and they should code it :-) ) - but
since this is openvpn, there is a myriad other ways to use it which I
might have never thought about...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mpbdVK9pqhR9zQdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJf4PNfAAoJEB2Cnv7KVigSrpEL/RCFgoCeZk6DOSuKIC5OzDUs
vXGfeSMez2LFPy8XdE8tdjlmzylu7/jqxuzrhOW3FpZt5LV6jLiP0ywAgkKAVl1j
NKERgK3p/NzS/IklvE1r9kpQ78s5rNsCVijE3w4ZgMWix0F3QglFL7210dX/PnsK
Yuybv44K6wr1eR1eU1o5wpX1Qfa0fZtQSrxsPxRb9Z2B1PywFkD0XWZ91SBdSzRg
VN/ZFmwYf15i+t5rdIujdPbx7L6xgX7h7HimLPURvgc9MrbYqn1qsoPlcWKSIHt+
OkSz20jC8RCYZnsQWYQQTJED40KUatKPppQrHEqpiSL3zkWnNS0iklvkJMFutNE8
0EbutNQBkOL7K+Kc+uqo79rI8Niie9Ufdyg7b/PLlXjrIwbuELPhOi3WP1YhQ6TR
Gc4MmXr3u5Dim0sJGyKOh99kKNC0x9b2srak/GnJQ/aFp2gwYg5B0N+iD+DRZ83n
3jkmKPMcRhblJPbvMdlToNknjutBBdeGnL44nMlazw==
=ORIa
-----END PGP SIGNATURE-----

--mpbdVK9pqhR9zQdg--

