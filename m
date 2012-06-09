Date: Sat, 9 Jun 2012 23:00:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120609210000.GA1059@...1296...>
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
	<eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline
In-Reply-To: <eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debrabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

coming back to this after quite some time, trying to build on OSX 10.5...

On Wed, Feb 22, 2012 at 11:49:15AM -0800, debrabander wrote:
> This is not the a problem when building using the latest Mac OS X SDK.
> I've did a quick search and it seems to be a more common issue on some
> (old) Darwin platforms. Please try building again after applying the
> patch below.
>=20
>=20
> Signed-off-by: Frank de Brabander <debrabander@...277...>
> ---
>  socket.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/socket.c b/socket.c
> index 1a772af..6337900 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -893,8 +893,13 @@ create_socket_udp6 (const unsigned int flags)
>    else if (flags & SF_USE_IP_PKTINFO)
>      {
>        int pad =3D 1;
> +#ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this
> */
> +      if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
> +		      (void*)&pad, sizeof(pad)) < 0)
> +#else
>        if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
>  		      (void*)&pad, sizeof(pad)) < 0)
> +#endif
>  	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
>      }
>  #endif
> --
> 1.7.5.4

I think the patch is fine, and I now understand why :-)

IPV6_PKTINFO is part of the "extended socket API" defined in RFC2292.
That RFC used IPV6_PKTINFO both for receiving the destination IPv6 address
in UDP packets, and for setting the source address for outgoing packets.

RFC2292 was updated by RFC3542, which renamed the "receive" function to
IPV6_RECVPKTINFO, leaving the "sending" function as IPV6_PKTINFO - and,
subsequently, in FreeBSD they have different "setsockopt()" opcodes.

So, on a system that has *both*, we need to use IPV6_RECVPKTINFO for
receving (turning it on with setsockopt) to make --multihome work, and
IPV6_PKTINFO for sending (which we don't actually do).=20=20

On a system that only has IPV6_PKTINFO, because it's API only implements
2292 (MacOS up until 10.6), use IPV6_PKTINFO for setsockopt().


Now, the interesting question is whether a 10.5-compiled openvpn.exe
will behave correctly under 10.7 if --multihome is active...

Regarding the patch: I hereby ACK, and would ask David to include
a reference to RFC2292 and RFC3542 in the commit log, so others can
find this information more easily.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9O5UKkuBuNlUUl1AQIl7gP+MhCQZe/Qk4tHXn3Z4Ia+kg3TsWk3OwDD
PsEf9SEWnakznFhyinDpZpKCMVYJQ5fWA7GJK+sACogYJnpEcaCMzpGc6rRD/HG1
g8gmh+lbR7+isMNZbNIYihdpgxuL2wGFHY/qOmzaHNVfhofrM+hTCAA7ZuEAd+Hb
u5A89QZFph0=
=MA9+
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--

