From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:12 +0200
Message-ID: <1308909312-17824-20-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 28/28] Added a check for Openssl or PolarSSL
	defines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 options.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/options.h b/options.h
index 8a51502..39ca68a 100644
--- a/options.h
+++ b/options.h
@@ -77,6 +77,9 @@ struct options_pre_pull
 };
 
 #endif
+#if !defined(USE_OPENSSL) && !defined(USE_POLARSSL)
+# error "At least on of OpenSSL or PolarSSL needs to be defined."
+#endif
 
 struct connection_entry
 {
-- 
1.7.4.1


