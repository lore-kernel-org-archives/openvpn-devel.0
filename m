Date: Tue, 24 Dec 2019 09:35:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191224083553.GD74723@...1296...>
References: <961fb2b3-ca10-1549-3ec8-a408e0072e2f@...515...>
 <CAFdgGSB4qc1KsfQB+67oub+P2J7pMPb6W6d6jZzgZzsB7m_0Og@...278...>
 <20191222183308.GP74723@...1296...>
 <CAFdgGSD5EzgzOqRCDaaBe45qUvqV-NmcKU3ZVmwOdBnw4MUSbg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QVzQgM+zdZ3YWXqn"
Content-Disposition: inline
In-Reply-To: <CAFdgGSD5EzgzOqRCDaaBe45qUvqV-NmcKU3ZVmwOdBnw4MUSbg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Removing --disable-server
 option from OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Yevgeny Kosarzhevsky <phaoost@...277...>
Cc: Gert Doering <gert@...1296...>, Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--QVzQgM+zdZ3YWXqn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 24, 2019 at 10:27:07AM +0300, Yevgeny Kosarzhevsky wrote:
> > > > We are considering removing the --disable-server option from OpenVP=
N in 2.5.
[..]
> Yes I am using it to build some patched versions as well as no-replay
> and no-iv options to build plain tunnels.

But why?  For size reasons?

On the developer side, this option adds quite a bit of extra maintenance
effort (because quite often, a new patch works nice with default option
but breaks compilation with --disable-server), so there needs to be a
really good reason to keep the option.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QVzQgM+zdZ3YWXqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeAc3oAAoJEB2Cnv7KVigSBYYMAJry15oGNpcdssFjNwFHK94O
fmOwsmxRF7R6Vdq6GCRXi4rLSO+B5bIVBv1B7k+UnHm82df9+vJDkmQuIT2VReuQ
TvK1H/1R+CuiQN8J1wlBzwV6oQgAIQ66GfjSV6DZIpBPXj/t01szDXpMNngvmZbo
daxSzNnqIfX081pCLQwOqpiZqF3Oq+PhwlgebEwhnP++a5OcmAIkouL9BpLCm4DS
DlbgpeioIT1Hxp8PcFDAIXPi1RjzcZOVGk2+K2WLwzb5ZNLOnjUTT/+3OYk7elJl
qJVZHpLl6GaU7dOsPSxi4ujvMQx56zYfAZiSJxhUy1o3Lb+34S9En4qoLBoIIWGU
Aa+Gw4FSU0onVWum2OaW8+ZBag+kXob8XU0ItZkZs7lDGZy75czLO/ahHwnobqbk
T/tKhklQQhKy0GdO0EEKEggPBH4kNzRIl/0ZD1MGbsrRgSSLCMVcXvg2XQAtkOOq
6c9jgWxnUIZq6peBIY+Hc9ExIo9uCZH1m9OHFdjr3w==
=zITn
-----END PGP SIGNATURE-----

--QVzQgM+zdZ3YWXqn--

