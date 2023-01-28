From: selva.nair@...277...
Date: Sat, 28 Jan 2023 17:34:17 -0500
Message-Id: <20230128223421.2207802-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Improvements for cryptoapi.c
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

1. Support selecting certificate using issuer name
   (goal: "planned obsolescence" of 2.6, already :)

2. Log the selected certificate's name
 
3. Remove Pre OpenSSL-3.01 support
   (goal: leaner and meaner)

4. Simplify parsing of thumbprint hex string

 doc/man-sections/windows-options.rst |  13 +-
 src/openvpn/cryptoapi.c              | 629 +++------------------------
 src/openvpn/options.c                |   2 +-
 src/openvpn/win32-util.c             |  15 +
 src/openvpn/win32-util.h             |   3 +
 5 files changed, 84 insertions(+), 578 deletions(-)

-- 
2.34.1


