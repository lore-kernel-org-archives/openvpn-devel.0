From: selva.nair@...277...
Date: Wed, 24 Jan 2018 00:06:18 -0500
Message-Id: <1516770381-29466-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 0/3]
 Support-EC-certificates-with-cryptoapicert
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

With ecdsa signature support via management-external-key in limbo,
let's try to get EC support for Windows users through cryptoapicert.

Patch 1 and 2 are some code refactoring to make it easy for
the 3rd patch that implements ECDSA signing using NCryptSignHash().

Tested on Windows 10 and Windows 7 with openssl 1.1.0g and 
an EC cert in user's certificate store.

Selva Nair (3):
  Move code to free cd to a function CAPI_DATA_free()
  Move setting private key to a function in prep for EC support
  Support EC certificates with cryptoapicert

 src/openvpn/cryptoapi.c | 381 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 296 insertions(+), 85 deletions(-)

-- 
2.1.4


