Message-ID: <50912E04.7000504@...1114...>
Date: Wed, 31 Oct 2012 14:56:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1351539352-17371-1-git-send-email-dazo@...384...>
In-Reply-To: <1351539352-17371-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A626C28870B944CE9E9DE18"
Subject: Re: [Openvpn-devel] [PATCH] Remove the support for using system()
 when executing external programs or scripts
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
--------------enig1A626C28870B944CE9E9DE18
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/10/12 20:35, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This patch removes the support for the system() call, and enforces the us=
age of execve()
> on the *nix platform and CreateProcessW() on Windows.  This is to enhance=
 the overall
> security when calling external scripts.  Using system() is prone to shell=
 expansions,
> which may lead to security breaches.  Which is also why the execve() appr=
oach has
> been the default since commit a82813527551f0e79c6d6ed5a9c1162e3c171bcf wh=
ich
> re-introduced the system() in Nov. 2008.
>=20
> After having asked on the mailing list and checked around on the IRC chan=
nels, the
> genereal consensus is that very few uses system() these days.
>=20
> The only annoyance I've been made aware of is that this will now require =
adding a full
> path to the script interpreter together with the script, and not just put=
 in the
> script name alone.  But to just use the script name in Windows, you had t=
o configure
> --script-security with the 'system' flag earlier too.  So my conclusion i=
s that it's
> better to add a full path to the script interpreter in Windows and raise =
the overal
> security with OpenVPN, than to continue to have a possible potentially ri=
sky
> OpenVPN configuration just to make life "easier" for Windows script users.
>=20
> Removal of the system() call, also solves a nasty bug related to the usag=
e of putenv()
> on the *nix platforms.
>=20
> For more information please see:
> http://thread.gmane.org/gmane.network.openvpn.devel/7090
> https://community.openvpn.net/openvpn/ticket/228
>=20
> Trac-ticket: 228
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  doc/openvpn.8          |   48 ++++++++++++------
>  src/openvpn/init.c     |    3 --
>  src/openvpn/misc.c     |   98 ++++++++-----------------------------
>  src/openvpn/misc.h     |    5 --
>  src/openvpn/options.c  |   16 +-----
>  src/openvpn/platform.c |   27 +---------
>  src/openvpn/platform.h |    4 +-
>  src/openvpn/win32.c    |  127 +++++++++++++-----------------------------=
------
>  8 files changed, 89 insertions(+), 239 deletions(-)
>=20

Applied to master and beta/2.3

commit 0563473601abfbf2142bfa0ca5b863c5aa7953a2 (master)
commit 3cb9f1a62b4a84dbf4acd1957c900a5b06fd6ac2 (beta/2.3)
Author: David Sommerseth <davids@...1347...>
Date:   Thu Oct 25 14:22:30 2012 +0200

    Remove the support for using system() when executing external programs =
or scripts

    Trac-ticket: 228
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1351539352-17371-1-git-send-email-dazo@...384...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7114
    (cherry picked from commit 0563473601abfbf2142bfa0ca5b863c5aa7953a2)


kind regards,

David Sommerseth


--------------enig1A626C28870B944CE9E9DE18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCRLgYACgkQDC186MBRfrqvBACfUBcB1S0UBN5FS31Q31liLph5
vw8An2CB7yfmNU4Z6D8ODrd/Usi1cnj/
=RzMq
-----END PGP SIGNATURE-----

--------------enig1A626C28870B944CE9E9DE18--

