Message-ID: <4F999F1D.2090307@...1114...>
Date: Thu, 26 Apr 2012 21:16:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1333912907-7916-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333912907-7916-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: properly detect TUNSETPERSIST
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

On 08/04/12 21:21, Alon Bar-Lev wrote:
> Do not rely on system symbol throught sources but on autoconf
> detection.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> configure.ac          |   10 ++++++++++ src/openvpn/init.c    |
> 2 +- src/openvpn/options.c |    8 ++++---- src/openvpn/tun.c     |
> 4 ++-- 4 files changed, 17 insertions(+), 7 deletions(-)

ACK.  Applied to master on -testing and stable trees.

commit 88f3a4026c48e92bf3ce18d7611b7b88f7bed0be
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 8 22:21:47 2012 +0300

    build: properly detect TUNSETPERSIST

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Znx0ACgkQDC186MBRfrosWACfe6M4dSExF+PnxnTUz8SsIada
nC0AnAlzgK4la5UDNgdvUZ0FvTMibSSE
=zhhN
-----END PGP SIGNATURE-----

