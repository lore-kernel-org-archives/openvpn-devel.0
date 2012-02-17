Message-ID: <4F3E498D.6080602@...1114...>
Date: Fri, 17 Feb 2012 13:35:25 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329478233-20295-1-git-send-email-davids@...1347...>
In-Reply-To: <1329478233-20295-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Makefile.am was missing ssl_common.h
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

On 17/02/12 12:30, David Sommerseth wrote:
> In commit 9a160b796e1a40f9635231e5533ce40d46dba25f ssl_common.h was 
> introduced, but never listed as a source file in Makefile.am
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- Makefile.am | 
> 1 + 1 files changed, 1 insertions(+), 0 deletions(-)
> 

Applied to master branch on -testing and -stable trees.

commit 5e1e5495328bb491a186d72544d2e57f49dfdedc
Author: David Sommerseth <davids@...1347...>
Date:   Fri Feb 17 12:29:27 2012 +0100

    Makefile.am was missing ssl_common.h

    In commit 9a160b796e1a40f9635231e5533ce40d46dba25f ssl_common.h
    was introduced, but never listed as a source file in Makefile.am

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+SYoACgkQDC186MBRfrqq2gCglwyqhnfiCCuE6sUMlQ324paz
vsMAoI5WpwMbYWhaDHISphVi7xW5c0rs
=IPb6
-----END PGP SIGNATURE-----

