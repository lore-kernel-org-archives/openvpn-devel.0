References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <760e0e37-c6c6-1183-548f-0c14636d45e2@...2080...>
Date: Wed, 30 Nov 2016 12:52:30 +0100
MIME-Version: 1.0
In-Reply-To: <20161130085908.23248-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="b0qm6GbGH6RWOEqXktQiQj3nLDLEgQCrW"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b0qm6GbGH6RWOEqXktQiQj3nLDLEgQCrW
Content-Type: multipart/mixed; boundary="0qjR3R5QScmTdBA4mUPXAVSprQJpsbhH6";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <760e0e37-c6c6-1183-548f-0c14636d45e2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running from
	systemd
References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
In-Reply-To: <20161130085908.23248-1-list@...1798...>

--0qjR3R5QScmTdBA4mUPXAVSprQJpsbhH6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 30/11/16 09:59, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> We start with systemd Type=3Dnotify, so refuse to daemonize.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  distro/systemd/openvpn-client@...1685... | 1 -
>  distro/systemd/openvpn-server@...1685... | 1 -
>  src/openvpn/init.c                     | 7 +++++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/op=
envpn-client@...1685...
> index f64a239..5618af3 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -12,7 +12,6 @@ PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-client
>  RuntimeDirectoryMode=3D0710
>  WorkingDirectory=3D/etc/openvpn/client
> -ExecStartPre=3D/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/=
bin/echo "OpenVPN configuration cannot contain --daemon when being managed =
by systemd" ; exit 1'
>  ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config %i=
.conf
>  CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGI=
D CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=3D10
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/op=
envpn-server@...1685...
> index 890e6a9..b9b4dba 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -12,7 +12,6 @@ PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-server
>  RuntimeDirectoryMode=3D0710
>  WorkingDirectory=3D/etc/openvpn/server
> -ExecStartPre=3D/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/=
bin/echo "OpenVPN configuration cannot contain --daemon when being managed =
by systemd" ; exit 1'
>  ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
>  CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>  LimitNPROC=3D10
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 551e579..7ab5c52 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -926,6 +926,13 @@ bool
>  possibly_become_daemon (const struct options *options)
>  {
>    bool ret =3D false;
> +
> +#ifdef ENABLE_SYSTEMD
> +  /* return without forking if we are running from systemd */
> +  if (sd_notify(0, "READY=3D0") > 0)
> +    return ret;
> +#endif
> +
>    if (options->daemon)
>      {
>        ASSERT (!options->inetd);
>=20

NAK on this approach.  We cannot dictate that users _must_ start OpenVPN
as a daemon via systemd if it has been built with systemd support.

I understand the sentiment for this change, but we need to ensure users
may use their own scripts and hand-crafted configs to start OpenVPN,
also if systemd is present.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--0qjR3R5QScmTdBA4mUPXAVSprQJpsbhH6--

--b0qm6GbGH6RWOEqXktQiQj3nLDLEgQCrW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYPr1+AAoJEIbPlEyWcf3yI1wP/2rCbbpfXfLPeE+DPx/4eyD7
UKfrS5K0DyBwB5K8zPnvUuw39GHcpJnODu7DyohTA99C2qd2ujeANp/tyt857eAu
a/xDjfvSIqSFNFm8sZp0QruCaFgthuuO4QS3VVY093WM0VA4MPfIIrHD1jJNdIyV
zyX4Su7mbj71qZ9COqhVCA0g8PffKCcC5c4CyA7V8xtzPS+CymTV3mFLrECZSPHH
RJzjTl1uuF7ieSEjLjodoE3GznYcV+YJvxj7VdmRsnbx6aVfUXsWEibUE0laklLw
1Jaswy29gXkRlh19o0CQ+CPHNUoX9/tJcFOdMQI60qhyiGR+UZw60/DcZ+1yovBD
wxSbaGqyqEsDuzaIZJFErmnHUaUuiOMoB/nFMGWJxkeVdhgPvf6xxjFPfU6/LA4/
k8KB7JGLQJRZju/bYaEsy7/4EyNyOFvQrl8zOEtqDjvxE1v0kjSMzulGW8KloBF5
e5iwzuR+f74YtgKF8qv3gcmX/hHD2ucaZQapZZdoilaUhUm9suxHkdzuSEdQ68gH
kWMmSrTCYFLzIGdDmG+62yHjouaX8Iy1rOIqWh3Q0M3hUvN3LxhTTukAFtWWEt3b
qmHLJCAxZh2fF/gRQqxdSeX5ICsnu+EEVciZi5gblSc+R00Gtb4K6y/0idbq8bXx
mUPAi18TEC/bJlKGXIrk
=0eO3
-----END PGP SIGNATURE-----

--b0qm6GbGH6RWOEqXktQiQj3nLDLEgQCrW--

