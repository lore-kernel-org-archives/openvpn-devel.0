Message-ID: <4EE0B5EC.90804@...1114...>
Date: Thu, 08 Dec 2011 14:04:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
	<1323349296-21088-1-git-send-email-davids@...1347...>
In-Reply-To: <1323349296-21088-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Move away from openvpn_basename() over
 to platform provided basename()
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
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Please ignore!  Troubles with SMTP relay, and I managed to resend the
wrong patch to the wrong thread.  Sorry!

David S.


On 08/12/11 14:01, David Sommerseth wrote:
> This kicks out the openvpn_basename() function from misc.[ch] andputs 
> it into compat.[ch].  This is to provide the same functionality on 
> platforms not having a native basename() function available.
> 
> In addition this patch adds dirname() which commit 0f2bc0dd92f43c91e 
> depends.  Without dirname(), openvpn won't build in Visual Studio.
> 
> v2: Move all functions from compat.h to compat.c
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- Makefile.am  |
> 1 + compat.c     |   82
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ compat.h
> |   42 +++++++++++++++++++++++++++++ configure.ac |    2 +- init.c
> |    6 +++- misc.c       |   23 ++-------------- misc.h       |    3
> -- options.c    |    1 - syshead.h    |    2 + 9 files changed, 135
> insertions(+), 27 deletions(-) create mode 100644 compat.c create mode
> 100644 compat.h


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7gteoACgkQDC186MBRfroregCfdHxwZmFUlx3ptHoYTJXhWMiM
pfkAn15AHPu+hkVg3H4j78wIEbLWrGIO
=X+IE
-----END PGP SIGNATURE-----

