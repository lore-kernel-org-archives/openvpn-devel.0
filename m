Message-ID: <4F43A0F4.7010401@...1114...>
Date: Tue, 21 Feb 2012 14:49:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1313596381-23302-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313596381-23302-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] remove wrapper code for Windows
 CryptoAPI function
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

On 17/08/11 17:53, Heiko Hund wrote:
> The CryptoAPI function CryptAcquireCertificatePrivateKey() was
> previously unsupported in MinGW. With recent w32api headers it's now
> defined, mostly. Since the code used to load the CryptoAPI DLL is
> prone to a DLL hijacking attack [1], it's now a good time to get rid
> of wrapper completely.
> 
> Just a few macros left that may still be undefined on some systems
> using the original MinGW headers.
> 
> [1] http://isc.sans.edu/diary.html?storyid=9445
> 
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- cryptoapi.c |
> 43 +++++++++++++------------------------------ 1 files changed, 13
> insertions(+), 30 deletions(-)

One more old patch recovered from the dust.  Applied to master branch on
- -testing and -stable trees.

commit 14a382a3f1c70fdbc822bcad27096040ed394661
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Wed Aug 17 15:53:01 2011 +0000

    remove wrapper code for Windows CryptoAPI function

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: James Yonan <james@...515...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/4979
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9DoPMACgkQDC186MBRfromnwCeP8qqwfaEtZ1//ql+AAVM3RMG
6M0AoInMli3/80vp1zFCL42O26iUyTUP
=LpaP
-----END PGP SIGNATURE-----

