Message-ID: <4B9FFD56.3050403@...1114...>
Date: Tue, 16 Mar 2010 22:51:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
 not	defined
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/03/10 11:49, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> This is to include peercred support on hosts where _GNU_SOURCE is not
> defined by default.  This issue has been found on Gentoo with glibc-2.8.
> 
> The solution was discussed on the IRC meeting March 4, 2010
> in #openvpn-discussions.
> <http://thread.gmane.org/gmane.network.openvpn.devel/3242>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  syshead.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 

Applied to bugfix2.1, merged into allmerged.
Commit 081ec9314eaa75769b2351a7b1b05315a4c77560


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuf/VYACgkQDC186MBRfroWSwCgrODOR77AeLjg61macOc+dBfa
DosAoLB7szhiMQpqB8MvxNirwkPyzhJQ
=6+5n
-----END PGP SIGNATURE-----

