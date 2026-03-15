From: luca.boccassi@...277...
Date: Sun, 15 Mar 2026 23:05:28 +0000
Message-ID: <20260315230620.1594780-1-luca.boccassi@...277...>
In-Reply-To: <20260315184337.1541272-1-luca.boccassi@...277...>
References: <20260315184337.1541272-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 0/3] Two small fixes for auth via tokens
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

With these small changes, it is possible to successfully
connect to an Azure VPN endpoint using the OpenVPN 2.7 client,
using a dummy username, an Entra token as password and the
server-secret from the azvpn XML config that users get as tls-auth
key.

v2: also use the USER_PASS_LEN macro in the management channel params.

Luca Boccassi (3):
  Increase TLS_CHANNEL_BUF_SIZE from 2048 to 8192
  Unconditionally set USER_PASS_LEN to 4096
  Ensure the management channel can take passwords up to the max length

 src/openvpn/common.h  | 2 +-
 src/openvpn/manage.c  | 4 ++--
 src/openvpn/misc.h    | 4 ----
 src/openvpn/options.h | 6 +++---
 4 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.47.3


