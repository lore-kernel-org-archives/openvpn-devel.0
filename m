Message-ID: <4F421C32.1040403@...1114...>
Date: Mon, 20 Feb 2012 11:10:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329594252-5257-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] define access mode flag X_OK as 0 on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/02/12 20:44, Heiko Hund wrote:
> The _access and _waccess functions in Windows don't know about X_OK
> (1). If you pass an uneven mode flag the C runtime's default invalid
> parameter handler ends execution of openvpn.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- win/config.h.in
> |    2 +- 1 files changed, 1 insertions(+), 1 deletions(-)
> 

ACK and applied to master branch on -testing and -stable trees.

commit 4ebc587eab73e03ef64d344a5707d84e7f8d875a
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Sat Feb 18 20:44:12 2012 +0100

    define access mode flag X_OK as 0 on Windows

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9CHC8ACgkQDC186MBRfrrHegCfUMxu2lHG4Rso8cw1qt7eLEZN
OgAAn0cAwDCQKUq5MLJd6WAZJeVsdyje
=2vak
-----END PGP SIGNATURE-----

