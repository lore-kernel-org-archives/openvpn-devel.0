Date: Wed, 25 Apr 2018 15:01:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425130103.GA69387@...1296...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
 <20180424120337.0fab107d@...1799...>
 <20180424130817.GA20143@...2161...>
 <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
 <20180424221636.257dd814@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ViugPjSMr9TemhdD"
Content-Disposition: inline
In-Reply-To: <20180424221636.257dd814@...1799...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Antonio Quartulli <a@...2181...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--ViugPjSMr9TemhdD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 24, 2018 at 10:16:36PM +0200, Christian Hesse wrote:
> No need to have root involved. Sounds good?

This is not our traditional approach of "give people rope to hang themselves
if they want so".  So I'll NAK any patch that *requires* use of systemd,
capabilities and non-root users on Linux.

As an option, welcome.

(I'm not finding a really good reason right now why I would need to run
openvpn as root which couldn't be done with CAP_NET_ADMIN, so the=20
recommendation should certainly be "use non-root" - but then, we're not
enforcing --setuid today either)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ViugPjSMr9TemhdD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4HwOAAoJEB2Cnv7KVigSm/IL/RFM0g87SAz3rXj6k54oM1fn
g2r8Z74fIMzBCYPO5H1vHDarjveuLhRdqjzxKRnxrNao29TsJ2gd2ix5NPEXjr5h
PhOR0BIlu4cWeFlLErVQQVX4C5C0bte3Yvxcil30/5ID+ebPoBchy2Ea2JGariir
nJN4qbTZ6Szi2uVMzjEBK/wKnL6OhaNDBRVTQggSFnSdmba+E323qrvBbd76ofaN
axxyJnvQrgYGnsm41ycbI628wiRD1aB4+5JpwrNUiAwG7jvAMbpiV7LUbgjZZGRK
cuIUF5OCu2dPdl7u4EFbGyFQRxVMtDdoWh1UpaG56oQCxwMdRaF/3IUgDe1Jt0nB
XFCCnTP354fqvp5PKHeSGJE7MvoUi+bmd56o8sZeI834hjlfCg/x9BHdXU+E4A6i
OPoIZp4yVE5E3YkqdTy/EeFLyCuima7IHMnlaRRxSMVeFbULvI7/1IIsJCUqQuiZ
wRpv+P0kwxnt/e/YeZ6dHkrHZcFbn4p72Jb6jc57CA==
=u/w+
-----END PGP SIGNATURE-----

--ViugPjSMr9TemhdD--

