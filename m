Message-ID: <4C9486CE.80608@...1114...>
Date: Sat, 18 Sep 2010 11:30:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1284736735-25248-1-git-send-email-dazo@...384...>
In-Reply-To: <1284736735-25248-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Fixed compiler warnings reported on
 Ubuntu 10.04
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/09/10 17:18, David Sommerseth wrote:
> The warnings reported where:
> --------------------------------------------------------
> misc.c:158: warning: ignoring return value of ‘nice’, declared with attribute warn_unused_result
> options.c:4033: warning: format not a string literal and no format arguments
> options.c:4043: warning: format not a string literal and no format arguments
> options.c:4053: warning: format not a string literal and no format arguments
> push.c:182: warning: format not a string literal and no format arguments
> push.c:199: warning: format not a string literal and no format arguments
> push.c:235: warning: format not a string literal and no format arguments
> status.c:171: warning: ignoring return value of ‘ftruncate’, declared with attribute warn_unused_result
> --------------------------------------------------------
>
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  misc.c    |    5 ++---
>  options.c |    6 +++---
>  push.c    |    6 +++---
>  status.c  |    4 +++-
>  4 files changed, 11 insertions(+), 10 deletions(-)
>

Applied to the bugfix2.1 branch.  Will be merged into the allmerged and
beta2.2 branches in the near future.

commit d3d6d1cbdaca58d7c785ef7898d1134007fbc323
    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: Peter Stuge <peter@...1287...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyUhswACgkQDC186MBRfrpMyQCcC2CrTPbL0uNenoIF24IVDqnH
RvMAn3j8hUmPxW6O8286NIGH32a6xRdY
=S/eD
-----END PGP SIGNATURE-----

