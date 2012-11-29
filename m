Message-ID: <50B7D0D1.1090403@...1114...>
Date: Thu, 29 Nov 2012 22:17:05 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1354194972-5388-1-git-send-email-dazo@...384...>
In-Reply-To: <1354194972-5388-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FEC673803A0BDA14EE5DFBE"
Subject: Re: [Openvpn-devel] [PATCH] The get_default_gateway() function uses
 warn() instead of msg()
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FEC673803A0BDA14EE5DFBE
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/11/12 14:16, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> A report on #openvpn pointed out that in his setup three warnings
> appeard on the console when starting up.
>=20
>     $ sudo /usr/local/etc/rc.d/openvpn restart
>     Stopping openvpn.
>     Waiting for PIDS: 33031.
>     Starting openvpn.
>     openvpn: writing to routing socket: No such process
>     openvpn: writing to routing socket: No such process
>     openvpn: writing to routing socket: No such process
>     $
>=20
> This setup is on FreeBSD using jails with strict access to the
> routing table.
>=20
> After looking at the code path, this error was found in the BSD
> sections for get_default_gateway().  But it was using the warn()
> call instead of msg(M_WARN|M_ERRNO, ...) which causes these
> warnings to go to stderr instead of the log file.
>=20
> The warning string is also slightly modified to better explain
> what fails.
>=20
> Reported-by: Thomas Steen Rasmussen <thomas@...1782...>
> Tested-by: Thomas Steen Rasmussen <thomas@...1782...>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/openvpn/route.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Applied to master and beta/2.3 branches

commit b3f19cc4bec6978a128f5af3ab22d8cfa954b064 (master)
commit 28d9e57638d66fde792a53a3eb6391ddb8bb426f (beta/2.3)
Author: David Sommerseth <davids@...1347...>
Date:   Thu Nov 29 14:16:12 2012 +0100

    The get_default_gateway() function uses warn() instead of msg()
=20=20=20=20
    Reported-by: Thomas Steen Rasmussen <thomas@...1782...>
    Tested-by: Thomas Steen Rasmussen <thomas@...1782...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1354194972-5388-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7149


--=20
kind regards,

David Sommerseth


--------------enig0FEC673803A0BDA14EE5DFBE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlC30NEACgkQDC186MBRfrpdagCdHAeq5iEvGH/Ju6l6/0XvrjXT
DAIAnR2vVexcNSpkw1zpKYRDZaDl63WO
=ftHR
-----END PGP SIGNATURE-----

--------------enig0FEC673803A0BDA14EE5DFBE--

