Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Mon, 12 Jun 2017 15:43:22 +0200
Message-Id: <20170612134330.20971-1-logout@...260...>
In-Reply-To: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
Subject: [Openvpn-devel] [PATCH v7 0/8] OpenSSL: support for version 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This is version 7 of the OpenSSL 1.1 patch series. It has been rebased
on top of the latest git revision.

It builds upon the previous version and adds the following: 

* fix a memory leak when playing with internal ASN1 strings
* introduce RSA_bits() and DSA_bits()
* add a few comments to explain that, yes, we are allowed to do weird 
  const-to-non-const cast because of OpenSSL API. Of course, it would be
  better if we could have avoided them.

This version fixes all the problems that Steffan spotted on the previous
version (to the best of my knowledge).

Please tell me if there is anything wrong (or not good enough). 

[PATCH 1/8] OpenSSL: don't use direct access to the internal of X509
[PATCH 2/8] OpenSSL: don't use direct access to the internal of EVP_PKEY
[PATCH 3/8] OpenSSL: don't use direct access to the internal of RSA
[PATCH 4/8] OpenSSL: don't use direct access to the internal of DSA
[PATCH 5/8] OpenSSL: don't use direct access to the internal of EVP_MD_CTX
[PATCH 6/8] OpenSSL: don't use direct access to the internal of EVP_CIPHER_CTX
[PATCH 7/8] OpenSSL: don't use direct access to the internal of HMAC_CTX
[PATCH 8/8] OpenSSL: force meth->name as non-const when we free() it

Diffstat is here:

 configure.ac                     |  19 +++
 src/openvpn/crypto.c             |   8 +-
 src/openvpn/crypto_backend.h     |  42 +++++
 src/openvpn/crypto_mbedtls.c     |  40 +++++
 src/openvpn/crypto_openssl.c     |  50 +++++-
 src/openvpn/httpdigest.c         |  78 ++++-----
 src/openvpn/misc.c               |  14 +-
 src/openvpn/ntlm.c               |  12 +-
 src/openvpn/openssl_compat.h     | 351 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/openvpn.h            |   2 +-
 src/openvpn/push.c               |  11 +-
 src/openvpn/ssl.c                |  38 +++--
 src/openvpn/ssl_openssl.c        |  35 ++--
 src/openvpn/ssl_verify_backend.h |   2 +-
 src/openvpn/ssl_verify_mbedtls.c |   2 +-
 src/openvpn/ssl_verify_openssl.c |  68 ++++++--
 16 files changed, 660 insertions(+), 112 deletions(-)

The series can be checked on github at 
  https://github.com/emmanuel-deloget/openvpn/commits/openssl-1.1-v7

Best regards, 

-- Emmanuel Deloget

