From: selva.nair@...277...
Date: Sun,  7 Jan 2018 21:21:14 -0500
Message-Id: <1515378076-5774-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 0/2] Make cryptoapicert work with TLS 1.2
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

From: Selva Nair <selva.nair@...277...>

Hi,

I am not sure how receptive the crypto maintaineres are to the
idea of adding more code into cryptoapi.c, but here goes:

I've been wanting to add TLS 1.2 support for certs in the
Windows cert store using management external key. But that's
a lot more work than extending cryptoapicert support. And,
rather surprsingly, it turns out that the CNG API for signing is
easy to use (well after some groping in the dark..) and doesn't
take much to implement.

So these patches..

The first patch is not really related and to make the existing code
"openssl-1.1 ready" (missed by past patches as no one probably builds
Windows binary with 1.1..).

The second patch is not dependent on this, but close-by code paths
are touched by both.

Selva

Selva Nair (2):
  Bring cryptoapi.c upto speed with openssl 1.1
  TLS v1.2 support for cryptoapicert -- RSA only

 configure.ac                 |   1 +
 src/openvpn/Makefile.am      |   2 +-
 src/openvpn/cryptoapi.c      | 155 ++++++++++++++++++++++++++++++++++---------
 src/openvpn/openssl_compat.h |  14 ++++
 src/openvpn/options.c        |  18 -----
 5 files changed, 140 insertions(+), 50 deletions(-)

-- 
2.1.4


