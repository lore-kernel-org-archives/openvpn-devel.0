Date: Mon, 19 Sep 2022 08:30:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YygMkyR+zgManlgx@...1296...>
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
 <61a61f4a-a7e7-ad3b-a029-ce351c310a4a@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="01ShldvW9bLbe+li"
Content-Disposition: inline
In-Reply-To: <61a61f4a-a7e7-ad3b-a029-ce351c310a4a@...1227...>
Subject: Re: [Openvpn-devel] --explicit-exit-notify and P2P mode (trac #1337)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--01ShldvW9bLbe+li
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 19, 2022 at 01:17:32AM +0200, Arne Schwabe wrote:
> In our current state where inetd is no longer supported, this behaviour=20
> to exit makes little sense and we should probably change the behaviour=20
> to SIGUSR1.

What does SIGUSR1 do in p2mp mode on the server end?  If it does what
SIGTERM does ("terminate this client instance") this sounds like a good way
forward :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--01ShldvW9bLbe+li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjKAyTAAoJEB2Cnv7KVigS5cAL/AoSo93DxELp1iiddgnGGN94
sYX4dR+tccrLOf7cTIKoMh1mi0HXhvHbCm3WwiPstHXWoZx9XLHoGpDFX9/5dYpV
INRvYW6APDr7groQdnu50Q+H+L7s0UsjwXdVDnd+J3qV7dAGwLuvjy4VWfKdtSYe
H7o9FnfUBuYUuz8aXl949yv9y4SoFSv3Rl+/3V/ubPUG6tRPBb4dR6oUc6CqLVLp
SsoX9UiPiZV+oqzPLh5uSCiv30HymmIg0LBkpoI/6N7Lwb/dkaEeU1Ku/Btn74L2
+Y3vwAyY5LrkztV2Oy8DFeeTrtm7wMq5gCZlaUUcMVP4QIT523uurKcTqQKS45uZ
mxYd1zf7mLd90oLtVjQsGLrvNaZlUJ1pQXvefxDJ/Jhv2aux8dHEaQ+FtNkVhVzY
1/YAwQ+RpSRmZkNx50o0zUZaJXghFbDEZNrCDZ7knBTauBup485Mbmqty/Ind00a
4RvmH3c1ingnRfcUPAbItxuFhrksHEJO7Lmy2VFzgg==
=m6Pa
-----END PGP SIGNATURE-----

--01ShldvW9bLbe+li--

