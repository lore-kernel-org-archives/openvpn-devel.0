From: David Sommerseth <openvpn@...2080...>
Date: Wed, 20 Apr 2022 14:13:21 +0200
Message-Id: <20220420121322.42732-2-openvpn@...2080...>
In-Reply-To: <20220420121322.42732-1-openvpn@...2080...>
References: <20220420121322.42732-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] dev-tools: Remove uncrusify -p
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

The -p option to uncrustify was providing debug information about
decisions done by uncrustify.  This was useful when debugging why
certain formatting choices.

With newer versions of uncrusitfy the -p option can only be used on
individual files and not a list of files.  Since still supporting this
would require a bigger rewrite of reformat-all.sh, it was chosen to
instead remove the usage of this option.  If certain behaviours needs to
be debugged, running uncrusity on individual files directly will work
fine anyhow.

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/reformat-all.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index dc2bfc4e..ff126b0f 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -80,8 +80,8 @@ cd "$srcroot"
 
     # Kick off uncrustify
     echo
-    echo "** INFO ** Running: uncrustify -c $cfg --no-backup -l C -p debug.uncr -F $files"
-    uncrustify -c "$cfg" --no-backup -l C -p debug.uncr -F "$files" 2>&1
+    echo "** INFO ** Running: uncrustify -c $cfg --no-backup -l C -F $files"
+    uncrustify -c "$cfg" --no-backup -l C -F "$files" 2>&1
     res=$?
     echo "** INFO ** Uncrustify completed (exit code $res)"
 } | tee "${log}-1"  # Log needs to be closed here, to be processed in next block
-- 
2.27.0


