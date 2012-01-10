Message-ID: <4F0C62F3.5000105@...1114...>
Date: Tue, 10 Jan 2012 17:10:27 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1326129087-8697-1-git-send-email-davids@...1347...>
In-Reply-To: <1326129087-8697-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a couple of issues in
	openvpn_execve()
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

On 09/01/12 18:11, David Sommerseth wrote:
> If openvpn_execve() is not able to fork(), it would make any noise 
> about it.  So this patch adds a log notification if this happens.
> 
> In addition, if openvpn_execve() is called with an empty argv array, 
> it should exit instantly.  This is not expected to happen at all and 
> might indicate a much more serious issue (or programming error) 
> somewhere else in the code.  Thus, abort execution to get these issues
> flushed out as quickly as possible.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- misc.c |    4 
> ++-- 1 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied to master branch in -testing and -stable.

commit 8ee5646111625c598efbc82413649b1ab6275877
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8MYvAACgkQDC186MBRfrpbtwCeIo9lIFjRaAWXL9NM7yIBaD4V
+1YAoKZ+SdjP2vHRX+lq3i8G5Rg4UuhW
=+Oq1
-----END PGP SIGNATURE-----

