Message-ID: <4FED66F5.40700@...1114...>
Date: Fri, 29 Jun 2012 10:27:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: msvc: chdir with change drive to
 script location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/12 20:51, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---=20
> msvc-build.bat |    1 + msvc-dev.bat   |    2 +- msvc-env.bat   |
> 2 -- 3 files changed, 2 insertions(+), 3 deletions(-)
>=20

Applied to master.

commit 6d2b65ad322e587efaf43c1b8cf6da8c36cf1ae1
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat Apr 28 21:51:58 2012 +0300

    build: msvc: chdir with change drive to script location

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Message-Id: 1335639118-16671-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6383
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/tZvIACgkQDC186MBRfrppvACfSGt/dhmxvIJdMD0+1WacGJKy
2PsAn1kWrwj8SKiXF6sXJyYTc8rT06uG
=3D3iVf
-----END PGP SIGNATURE-----

