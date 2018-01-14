From: selva.nair@...277...
Date: Sun, 14 Jan 2018 14:44:30 -0500
Message-Id: <1515959073-10376-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 0/3] Support external EC cert/key using
 --management-external-xxx
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

For now this is only for openssl 1.1.0+. With some ifdefs and compat functions
could be back ported to 1.0.2. 

For 1.0.1 hacks like duplicating internal ECDSA_METHOD struct or linking
to internal headers appears to be required. Not interesting unless there is a
strong demand.

For mbedtls I've no idea how to hook into the ecdsa signing methods.

Tested on linux/openssl-1.1.0g by manually passing the signature to
management, with signature generated on command line by
'echo $rsa_sig_cut_n_paste | base64 -d | openssl pkeyutl -inkey keyfile | base64'

Doing something similar for cryptoapicert is in the works (actually that was the
objective, but this was obviously easier to test, lather, rinse)

Selva

Selva Nair (3):
  Refactor ssl_openssl.c in prep for external EC key support
  Allow external EC key through --management-external-key
  Document management request >ECDSA_SIGN and response ecdsa-sig

 doc/management-notes.txt  |  30 ++++++
 src/openvpn/manage.c      |  30 ++++++
 src/openvpn/manage.h      |   3 +
 src/openvpn/ssl_openssl.c | 234 +++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 273 insertions(+), 24 deletions(-)

-- 
2.1.4


