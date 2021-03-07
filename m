Date: Sun, 7 Mar 2021 19:44:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210307184402.GS976@...1296...>
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SSxpkmo34R+7wLIq"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SSxpkmo34R+7wLIq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 07, 2021 at 01:36:03PM -0500, Selva Nair wrote:
> > "I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
> > territory for me.
> >
> > What I understand is that root can *increment* the rlimit at will, but
> > I'd assume that the rlimit value "in existance right now" (specifically,
> > the soft limit) applies to root processes as well.  Sort of a voluntary
> > protection against processes running away.
>=20
> On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies only =
to
> unprivileged processes -- privileged processes allowed to lock "unlimited"
> amount of memory as documented in man mlock. We updated the man page based
> on that sometime ago.

Indeed, "man mlock" says something about "privileged processes" on Linux
(it doesn't say that on FreeBSD).

> We could also consider using setrlimit to increase the limit before
> dropping privileges.

That's another possible angle... just up soft+hard to "something"
(how much would that be? :-) ) and log the fact.

David, Arne, any opinion on this?  Where do we want to go?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--SSxpkmo34R+7wLIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRR7yAAoJEB2Cnv7KVigSfBIL/0bNe8i8/cn4Vx3BNMjpZGPm
ASCCOASrQ05PoEEcDZ1czM9iU/KzpK7N09VCGvkXBhp9Zabpykf7vTw403BePRtJ
cnkCw0MTQz9rRwjFBaHy2GkxWEDFjNMJxbyKBUgLAmkXQ4F2Bq052vgh+YshshGg
YyZKZCWHr5r9+3aplEn+pAEqOsEu0kd3jOazF2/wzE0A9O5mgNeLFGg/Wp8OPpI2
h05NoGLlsxhkrXGa23Q4n1jaLy09PxBjzcVB+itpFZDVaqYPZmergmQ8V/EHfdZ0
RXZJO49ytnODI+KscZWbpbUdih/SyZpFEvAjWEU18NjnGkVMnt9oVr2qQ9bEuD97
voYhjo3z3+/LUrMdGjOWgO9MIy58H7RVVBIXnvkFQxAxQoexUBQKMmXrmhnIMRXe
EjkuOTG+QEFrXnyyPpv7vHzkwFuLR8V4O2QrfaozbdN9wGJtqum0/wqzgy9pVt4+
Hks5ry8TQrxcwcIHc3ehst1eFz5Qk1minZAraTAlLw==
=Q21e
-----END PGP SIGNATURE-----

--SSxpkmo34R+7wLIq--

