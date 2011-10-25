Message-ID: <4EA68CE7.9030301@...1114...>
Date: Tue, 25 Oct 2011 12:18:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319465474-26989-1-git-send-email-dejong@...1435...>
In-Reply-To: <1319465474-26989-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Further removal of des_old.h based calls
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/10/11 16:11, Adriaan de Jong wrote:
> Replaced des_set_key_unchecked and des_ecb_encrypt functions in
> cipher_des_encrypt_ecb
> 
> Signed-off-by: Adriaan de Jong <dejong@...1435...> --- 
> crypto_openssl.c |    4 ++-- 1 files changed, 2 insertions(+), 2
> deletions(-)
> 
> diff --git a/crypto_openssl.c b/crypto_openssl.c

ACKed by Gert on IRC.  Applied and pushed.  NetBSD builds seems to go
fine again now.

commit 6e8b90ec0d0a074ac529541ce9515f25b30bac88
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Oct 24 16:11:14 2011 +0200

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6mjOQACgkQDC186MBRfroJqACfX2RyHyKMB8P6nea69/v8PXY3
GM0An2Gpw/Zhqq4w59XSU5XMbQnlyT5+
=+ULv
-----END PGP SIGNATURE-----

