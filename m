Message-ID: <4F3E49C1.2050403@...1114...>
Date: Fri, 17 Feb 2012 13:36:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329477191-634-1-git-send-email-davids@...1347...>
In-Reply-To: <1329477191-634-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Makefile.am referenced a now
 non-existing config-win32.h
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

On 17/02/12 12:13, David Sommerseth wrote:
> This file was moved to win/config.h.in and is the template used by the
> Python build tools in win/.  This happened in commit
> 4b312378e9e7084a0699ca6d4b895bdadb7540db
> 
> For all other autotools based environments, ./configure will take care
> of creating the proper config.h
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- Makefile.am |
> 1 - 1 files changed, 0 insertions(+), 1 deletions(-)

Applied to master branch on -testing and -stable trees.

commit ec3a7814d436076a442979ec656d3e8431d55d73
Author: David Sommerseth <davids@...1347...>
Date:   Fri Feb 17 12:09:51 2012 +0100

    Makefile.am referenced a now non-existing config-win32.h

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+ScEACgkQDC186MBRfrog7wCdF8hRIHwbz/I4tvd0nSP3jB72
gvsAnAx39dBmgUStmzlm+FV2u+tqDU+k
=oCO7
-----END PGP SIGNATURE-----

