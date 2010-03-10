Message-ID: <4B97BE57.1030905@...1114...>
Date: Wed, 10 Mar 2010 16:44:23 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1267391523-1123-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] bash->bourne script cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Dan Nelson <dnelson@...384...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 22:12, David Sommerseth wrote:
> From: Dan Nelson <dnelson@...384...>
> 
> Many of the scripts in the openvpn source have their shell set to
> /bin/bash, but only two use bash features. The attached patch (against
> openvpn-2.1_rc9) sets the shell on the rest of the scripts to /bin/sh for
> better portability. The only scripts that actually require bash are
> contrib/pull-resolv-conf/client.{up,down} ; they use the ${!var} variable
> indirection feature.
> 
> sf.net tracker:
> <https://sourceforge.net/tracker/?func=detail&aid=2040296&group_id=48978&atid=454721>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  easy-rsa/2.0/build-ca           |    2 +-
>  easy-rsa/2.0/build-dh           |    2 +-
>  easy-rsa/2.0/build-inter        |    2 +-
>  easy-rsa/2.0/build-key          |    2 +-
>  easy-rsa/2.0/build-key-pass     |    2 +-
>  easy-rsa/2.0/build-key-pkcs12   |    2 +-
>  easy-rsa/2.0/build-key-server   |    2 +-
>  easy-rsa/2.0/build-req          |    2 +-
>  easy-rsa/2.0/build-req-pass     |    2 +-
>  easy-rsa/2.0/clean-all          |    2 +-
>  easy-rsa/2.0/inherit-inter      |    2 +-
>  easy-rsa/2.0/list-crl           |    2 +-
>  easy-rsa/2.0/revoke-full        |    2 +-
>  easy-rsa/2.0/sign-req           |    2 +-
>  sample-config-files/firewall.sh |    2 +-
>  sample-scripts/bridge-start     |    2 +-
>  sample-scripts/bridge-stop      |    2 +-
>  17 files changed, 17 insertions(+), 17 deletions(-)
> 

Patch applied to bugfix2.1 branch, merged into allmerged.
Commit b75eb4c5a1cd31effcad9b6fa686dbd43527730a


kind regards,

David Sommerseth


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuXvlIACgkQDC186MBRfrq19wCggOAdo60oWyurnzc76hLwL53k
yDIAn2rRw6vNPz++dLnyjjZ6UvNp+vIs
=mGYY
-----END PGP SIGNATURE-----

