Message-ID: <4D8B9EF5.4010700@...1114...>
Date: Thu, 24 Mar 2011 20:43:49 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTinSNNNtmS78KquJbmA81eZdxubr1rdZcKHD0Y0n@...278...>
	<4D87C556.3000606@...1114...>
	<AANLkTi=_QkRWUYO5R_NDhAUty+Q1ckPdTrB=9bsUUUD9@...278...>
In-Reply-To: <AANLkTi=_QkRWUYO5R_NDhAUty+Q1ckPdTrB=9bsUUUD9@...278...>
Subject: Re: [Openvpn-devel] [PATCH] common_name passing in auth_pam plugin
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
To: Joe Patterson <j.m.patterson@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/03/11 23:07, Joe Patterson wrote:
> [PATCH] -added the ability to have "COMMONNAME" replaced
>   with certificate common name in pam conversation
> 
> Signed-off-by: Joe Patterson <j.m.patterson@...277...>
> ---
>  plugin/auth-pam/README     |    2 +-
>  plugin/auth-pam/auth-pam.c |   11 +++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)

ACK.  Applied to bugfix2.1, to be merged into allmerged.

I took the freedom to modify the commit message slightly, and correct one
extra space which had sneaked into the patch.

commit 745fd7b4bce91549a88959a47d5fc2e6d3753ecc
Author: Joe Patterson <j.m.patterson@...277...>
Date:   Mon Mar 21 18:02:59 2011 -0400

    common_name passing in auth_pam plugin

    Added the ability to have "COMMONNAME" replaced with certificate common
    name in pam conversation.

    Signed-off-by: Joe Patterson <j.m.patterson@...277...>
    Acked-By: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2LnvUACgkQDC186MBRfrrN7ACgr2Fk98GOyg6j4Mn4BJV9t0pc
T0wAnRV8VNx3iRHvNa7vO1MIQMtotCP9
=j/Tx
-----END PGP SIGNATURE-----

