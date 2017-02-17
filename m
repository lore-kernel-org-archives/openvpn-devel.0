Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:39 +0100
Message-Id: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL 1.1.x
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

From: Emmanuel Deloget <logout@...260...>

The purpose of this RFC series is to make the latest master of OpenVPN
(2.5-git) linkable with OpenSSL v1.1.x. It may not be complete (I may
have missed something due to my work environment, but any missing pieces
will be added next week) so be a bit cautious with this. The 
configuration I used (--without-systemd, --without-lzo) seems to work
but I must confess I did not tested much. 

As you may know, the important information about the API of OpenSSL 1.1
if that it no longer provide access to the content of its objects. The
structure types are now opaque and various functions have been added to
fetch information from these objects. 

Once theses patches have been applied, it is possible to compile 
OpenSSL with the latest 1.0.1 and with the latest 1.1.0. I still have to
check whether compilation with 1.0.0 and 0.9.8 works. I don't try to 
get the OpenSSL version -- I instead decided to check for the presence
of individual functions in the library and chose to reimplement the 
missing ones. Then I changed caller code in order to use this new
interface. The net result is that OpenVPN is now using the OpenSSL 1.1
API -- regardless of the real version of OpenSSL. This might make futur
changes simpler at the cost of adding more functions in the 
openssl_compat.h file. 

Las but not least, because of the way I worked I introduced some strange 
artefacts (I believe they are not really relevant but some of them are 
weird enough to need some explaination). 

* I had to introduce a function of the 1.0 API in the 1.1 code. In the
  1.0 API, HMAC_CTX is populated with HMAC_CTX_init() and cleaned with
  HMAC_CTX_cleanup(). In 1.1 these two functions are gone and replaced
  with HMAC_CTX_reset(). I decided to use _reset() to implement 
  _cleanup() but since I then could not use it for _init() (that would
  break an OpenVPN linked with 1.0) I created a small wrapper in 1.1
  mode. So, in 1.1, HMAC_CTX_init() calls _reset() -- and everybody is
  happy (well, maybe not everybody).  
  
* HMAC_CTX, EVP_MD_CTX and a few other objects cannot be allocated using
  malloc() so I had to change the way these object are used and 
  initialized. I introduces a few new functions in the crypto backend to
  handle this.

* x509_verify_ns_cert_type() checks had to be changed. OpenSSL 1.1 does 
  not provide any solution to access both X509::ex_flags and 
  X509::ex_nscert so the check could not be implemented this way. The
  only solution I found was to use X509_check_purpose() but I'm worried
  that the implemented test is now far more strict. 

* weirdly enough, it's no longer possible to duplicate the n parameter
  of a RSA public key into another RSA public key. If you do so, you
  also need to duplicate the e parameter. The reason is that you cannot
  have (n && !e) or (!n && e) (see RSA_set0_key[1]). I deciced to go
  the same route in my implementation and thus I needed to change the
  code in tls_ctx_use_external_private_key(). 

Thanks for your comprehension, 

[1] https://github.com/openssl/openssl/blob/master/crypto/rsa/rsa_lib.c#L191

-- Emmanuel Deloget

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
  OpenSSL: check for the SSL reason, not the full error
  OpenSSL: constify getbio() parameters

 configure.ac                     |  37 +++
 src/openvpn/crypto.c             |   8 +-
 src/openvpn/crypto_backend.h     |  42 +++
 src/openvpn/crypto_mbedtls.c     |  40 +++
 src/openvpn/crypto_openssl.c     |  53 +++-
 src/openvpn/httpdigest.c         |  78 ++---
 src/openvpn/misc.c               |  14 +-
 src/openvpn/ntlm.c               |  12 +-
 src/openvpn/openssl_compat.h     | 609 +++++++++++++++++++++++++++++++++++++++
 src/openvpn/openvpn.h            |   2 +-
 src/openvpn/push.c               |  11 +-
 src/openvpn/ssl.c                |  38 +--
 src/openvpn/ssl_openssl.c        |  94 +++---
 src/openvpn/ssl_verify_openssl.c |  55 ++--
 14 files changed, 947 insertions(+), 146 deletions(-)
 create mode 100644 src/openvpn/openssl_compat.h

-- 
2.7.4


