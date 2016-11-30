References: <20161129152739.11582-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <641bcfd7-d750-2cb7-1b49-099026004b4b@...2080...>
Date: Wed, 30 Nov 2016 02:45:25 +0100
MIME-Version: 1.0
In-Reply-To: <20161129152739.11582-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="F7nA9kJ2goT0MMGWVKj1DCAphh3bcVRQi"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Use systemd service manager
 notification
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
--F7nA9kJ2goT0MMGWVKj1DCAphh3bcVRQi
Content-Type: multipart/mixed; boundary="kqbuP0HDGpUV4heKd4oKkhEjkPMnL4Rw2";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>
Message-ID: <641bcfd7-d750-2cb7-1b49-099026004b4b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Use systemd service manager
	notification
References: <20161129152739.11582-1-list@...1798...>
In-Reply-To: <20161129152739.11582-1-list@...1798...>

--kqbuP0HDGpUV4heKd4oKkhEjkPMnL4Rw2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/11/16 16:27, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Notify systemd service manager when our initialization sequence
> completed. This helps ordering services as dependencies can rely on vpn
> being available.

Funny detail is that I have a somewhat similar patch in a local git
tree, awaiting proper testing ... I postponed it as this is not
something we will pull into v2.4.  We're going to release 2.4_rc1 this
week, and that is too late for more intrusive changes (even though the
changeset itself is small, the code changes makes OpenVPN behave
somewhat different when managed by systemd).

Just a question, as it is good to see more people looking into these
code paths ... I was considering to extend my approach to update STATUS=3D
a bit more frequently.  On the client side, I thought it would be good
if the status line had "Resolving %s", "Connecting to %s", "Successful
connection to %s" or "Failed to connect to %s".  On the server side I
was pondering on a "Successfully started, %i clients connected".  What
do you think about that?  Does the sd_notify() API support more frequent
updates?

Also when using Type=3Dnotify ... does systemd expect the OpenVPN process
to fork into the background or run in the foreground as now?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc








> ---
>  distro/systemd/openvpn-client@...1685... | 1 +
>  distro/systemd/openvpn-server@...1685... | 1 +
>  src/openvpn/init.c                     | 6 ++++++
>  src/openvpn/init.h                     | 4 ++++
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/op=
envpn-client@...1685...
> index 18b84dd..f64a239 100644
> --- a/distro/systemd/openvpn-client@...1685...
> +++ b/distro/systemd/openvpn-client@...1685...
> @@ -7,6 +7,7 @@ Documentation=3Dhttps://community.openvpn.net/openvpn/wik=
i/Openvpn24ManPage
>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>=20=20
>  [Service]
> +Type=3Dnotify
>  PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-client
>  RuntimeDirectoryMode=3D0710
> diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/op=
envpn-server@...1685...
> index a2b7b52..890e6a9 100644
> --- a/distro/systemd/openvpn-server@...1685...
> +++ b/distro/systemd/openvpn-server@...1685...
> @@ -7,6 +7,7 @@ Documentation=3Dhttps://community.openvpn.net/openvpn/wik=
i/Openvpn24ManPage
>  Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO
>=20=20
>  [Service]
> +Type=3Dnotify
>  PrivateTmp=3Dtrue
>  RuntimeDirectory=3Dopenvpn-server
>  RuntimeDirectoryMode=3D0710
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 2ccbab2..551e579 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1251,10 +1251,16 @@ initialization_sequence_completed (struct context=
 *c, const unsigned int flags)
>        show_adapters (M_INFO|M_NOPREFIX);
>        msg (M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhc=
pclientserv )", message);
>  #else
> +#ifdef ENABLE_SYSTEMD
> +      sd_notifyf(0, "STATUS=3DFailed to start up: %s With Errors\nERRNO=
=3D1", message);
> +#endif /* HAVE_SYSTEMD_SD_DAEMON_H */
>        msg (M_INFO, "%s With Errors", message);
>  #endif
>      }
>    else
> +#ifdef ENABLE_SYSTEMD
> +    sd_notifyf(0, "READY=3D1\nSTATUS=3D%s\nMAINPID=3D%lu", message, (uns=
igned long) getpid());
> +#endif
>      msg (M_INFO, "%s", message);
>=20=20
>    /* Flag that we initialized */
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index 524bc64..0518b06 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -27,6 +27,10 @@
>=20=20
>  #include "openvpn.h"
>=20=20
> +#ifdef ENABLE_SYSTEMD
> +#include <systemd/sd-daemon.h>
> +#endif
> +
>  /*
>   * Baseline maximum number of events
>   * to wait for.
>=20



--kqbuP0HDGpUV4heKd4oKkhEjkPMnL4Rw2--

--F7nA9kJ2goT0MMGWVKj1DCAphh3bcVRQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYPi81AAoJEIbPlEyWcf3yQRYQAIW8ulrhLeXJeNpBXSql6Cf6
bZqH9rtt3UBEc7n26QFhe5WPcif3Cq4AFihXW/TXaucBmIioLFs28YD6b9pnyN4r
zH6yM+9h17iccjQ4nbE2Ja1z2OqBlz3cvgqzYtrSPQAt34VtpLD/5WKMWKHzFMhy
zeXBotwhW6eMjaf2vW/3/ddcuoWVBH1b6QejPRjwmhzJGZ22UoybkS7vqdbT811e
89CQ0Vb4aPy11YytXbS/vL2sS/GCWo+vikoOSHVuzNmq4XnBQd7AsnL4YcSkiUGU
WKka8nYQ8qjP91OcuoztnTqjBaNGqx6lmvNDU/I3L+KcurMvuSVMtzwDfU9g+Se0
Zw1JPkpTI0OGfyJrvcFm9PNyLeWqytpcDuCRDf7un9NDftHCNMhDx1//24Ru8LuQ
hFpPKmDRkldt/kl7aWgEKVgpUxEWGYr23LpznfHgPquXN5/g9o8lhmkCaQdXU2gN
XI0eLZ4LyDmJRgteQp9mLKxmgXM0x3oRZiYZTREMMEteQBi6v2zhwGZdGF5t9KU+
mySqYGBp5Gk620Hw9Qw5hbBxsauac9DZxCrG6Q975EQp+nBzqvLiVtvYa60fVbVu
EwJL39TzUl14rNeyUiWMVI3Jw/L0KD17pqMFlhUUpDMWqSFYj7ZEZ8SHCpX6RhkT
XuiQeHSOp8PlhZaRS+gy
=6K6+
-----END PGP SIGNATURE-----

--F7nA9kJ2goT0MMGWVKj1DCAphh3bcVRQi--

