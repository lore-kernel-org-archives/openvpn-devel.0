Message-ID: <4F0C8745.4070207@...1114...>
Date: Tue, 10 Jan 2012 19:45:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<1323357860-2506-1-git-send-email-davids@...1347...>
In-Reply-To: <1323357860-2506-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v3] Move away from openvpn_basename()
 over to platform provided basename()
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

On 08/12/11 16:24, David Sommerseth wrote:
> This kicks out the openvpn_basename() function from misc.[ch] and puts
> glibc equivalents into compat.[ch].  This is to provide the same 
> functionality on platforms not having a native basename() function 
> available.
> 
> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e 
> depends.  Without dirname(), openvpn won't build in Visual Studio.
> 
> v2: Move all functions from compat.h to compat.c v3: Use glibc 
> versions of basename() and dirname() instead
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- Makefile.am
> | 1 + compat.c     |  129 
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ compat.h |
> 42 +++++++++++++++++++ configure.ac |    2 +- init.c       |    6 ++-
> misc.c       |   23 +--------- misc.h       |    3 - options.c |    1
> - syshead.h    |    2 + 9 files changed, 182 insertions(+), 27 
> deletions(-) create mode 100644 compat.c create mode 100644 compat.h

Applied to master branches on -testing and -stable

commit ec302f7061b7ab4dd21bdac77dd115e75b50cbc0
Author: David Sommerseth <davids@...1347...>
Date:   Thu Dec 8 00:40:45 2011 +0100


    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    URL:
<http://thread.gmane.org/gmane.network.openvpn.devel/5178/focus=5215>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8Mh0UACgkQDC186MBRfrpzKACZAbyca0UVkxkdtwBn5OF6bqEx
CB4AnA7tpFZsvACpTjHkTYr7HTUCNiGw
=qewL
-----END PGP SIGNATURE-----

