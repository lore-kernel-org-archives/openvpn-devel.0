Date: Tue, 16 Aug 2022 11:29:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvtjcRgdVEt9q8h7@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EnjUJzFhapcAHjAr"
Content-Disposition: inline
In-Reply-To: <YvoXzZNWGa49RJ6D@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>, berni@...376...
Cc: openvpn-devel@lists.sourceforge.net

--EnjUJzFhapcAHjAr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 15, 2022 at 11:54:21AM +0200, Gert Doering wrote:
> [..]
> > commit 2e359a088226ab1e5ee41fbab27d38d8a8d192ac
> > Author: Timo Rothenpieler
> > Date:   Sat May 14 12:37:17 2022 +0200
> >=20
> >      platform: Retain CAP_NET_ADMIN when dropping privileges
>=20
> Unfortunately, it seems that our approach to "if SITNL is used, we hard
> require that setting CAP_NET_ADMIN succeeds" is too strong for the twisted
> ways that people use openvpn.
>=20
> Namely, network-manager...
>=20
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1017379
>=20
> ... runs openvpn with --ifconfig-noexec / --route-noexec, and insists
> on doing all that itself.  I do not like NM's way of trying to control
> everything (up to the point that it defaults to redirecting a default
> route to OpenVPN even if config and server do not want that), but this
> is what Linux people seem to be stuck with, so we need to handle it.

We've discussed this quite a bit in #openvpn-devel, and it's more complicat=
ed
than "just ifconfig and route".

Namely, there is more operations OpenVPN needs to do if running with
the DCO kernel module, which all needs CAP_NET_ADMIN

  - renegotiate on TLS session expiry (control channel communication is
    done through kernel module, not directly on socket)
  - install / swap keys
  - reconfigure the kernel peer on reconnect (peer-id / remote IP)

So, running in an environment that prevents use of CAP_NET_ADMIN (how
does it do that, in the first place?) *and* forces a non-root user
means "DCO will break".  Not immediately, but openvpn will abort on
each of these envents - NM might hide that by just restarting it, but
it's still broken.


So the discussion seems to run towards two options

  - disable DCO if CAP_NET_ADMIN can not be retained
  - fix this in NM

Preferably, fix this in NM...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EnjUJzFhapcAHjAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi+2NxAAoJEB2Cnv7KVigS7EkMAIKSKyI6E4B4vpIC5B8zqUlx
NX9ODX/npx7tm7Y0B7f61nPu6Rc1x9mUQcWfYjAs8/bAdbixPgORIAAxj3voB2qp
45QGnel66Zh3zvEjirMQyfyHddbI1KGnZnoG/toMHFHoP5CXKX9gDBqauwuevjVm
g0F+V4ZMihVaiz6nGCy4PU3jiEWklNXU28tDgOKSIjwnCYGuggrN111lmVOplmMI
BrG3jPwz/ZzMQdujMaCS541tZLvsANG6ob0OvczQn+Ds6SKpmahvSRe0E7GyZE+o
KuTVeCDM5WySH5idPp609PomeopPqfhTWBbzxyLqnQBSnoQZ/bDVSr1nJZdNq0kI
cc1u4Qd2UKEYNyxWRu+dAURzIw7E0M3ShkMPNogp5vJvvRTZzy6CRCxbhURlBpyc
c31+tNPdeof0yBmUO+/4zwOwmkU3jQ04QEO+zysYjJhjtqmBhhMeVU7nNxOj5kdK
C9Y2k+KNjjnU5k29Ei1Gfusun5XBEqSbjjWmk+fdog==
=51Q0
-----END PGP SIGNATURE-----

--EnjUJzFhapcAHjAr--

