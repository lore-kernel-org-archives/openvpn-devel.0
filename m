Message-ID: <4D8C43ED.90301@...1114...>
Date: Fri, 25 Mar 2011 08:27:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1300974844-23829-1-git-send-email-davids@...1347...>
In-Reply-To: <1300974844-23829-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Clarify default value for the
 --inactive option.
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/03/11 14:54, David Sommerseth wrote:
> It is not clear in the manual that this feature is disabled
> by default.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  openvpn.8 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>

Applied to beta2.2.

commit 1b71eafd4a0251740be28c495c874c2ffc9af3f6
Author: David Sommerseth <davids@...1347...>
Date:   Thu Mar 24 14:51:48 2011 +0100

    Clarify default value for the --inactive option.

    It is not clear in the manual that this feature is disabled
    by default.

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2MQ+0ACgkQDC186MBRfrrRuQCeKV8y/rjE6Kj1ZOahac45gIkQ
eK0Ani75fzFnpNU6zzp2vsTo7SVKcV7Z
=vccs
-----END PGP SIGNATURE-----

