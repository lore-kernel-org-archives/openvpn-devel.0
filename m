Message-ID: <4F9A812B.8080709@...1114...>
Date: Fri, 27 Apr 2012 13:21:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<1335521425-23391-1-git-send-email-davids@...1347...>
In-Reply-To: <1335521425-23391-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Clean-up: Presume that Linux is always
 IPv6 capable at build time
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

On 27/04/12 12:10, David Sommerseth wrote:
> These days it is highly unlikely that OpenVPN will be built in a
> non-IPv6 capable Linux environment.  So remove compile-time related
> macros identifying that.
> 
> This also solves an issue which was introduced in commit
> 51bd56f46f55177cf0f8b where HAVE_TUN_PI is no longer detected.  The
> tun_pi struct is defined in linux/if_tun.h, which will be checked
> for later on.  As this struct has history in linux/if_tun.h all
> back to the beginning of the kernel git tree (2.6.12-rc2, April
> 2005), it is considered not needed to check for this struct
> explicit.
> 
> [ v2: Commit 7c0a2b5f2b4409 modifies some of the checks this patch
> touches.  This patch just adopts to those changes ]
> 
> Signed-off-by: David Sommerseth <davids@...1347...> --- 
> configure.ac      |    6 ------ src/openvpn/tun.c |   19
> ------------------- 2 files changed, 0 insertions(+), 25
> deletions(-)
> 

Applied to master on -testing and -stable trees.

commit bff413d5c47645b525988a66c138abf7d198e228
Author: David Sommerseth <davids@...1347...>
Date:   Fri Apr 27 12:10:25 2012 +0200

    Clean-up: Presume that Linux is always IPv6 capable at build time

    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+agSsACgkQDC186MBRfrqVtgCggr0fDHbXxEdIC0lYMlMWYXWm
jpsAniboqsuuFVwmrf8EA4C2tfl1q7op
=a0V/
-----END PGP SIGNATURE-----

