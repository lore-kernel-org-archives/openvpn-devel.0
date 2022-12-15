Date: Thu, 15 Dec 2022 15:16:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5ssVYJGZT2KfR5A@...1296...>
References: <20221214224220.307-1-lstipakov@...277...>
 <202212151234.2BFCY9af082666@...2054...>
 <CAGyAFMXzj1yQtq9Yvy5sJXXov0LL_x0+Dp8P6ic09_Zs+fLZUw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q/qwXnEh0LsH2eHp"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXzj1yQtq9Yvy5sJXXov0LL_x0+Dp8P6ic09_Zs+fLZUw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: management: add timer to
 output BYTECOUNT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--q/qwXnEh0LsH2eHp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 15, 2022 at 02:48:49PM +0200, Lev Stipakov wrote:
> > So it seems as the timer activation got delayed somehow
> > -> this is something we need to come back to, when Linux/FreeBSD DCO
> > stats get implemented.  Starting with "management-hold", then "bytecoun=
t",
> > then "hold release" gave me counters right away.  Mysteries...
>=20
> This is because we do not trigger this new timer (for example by
> calling reset_coarse_timers)
> when we init it in man_bytecount(). We do not have "struct context"
> there to do it.

Ah.  I guessed something like this - thanks for explaining why this would
not actually be easy to achive.

> Follow-up calls to reset_coarse_timers() or process_coarse_timers()
> will do the trick. However, in DCO case nothing might happen in userspace
> for a while, hence delay. GUI does "management-hold", sends "bytecount 5"
> and after that "hold-release".

This works (tested!), so the point above is not a serious problem.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--q/qwXnEh0LsH2eHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmyxVAAoJEB2Cnv7KVigSPIsMAKCsqSK7Ov5nnEmaFpvEK5z3
8l2sTBunCr82UkTFxy2/Dneic9gRKCbZE6yModtZwQvJCTLwlblHnZ2o4LYSKFnl
4XPewc1dU1FQChN2twMwmO+7w4vHePQs6NhhwP+81Gy0yhfxfBO8pCM6dEuqbq/C
95S0NbQP1ShaKrLMW0qLrdtV4xw6UrYy9hH/qKseYChV0Vga3aj3FwQe1E8I5Qh/
vv2tao3ZbNWbHTJFWdTsvRzzp+VMdeL/LAzaniqvWrmMxYm/EoILvirS3tX8KD0/
hQ3+fVh8K1qBQqPLvUma3cCmRpgakQmWJHL+3iu3AiyPlkI2IB336Pbu9MMPgNdJ
BD2Hh0JLPXhbDWuvfhfTFOTxTN1ZGHPYEG2tpNtyBWCHv1lfXYIYDtKWrPr9rgG8
fWjJJyHRc6EEgSNyyLvMeqAt49ARXC6tPJ98lQFUIY7/uZMMQ5ccPPnjGhGa01KG
Vzp6G9fx0pohlj0Norn/WU1RlacuA2SzbMQOQ0yHUw==
=hmuO
-----END PGP SIGNATURE-----

--q/qwXnEh0LsH2eHp--

