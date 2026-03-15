From: luca.boccassi@...277...
Date: Sun, 15 Mar 2026 18:39:54 +0000
Message-ID: <20260315184337.1541272-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/2] Two small fixes for auth via tokens
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
Cc: Luca Boccassi <luca.boccassi@...277...>

From: Luca Boccassi <luca.boccassi@...277...>

When JWT (json web tokens) are used by a server to authenticate
the client, the default TLS channel buffer size and password length
are too small.
In my local case connecting to an Azure VPN server, the Entra ID
token is ~2100 bytes.

With these two small changes, it is possible to successfully
connect to an Azure VPN endpoint using the OpenVPN 2.7 client,
using a dummy username, an Entra token as password and the
server-secret from the azvpn XML config that users get as tls-auth
key.

Luca Boccassi (2):
  Increase TLS_CHANNEL_BUF_SIZE from 2048 to 8192
  Unconditionally set USER_PASS_LEN to 4096

 src/openvpn/common.h | 2 +-
 src/openvpn/misc.h   | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.47.3


