Message-ID: <4BDB4D67.4040001@...1114...>
Date: Fri, 30 Apr 2010 23:36:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272109716-3037-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1272109716-3037-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Revamped the script-security warning
 logging
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

On 24/04/10 13:48, David Sommerseth wrote:
> From: David Sommerseth <dazo@...384...>
> 
> This is a first-cut of removing misleading warnings from the logs.
> 
> The main task of this patch is to avoid reporting the SCRIPT_SECURITY_WARNING
> over and over again, in addition to not show this warning when it should not
> be a problem.  This general warning should now only appear once, and only when
> --script-security is not set, 0 or 1.  In all other cases this warning should
> not appear.
> 
> In addition, this warning will come close to the script-hook which most probably
> will fail.  It will also give a little bit more concrete hint on which script-hook
> which failed.  If --script-security is 2 or 3, only the execve failure itself will
> be shown.  This message will on the other hand be shown repeatedly.
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  common.h |    2 +-
>  init.c   |    2 +-
>  misc.c   |   25 ++++++++++++++++++++++---
>  misc.h   |    3 +++
>  multi.c  |    6 +++---
>  socket.c |    2 +-
>  ssl.c    |    4 ++--
>  win32.c  |    5 ++++-
>  8 files changed, 37 insertions(+), 12 deletions(-)

This patch received an ACK on the developers meeting 2010-04-29
<http://thread.gmane.org/gmane.network.openvpn.devel/3673>

Applied to feat_misc and merged into allmerged.
Commit 339f2a4d4b487afa53fa99d72c35b16f31e417d3


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvbTWcACgkQDC186MBRfrqOcACgqZpBjyXOiCIsguEsXtKE1uVJ
dQoAnRG2IuNETVCG+d52saKWSTlRzwap
=brqt
-----END PGP SIGNATURE-----

