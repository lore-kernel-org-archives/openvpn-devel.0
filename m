References: <20161201213104.5667-1-list@...1798...>
	<20161201213104.5667-2-list@...1798...>
	<b032d2cd-6e14-7189-4192-040c9b663f98@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <85124abd-6bb2-69c1-f83c-ca41b36bfb79@...2080...>
Date: Fri, 2 Dec 2016 10:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <b032d2cd-6e14-7189-4192-040c9b663f98@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fwBTV2ueNoGhtpLIQeNtXSwpew9i1lIvO"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Refuse to daemonize when running
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
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwBTV2ueNoGhtpLIQeNtXSwpew9i1lIvO
Content-Type: multipart/mixed; boundary="32OsSlPKFN8ThC3L93pmnB0kWNtpTO6hi";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <85124abd-6bb2-69c1-f83c-ca41b36bfb79@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Refuse to daemonize when running
	from systemd
References: <20161201213104.5667-1-list@...1798...>
	<20161201213104.5667-2-list@...1798...>
	<b032d2cd-6e14-7189-4192-040c9b663f98@...277...>
In-Reply-To: <b032d2cd-6e14-7189-4192-040c9b663f98@...277...>

--32OsSlPKFN8ThC3L93pmnB0kWNtpTO6hi
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/12/16 02:45, debbie10t wrote:
[...snip...]
> My east.conf file:
>=20
> # cat server/east.conf
>=20
> ### TESTS
> #
> ## systemd enhancements: failed as expect
> ;bad-opt
>=20
> ## daemon: Did *not* fail when run from systemd service
> daemon vpn-srv-east

This is just as expected.  Having --daemon in the config should not
cause any failure.  It should just drop trying to daemonize if it is
detected that OpenVPN is started via systemd.

Look at init.c:930, possibly_become_daemon()

If sd_notify() returns a value > 0, then OpenVPN is started via
systemctl - as sd_notify() have a communication channel with the service
manager, and it will not try to daemonize.

If sd_notify() returns 0, it means it don't know how to communicate with
the service manager.  And < 0, it means something bad happened.  In both
these cases, openvpn will daemonize as if it was not managed by systemd
at all.

So your test showed that this worked just as expected :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--32OsSlPKFN8ThC3L93pmnB0kWNtpTO6hi--

--fwBTV2ueNoGhtpLIQeNtXSwpew9i1lIvO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQT2jAAoJEIbPlEyWcf3yQewQAJ+00kpiG5RkqMtVyU3yuZE0
hRe5OBWChKDDv2pXJXymJk2h3yU7ihLiq9+NH2b2zGBfkzN6WNAr95tAoh4DMEEa
fTeArGu7Rr4lCRwSxe1RDC7bFDzC7/kI9wSfHRwVLQUoxsu3XvnlhFxg73RmhusW
6Gg+y2m2UC7Kl46aAzWY2lGrRC3/KI+PmyNQM3zG9PrnfxwPRah281k9JkmMIL50
CnOYgtUSDZvkXn+/SCVkSPhnFWrYwzFGKBvmqL7VYfz8uOjTAViMcIj5lG74g7Xt
vKQFhCJwMdH9W8J+vi61Xcqad9+vrr+8l+pkz6L+Y6q93qYY+29tbhtbkOsnkbXh
EaBGbXpxuA7YJ4xQypLrCsttX4L3zMNGl5xDMBqPxB0durJmjuSqD6Rv6VuFIlyQ
SlqbtakUA/9J51z/sYGqylAMy3iUpHZeQc8Gh9Y9f5sOV+QaruAaE8ssYXp5UV5Q
y7noA4x425pSqUIIaJSibYIDv9D3/2W9SA0idcHdmgHwRQkvwONwXQ4WFArjlxr8
dJkE/lbd34wZPM9vqzchhu6YJDeimlLYYRphIJAzftbcYjll/JJE//gHArBRj2Fc
VJCd8zmXRnQQVaXv4TZpvQknNp5FUhOqa7rgbOU8I3KhB26cFYHWi9YLqSLUnm1w
u/QnXSEdSp5oX/CcfDaH
=1ug7
-----END PGP SIGNATURE-----

--fwBTV2ueNoGhtpLIQeNtXSwpew9i1lIvO--

