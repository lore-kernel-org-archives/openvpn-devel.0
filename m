Date: Wed, 23 Oct 2024 16:43:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZxkLm_LadCi16JTV@...1296...>
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dqDAqMa9ulRLSIvq"
Content-Disposition: inline
In-Reply-To: <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Razvan Cojocaru <rzvncj@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--dqDAqMa9ulRLSIvq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2024 at 05:40:43PM +0300, Razvan Cojocaru wrote:
> In this case, we want to disconnect the client and it should stay
> disconnected. A simple AUTH_FAILED for this scenario will have the client
> attempt another connection. But if we invalidate the token, then the clie=
nt
> will not attempt to reconnect.

AUTH_FAILED should do this automatically - invalidate the token, that is.
Can you show a log where this is (not) happening?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dqDAqMa9ulRLSIvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnGQubAAoJEB2Cnv7KVigS/rcMAKZ1b/hgs9WvHstrm/S8jG9n
5IJjXy8rLHsmSYwNs63fM065sKFxCWaf4BQ+R+ZU5Z1Skv95axfhCSPDCFxtrQlI
FbXgZK27NXq7iOQ/35OhcKxKmGInHN/NdPpOqKis0lwlQjfG3UbZhvvQqrNHXeSP
bFcpc/BgJbhNenG0N1J+EUZ6t0OsaE2KOw5CLYdnRdhmgc1CGdv9x6FHI8C4Ijnu
bNbdgEw01TIUhWtLLH6s4Fxtuwt1HUDEIN4qaUILJrbz62SsfgAInhrVAmOdaXFe
8q921mSMwLhbqgIXPBB03GrnmSDE/AcOhHWVlrqdYQob5fj6HwOjHwrGrn7vG7LH
WQLsyr8ze+rYQEmtKWq/qWmoK+DXin+j94PetiK2++Z+zKMG9HAAXzos7bixrlMG
RI9KHzJ0njVBTzF5pOLVM+/rhpPLIir2juVmLhWilg+nRQn/FvbmK6eNRBIsnubD
yg5QzG0gmdFL/2Xdbdsh2q0dc4lWy0VXAFcf8WYeZw==
=g+c7
-----END PGP SIGNATURE-----

--dqDAqMa9ulRLSIvq--

