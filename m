Message-ID: <1512503184.3019.29.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 05 Dec 2017 11:46:24 -0800
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/1] add engine keys keys
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
To: openvpn-devel@lists.sourceforge.net

Engine keys are an openssl concept for a key file which can only be
understood by an engine (usually because it's been wrapped by the
engine itself).  We use this for TPM engine keys, so you can either
generate them within your TPM or wrap them from existing private keys.
 Once wrapped, the keys will only function in the TPM that generated
them, so it means the VPN keys are tied to the physical platform, which
is very useful.  Engine keys have to be loaded via a specific callback,
so use this as a fallback in openvpn if an engine is specified and if
the PEM read of the private key fails.

James Bottomley (1):
  openssl: add engine method for loading the key

 src/openvpn/crypto_openssl.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h | 12 ++++++++++
 src/openvpn/ssl_openssl.c    |  6 ++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.12.3

