From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 14:35:25 +0100
Message-Id: <20191110133525.6069-3-a@...2181...>
In-Reply-To: <20191110133525.6069-1-a@...2181...>
References: <20191110133525.6069-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on Linux
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .travis/build-check.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index 039a7dcf..250bb454 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -8,6 +8,7 @@ fi
 
 if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
 	export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
+	export CFLAGS="${CFLAGS} -Werror"
 fi
 
 if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then
-- 
2.24.0


