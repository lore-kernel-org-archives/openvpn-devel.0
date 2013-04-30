Message-ID: <5180085E.5000005@...1114...>
Date: Tue, 30 Apr 2013 20:07:26 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20130428113548.GP20843@...1296...>
	<1367159509-22556-1-git-send-email-arne@...1227...>
In-Reply-To: <1367159509-22556-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2KBDNIQMRSMADOUQPURFT"
Subject: Re: [Openvpn-devel] [Patch v4 3/4] Android platform specific
	changes.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KBDNIQMRSMADOUQPURFT
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 28/04/13 16:31, Arne Schwabe wrote:
> On Android 4.0 (TARGET_ANDROID) the real opening of the tun is
> handled by the (Java) application controlling OpenVPN. Instead of calling
> ifconfig/route call the management to do the work. When running openvpn
> as root openvpn should be compiled as TARGET_LINUX
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/manage.c  |   14 ++++++++
>  src/openvpn/manage.h  |    4 +++
>  src/openvpn/options.c |    6 ++++
>  src/openvpn/route.c   |   18 ++++++++--
>  src/openvpn/socket.c  |   10 ++++++
>  src/openvpn/ssl.c     |    2 ++
>  src/openvpn/syshead.h |    2 +-
>  src/openvpn/tun.c     |   87 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  src/openvpn/tun.h     |    8 ++++-
>  9 files changed, 145 insertions(+), 6 deletions(-)

[...snip...]

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index a361233..ac8b544 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
[...snip...]
> @@ -1368,8 +1397,62 @@ close_tun_generic (struct tuntap *tt)
>=20=20
>  #endif
>=20=20
> -#if defined(TARGET_LINUX)
> +#if defined (TARGET_ANDROID)
> +void
> +open_tun (const char *dev, const char *dev_type, const char *dev_node, s=
truct tuntap *tt)
> +{
> +#define ANDROID_TUNNAME "vpnservice-tun"
> +  int i;
> +  struct user_pass up;
> +  struct gc_arena gc =3D gc_new ();
> +  bool opentun;
> +=20=20
> +  for (i =3D 0; i < tt->options.dns_len; ++i) {
> +    management_android_control (management, "DNSSERVER",
> +                                print_in_addr_t(tt->options.dns[i], 0, &=
gc));
> +  }
> +
> +  if(tt->options.domain)=20
> +    management_android_control (management, "DNSDOMAIN", tt->options.dom=
ain);
> +=20=20=20=20
> +  opentun =3D management_android_control (management, "OPENTUN", dev);
> +
> +  /* Pick up the fd from management interface after calling the OPENTUN =
command */
> +  tt->fd =3D management->connection.lastfdreceived;
> +  management->connection.lastfdreceived=3D-1;
> +=20=20=20=20
> +  /* Set the actual name to a dummy name */
> +  tt->actual_name =3D strdup (ANDROID_TUNNAME);

Just nit-picking ... anything wrong with string_alloc() which is used in
similar places?  And which can make use of gc (if that is available
here, didn't check that) and it will do the proper malloc() checks too.

Otherwise, code looks find.  I don't fully understand all the tun magic
needed on Android, but OpenVPN on Android have been well tested, so I
would say that should count as well.


--
kind regards,

David Sommerseth



------enig2KBDNIQMRSMADOUQPURFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGACH4ACgkQDC186MBRfrpHvwCeJDmp+PSwLP5laPGVv6H+BNrP
sm4AoIDurdT2nNXDrQiRF0Zrz37xgfsE
=HdVb
-----END PGP SIGNATURE-----

------enig2KBDNIQMRSMADOUQPURFT--

