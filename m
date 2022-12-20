From: Arne Schwabe <arne@...1227...>
Date: Tue, 20 Dec 2022 15:04:58 +0100
Message-Id: <20221220140458.2666637-1-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/8] Make management password check
 constant time
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
Cc: Connor Edwards <cedw@...2705...>

This changes the password check on the management interface to be constant
time. Normally the management port should not be exposed in a way that allows
an attacker to even interact with it but making the check constant time as
an additional layer of security is always good.

Patch v2: include NUL byte in comparison

Reported-by: Connor Edwards <cedw@...2705...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index b11de224d..5465b7e9b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -198,7 +198,12 @@ man_check_password(struct management *man, const char *line)
 {
     if (man_password_needed(man))
     {
-        if (streq(line, man->settings.up.password))
+        /* This comparison is not fixed time but since strlen(time) is based on
+         * the attacker choice, it should not give any indication of the real
+         * password length, use + 1 to include the NUL byte that terminates the
+         * string*/
+        size_t compare_len = min_uint(strlen(line) + 1, sizeof(man->settings.up.password));
+        if (memcmp_constant_time(line, man->settings.up.password, compare_len) == 0)
         {
             man->connection.password_verified = true;
             msg(M_CLIENT, "SUCCESS: password is correct");
-- 
2.37.1 (Apple Git-137.1)


