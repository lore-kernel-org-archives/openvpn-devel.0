From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Aug 2020 18:17:23 +0200
Message-Id: <20200810161723.25576-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] travis: don't run t_net.sh test
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

Not all travis instances are fit for running t_net.sh test due to
various configurations knob that we have no access to.

Prevent failures by not running t_net.sh on travis at all.
The t_net.sh is executed by other test rigs which we have more control
over.

The test is skipped by specifying RUN_SUDO=false which will make any
pre-test fail, forcing the Makefile to skip that particular test.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Tested on travis:
https://travis-ci.org/github/OpenVPN/openvpn/builds/716605942

 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 9e374f55..2d379c70 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -7,6 +7,7 @@ language: c
 env:
   global:
     - JOBS=3
+    - RUN_SUDO="false"
     - PREFIX="${HOME}/opt"
     - TAP_WINDOWS_VERSION=9.23.3
     - LZO_VERSION=2.10
-- 
2.28.0


