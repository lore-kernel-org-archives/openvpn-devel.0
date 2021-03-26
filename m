Date: Fri, 26 Mar 2021 08:12:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210326071222.GR976@...1296...>
References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="g94CgySkBfNYCEaQ"
Content-Disposition: inline
In-Reply-To: <1540904039-2129-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--g94CgySkBfNYCEaQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 30, 2018 at 02:53:59PM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> This patch provides additional information, such as
> source address/port and destination address/port, to a
> "recursive routing" warning message. It also mentiones
> possible workaround.

I still do not like this patch.  It is quite a bit of extra code, and
I'm not convinced of the benefit.

Adding documentation is most welcome, though.

>  .B \-\-allow\-recursive\-routing
>  When this option is set, OpenVPN will not drop incoming tun packets
> -with same destination as host.
> +with same destination as host. Could be useful when packets sent by open=
vpn
> +itself are not subject to the routing tables that would move packets
> +into the tunnel.

So, this is good.  Maybe even extend this a bit more.


On the patch itself, it assumes "no IP options" for IPv4, and "no=20
intermediate headers" for IPv6, and "all payload is UDP or TCP".=20=20

Which is usually true for any packets that OpenVPN itself originates but=20
if you want to log "this is packet from someone else, and we shouldn't
have dropped it because it's not one of ours" it could be anything.


Now...  if we consider a scenario where OpenVPN packets are not subject
to be routed into the tunnel (Linux VRF, policy routing, ...) - which
is actually something I want to see happen :-) - twisting this feature=20
into some other direction might make the coding effort useful: what=20
about "we only block packets that match destination IP *and port and
protocol* with what OpenVPN is using"?=20

So, if we talk to 1.2.3.4/udp/1194, only packets inside the tunnel
destined to 1.2.3.4/udp/1994 would be dropped, and everything else can
be sent freely - because those are never "recursive openvpn packets".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--g94CgySkBfNYCEaQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXYlVAAoJEB2Cnv7KVigS6PQL/25mYBxBCisko+C3UzVlLZee
sKhUJwU2j0/L96HP//NgYyeMJ0YlcPixpw384fYxLwAB7P5J62PYoScFmppVTish
apOwZ3vhNDP0SMWvFoif0OZQWijFW4UjfpXCCPB1VX6PhjWbvDOORttX5QbkPA4B
YAxpAq4Qxm3RG1U/XU8kycZlsmqzxVQbBjcMFnJbaobDYZt59k4BiJrxUHkDk/Ob
biPnWNVyFbo6anB3h5NaF1HdmV9vtWw3JH8fcR45lMVXDjWyEuXW1nVmtBJSc/tk
2F9zsncRAmuAeP3QuLFDAYkFq64vVQepqaikWIWItYCybLzYViNu2hSfzYRW8/h5
FtkLfkqFPrcJfPvnCWWPz1emdy62ClAagXjC+WV6AmI0YY+ULL8j+yx3bORv2aaM
FOBMFojzvToiEw27uIoAsm2MK4cOl32nvnRj3Qv4s3mWg7U90TeZZBIeLrf2GOWT
HMqPU2GmPM+TbTEFJT0ybTWj9d4e4qLMecqcKmOwBw==
=nnXL
-----END PGP SIGNATURE-----

--g94CgySkBfNYCEaQ--

