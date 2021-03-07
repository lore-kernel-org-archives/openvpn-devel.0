Date: Sun, 7 Mar 2021 19:10:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210307181002.GQ976@...1296...>
References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qO9rnsAc0ln0KIQY"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
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

--qO9rnsAc0ln0KIQY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for the review.=20

On Sun, Mar 07, 2021 at 12:22:32PM -0500, Selva Nair wrote:
> On Sun, Mar 7, 2021 at 11:31 AM Gert Doering <gert@...1296...> wrote:
>=20
> > If --mlock is used, the amount of memory OpenVPN can use is guarded
> > by the RLIMIT_MEMLOCK value (see mlockall(2)).  The OS default for this
> > is usually 64 Kbyte, which is enough for OpenVPN to initialize, but
> > as soon as the first TLS handshake comes it, OpenVPN will crash due
> > to "ouf of memory", and might even end up in a crash loop.
> >
> > Steady-state OpenVPN requires between 8 MB and 30-50 MB (servers with
> > many concurrent clients) of memory.
> >
> > So: with this patch, we check if getrlimit() is available, and if yes,
> > log the amount of mlock'able memory.  If the amount is below 20 MB,
> > which is an arbitrary value "large enough for most smaller deployments",
> > we abort.
> >
>=20
> This is required only if privileges are dropped, isn't it? Could be made
> conditional
> on o->username is set.

"I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
territory for me.

What I understand is that root can *increment* the rlimit at will, but
I'd assume that the rlimit value "in existance right now" (specifically,
the soft limit) applies to root processes as well.  Sort of a voluntary
protection against processes running away.

But I can test this.  Just malloc() until it does...

[..]
> > @@ -237,6 +237,12 @@ which mode OpenVPN is configured as.
> >    likely fail. The limit can be increased using ulimit or systemd
> >    directives depending on how OpenVPN is started.
> >
> > +  If the platform has the getrlimit(2) system call, OpenVPN will check
> > +  for the amount of mlock-able memory before calling mlockall(2), and
>=20
> white space at end of line

Yeah, the whitespace-and-typing force wasn't strong with me today :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qO9rnsAc0ln0KIQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgRRb6AAoJEB2Cnv7KVigSKVQL/31J9h7TIsITQYvO8Y988TCA
B0fUuoltsVUqdRs8fgFA9yErhrBFyqyOeOBwyTjYvbZsfJFGxFyj884daG+ISlhK
OyWSZ4PFQQcK+O8R+L+rSi+dHApy1kNWIElj5NTReweFPKtwxdv9Egs/JQFVOCOe
tAIPNkFWDMgpPSndAcQD+QnksdNMneM1bsF3BS9oADPQ/xG8TjEtLFUn4bpNLCfv
WTzKn4IbgfH/O1s7X+3fHIWocrgKyYXXbTP5HWlIZ1Hx6Yv9mK+9MgJylUw7RuK/
AQCHSs409Ce+TWAMxl0vrOnGqVuLdmZ43vxNnYoGWuTu34krSTFS8XxHovwcu1kt
WZCTTMhVfqxzWHZe4fIFJvboNNGvh+QMpmKlNDXeM/LQQNcQ4zKB5f0wlEzP9bk3
i/jcWMH+zNtUqfMoOFhNexe2JGjzPYIgUO1DaeGbXjvoXqsXaE2Mz7BdEGBXXEXw
YmQ9bA504A/MGsyLvKMWSfxdzZkPt5WYBzMCJRQlRQ==
=TJwW
-----END PGP SIGNATURE-----

--qO9rnsAc0ln0KIQY--

