Message-ID: <4F0C88B8.5090603@...1114...>
Date: Tue, 10 Jan 2012 19:51:36 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
	<1323344337-13193-1-git-send-email-davids@...1347...>
In-Reply-To: <1323344337-13193-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Enable access() when building in Visual
 Studio
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

On 08/12/11 12:38, David Sommerseth wrote:
> Visual Studio does not enable certiain standard Unix functions, such 
> as access().  By defining _CRT_NONSTDC_NO_WARNINGS and 
> _CRT_SECURE_NO_WARNINGS, these functions are enabled.
> 
> This patch also adds a ./configure check for access() as well, in
> case this needs to be implemented on other platforms lacking this
> feature. Which is why HAVE_ACCESS is defined in win/config.h.in
> 
> Thanks to Alon Bar-Lev for helping solving this.
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- configure.ac |
> 2 +- options.c       |    1 - win/config.h.in |   28 
> ++++++++++++++++++++++++++++ win/msvc.mak.in |    2 +- 4 files 
> changed, 30 insertions(+), 3 deletions(-)

Applied to master branch on -testing and -stable

commit a4234e1e26693e8fe6a67eea5824ef02d11c825e
Author: David Sommerseth <davids@...1347...>
Date:   Thu Dec 8 12:38:57 2011 +0100

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    URL:
<http://thread.gmane.org/gmane.network.openvpn.devel/5179/focus=5200>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8MiLUACgkQDC186MBRfroMzgCfV8EIUlYNx+ezvsbDHO2ShwCz
79MAn0IBrPeP6c8TM1hkeyeN+KJJAgYA
=BftI
-----END PGP SIGNATURE-----

