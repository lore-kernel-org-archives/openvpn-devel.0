Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Mon, 20 Feb 2017 15:32:32 +0100
Message-Id: <cover.1487600539.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v2 00/15] Add support for OpenSSL 1.1.x
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
To: openvpn-devel@lists.sourceforge.net

This (limited) series replaces a few patches on the v1 series, namely: 

* "OpenSSL: don't use direct access to the internal of EVP_PKEY"
  This version replaces the previous version and adds function
  EVP_PKEY_id() which is present in 1.0.0 and later but not in
  0.9.8. 

* "OpenSSL: use EVP_CipherInit_ex() instead of EVP_CipherInit()"

This version has been compile-tested with the following versions:

* 0.9.8zh
* 1.0.0t
* 1.0.1u
* 1.0.2k
* 1.1.0-git

Each compilation test was followed by a connection test to an OpenVPN
server (v2.3). So far, everything seems to work. 

Emmanuel Deloget (15):
  OpenSSL: don't use direct access to the internal of SSL_CTX
  OpenSSL: don't use direct access to the internal of X509_STORE
  OpenSSL: don't use direct access to the internal of X509_OBJECT
  OpenSSL: don't use direct access to the internal of RSA_METHOD
  OpenSSL: don't use direct access to the internal of X509
  OpenSSL: don't use direct access to the internal of EVP_PKEY
  OpenSSL: don't use direct access to the internal of RSA
  OpenSSL: don't use direct access to the internal of DSA
  OpenSSL: don't use direct access to the internal of X509_STORE_CTX
  OpenSSL: don't use direct access to the internal of EVP_MD_CTX
  OpenSSL: don't use direct access to the internal of EVP_CIPHER_CTX
  OpenSSL: don't use direct access to the internal of HMAC_CTX
  OpenSSL: SSLeay symbols are no longer available in OpenSSL 1.1
  OpenSSL: constify getbio() parameters
  OpenSSL: use EVP_CipherInit_ex() instead of EVP_CipherInit()

 configure.ac                     |  38 +++
 src/openvpn/crypto.c             |   8 +-
 src/openvpn/crypto_backend.h     |  42 +++
 src/openvpn/crypto_mbedtls.c     |  40 +++
 src/openvpn/crypto_openssl.c     |  54 +++-
 src/openvpn/httpdigest.c         |  78 ++---
 src/openvpn/misc.c               |  14 +-
 src/openvpn/ntlm.c               |  12 +-
 src/openvpn/openssl_compat.h     | 623 +++++++++++++++++++++++++++++++++++++++
 src/openvpn/openvpn.h            |   2 +-
 src/openvpn/push.c               |  11 +-
 src/openvpn/ssl.c                |  38 +--
 src/openvpn/ssl_openssl.c        |  94 +++---
 src/openvpn/ssl_verify_openssl.c |  55 ++--
 14 files changed, 963 insertions(+), 146 deletions(-)
 create mode 100644 src/openvpn/openssl_compat.h

-- 
2.7.4


