Message-ID: <4BBE317A.4030906@...1114...>
Date: Thu, 08 Apr 2010 21:41:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BBE2D0E.4010106@...1114...>
In-Reply-To: <4BBE2D0E.4010106@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Make use of counter_type instead of int
 when counting bytes and network packets
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/04/10 21:22, David Sommerseth wrote:
> This is in response to a reported Debian bug, where the connection
> counter overflows.
> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=576827>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  ssl.c |    3 ++-
>  ssl.h |    4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied to the openvpn-testing.git bugfix2.1 branch.  To be merged into
allmerged soon.
Commit 5acb71a0aab49e10233bcfbc84c6c4685cb93f9d


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku+MXoACgkQDC186MBRfroLBwCghCrrheZ0Mm5oDTqLDAOGOUOw
6u8AoIJJYLn0nn+tejE6QQLRDx3oAgdX
=jVBz
-----END PGP SIGNATURE-----

