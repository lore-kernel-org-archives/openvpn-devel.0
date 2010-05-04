Message-ID: <4BE08F13.2000402@...1114...>
Date: Tue, 04 May 2010 23:18:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272982907-30917-1-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272982907-30917-1-git-send-email-fabian.knittel@...1338...>
Subject: Re: [Openvpn-devel] [PATCH] ssl.c: fix use of
 openvpn_run_script()'s return value
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
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/05/10 16:21, Fabian Knittel wrote:
> This patch fixes two bugs introduced in
> 
>     commit 339f2a4d4b487afa53fa99d72c35b16f31e417d3
>     Author: David Sommerseth <dazo@...384...>
>     Date:   Thu Apr 29 23:35:45 2010 +0200
> 
> David's patch replaced openvpn_execve() with openvpn_run_script() in two places,
> but didn't adjust the return value handling.  openvpn_run_script() returns true
> or false, while openvpn_execve() returns the program's exit code.
> 
> Without the fix, the --tls-verify script and the --auth-user-pass-verify
> script fail to run.  (I noticed the latter, but haven't actually tested the
> former.)
> 
> The return value handling is fine for the other places where
> openvpn_run_script() is used, because those places previously used
> openvpn_execve_check() (notice the "_check" suffix).
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
> ---
>  ssl.c |   20 ++++++--------------
>  1 files changed, 6 insertions(+), 14 deletions(-)

Thanks for catching this one.  It looks good so: ACK!

I've applied the patch to the feat_misc branch, where the offending
commit was applied.  Merged into allmerged.
Commit c5b7923a2b0a94d702e1dad59438f7ee75971d3b


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvgjxMACgkQDC186MBRfrojjgCgkcFTTx4jcmHjdJcZaEiuyl6I
HCgAn2OViGVjY3lhaDqodTSccmxD/coM
=7l6c
-----END PGP SIGNATURE-----

