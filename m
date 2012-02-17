Message-ID: <4F3E2906.7040001@...1114...>
Date: Fri, 17 Feb 2012 11:16:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329467975-30716-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1329467975-30716-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] move variable declaration to top of
	function
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

On 17/02/12 09:39, Heiko Hund wrote:
> MSVC chokes on this as it's not according to C89.
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- buffer.c |    2
> +- 1 files changed, 1 insertions(+), 1 deletions(-)

ACK!  Applied to master on -testing and stable trees.

commit 175383fec9cd2d891cfd3f2673b6549822fdfa47
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Fri Feb 17 09:39:35 2012 +0100

    move variable declaration to top of function

    MSVC chokes on this as it's not according to C89.

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+KQYACgkQDC186MBRfrpetwCfXPs76FCzCiLbmDzS0wD77cxZ
+j8AoJ+pYBXQfyplScerR77HQlhKX89E
=ZIdx
-----END PGP SIGNATURE-----

