Message-ID: <1591567858.4011.15.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sun, 07 Jun 2020 15:10:58 -0700
In-Reply-To: <20200607111138.GA50189@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-3-James.Bottomley@...2316...>
 <20200607111138.GA50189@...1296...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add
 initialization to pick up local configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 2020-06-07 at 13:11 +0200, Gert Doering wrote:
> Hi,
> 
> > diff --git a/src/openvpn/crypto_openssl.c
> > b/src/openvpn/crypto_openssl.c
> > index 4ac77fde..fd57edd2 100644
> > --- a/src/openvpn/crypto_openssl.c
> > +++ b/src/openvpn/crypto_openssl.c
> > @@ -149,6 +149,11 @@ crypto_init_lib_engine(const char
> > *engine_name)
> >  void
> >  crypto_init_lib(void)
> >  {
> > +#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
> > +    OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
> > +#else
> > +    OPENSSL_config(NULL);
> > +#endif
> 
> This is failing on some of the Travis builds, with the error message
> 
> 1191 crypto_openssl.c: In function `crypto_init_lib':
> 1192 crypto_openssl.c:155:5: error: implicit declaration of function
> `OPENSSL_config'; did you mean `OPENSSL_init'? [-Werror=implicit-
> function-declaration]
> 1193     OPENSSL_config(NULL);
> 1194     ^~~~~~~~~~~~~~
> 
> https://travis-ci.org/github/OpenVPN/openvpn/builds/695633823
> 
> From what I can see, this is for the builds with "openssl 1.0.1u" and
> "openssl 1.0.2u" on Bionic.
> 
> 
> I'm not sure if we intend to support these versions, but this needs
> to be fixed - either the code needs to be adjusted or the travis
> build matrix (for master).

Sorry about that.  Best guess is it's missing an include for
openssl/conf.h.  You don't need that today because pretty much every
other openssl header includes it, but that may not always have been so.

Does the below patch fix it?  If it does, it should probably be folded
into the other patch.  It should be safe because openssl/conf.h has
existed for every version of openssl you support.

James

---8>8>8><8<8<8---
From: James Bottomley <James.Bottomley@...2316...>
Subject: [PATCH] crypto_openssl: add include for openssl/conf.h

Fix build failure on older versions of openssl.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 src/openvpn/crypto_openssl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fd57edd2..94b6d85b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -43,6 +43,7 @@
 #include "crypto_backend.h"
 #include "openssl_compat.h"
 
+#include <openssl/conf.h>
 #include <openssl/des.h>
 #include <openssl/err.h>
 #include <openssl/evp.h>
-- 
2.26.2


