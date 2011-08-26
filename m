Message-ID: <4E575276.80206@...1114...>
Date: Fri, 26 Aug 2011 09:59:50 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
In-Reply-To: <1313652334-15914-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
 $KEY_CONFIG variable in easy-rsa/2.0/vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/11 09:25, samuli@...515... wrote:
> From: Samuli Seppänen <samuli@...515...>
> 
> Original $KEY_CONFIG variable generation in broke if $EASY_RSA had whitespace in
> it. This patch fixes the issue in a POSIX-compliant way.
> 
> Signed-off-by: Tanel Rebane <tanel@...1495...>
> Signed-off-by: Samuli Seppänen <samuli@...515...>
> Tested-by: Samuli Seppänen <samuli@...515...>
> ---
>  easy-rsa/2.0/vars |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
> index 2ea1ced..780ecf6 100755
> --- a/easy-rsa/2.0/vars
> +++ b/easy-rsa/2.0/vars
> @@ -26,7 +26,7 @@ export GREP="grep"
>  # This variable should point to
>  # the openssl.cnf file included
>  # with easy-rsa.
> -export KEY_CONFIG=`$EASY_RSA/whichopensslcnf $EASY_RSA`
> +export KEY_CONFIG=$("$EASY_RSA"/whichopensslcnf "$EASY_RSA")

Even though I personally like this syntax better, isn't it better to use
the `` syntax instead of $() due to portability?  Or are we sure that $()
functional everywhere nowadays?


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk5XUmoACgkQDC186MBRfrq1CwCfbN5YVMx2ZMsChWO3kik3dA5/
tdEAoKN+9lvvUoLU4zwsgaM1IEimnUas
=l3K8
-----END PGP SIGNATURE-----

