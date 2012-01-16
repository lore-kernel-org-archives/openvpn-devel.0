Message-ID: <4F13E937.2070809@...1114...>
Date: Mon, 16 Jan 2012 10:09:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F116B5F.1070100@...1114...>
	<4F116C87.5090805@...1114...>
In-Reply-To: <4F116C87.5090805@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Fix pool logging when IPv6 is not
	enabled
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

On 14/01/12 12:52, David Sommerseth wrote:
> On 14/01/12 12:47, David Sommerseth wrote: | | Hi, | | I'm running
> the master branch (commit 330baf2aee70b35) on a site where IPv6 | 
> tunnelling is not enabled.  I found some odd IPv6 addresses in the
> log file | when clients connected.  Attached is a patch solving this 
> issue.  It's | basically a bogus message, and nothing seems to be 
> pushed to the client. | | This site is now running with this patch 
> applied, and it behaves better. |
> 
> New improvement, now even with an attachment ... duh!  ;-)

Applied to master branch on -testing and -stable trees.


commit cb383dc3bc161c1e4ea6b535097e0f64a725e081
Author: David Sommerseth <dazo@...384...>
Date:   Sat Jan 14 12:34:59 2012 +0100

    Fix pool logging when IPv6 is not enabled

    Signed-off-by: David Sommerseth <dazo@...384...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8T6TUACgkQDC186MBRfrpxSwCfSsuiqs4T4QNYrnnQQLgB3Y2g
IX0AoKnZOVQ5grJzMkvBExBfK8jqMBFL
=u/la
-----END PGP SIGNATURE-----

