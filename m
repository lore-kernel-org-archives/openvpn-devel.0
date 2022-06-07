From: Christopher Ng <facboy@...277...>
Date: Tue,  7 Jun 2022 17:30:48 +0100
Message-Id: <20220607163049.10056-1-facboy@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH OpenVPN3 1/2] ovpnagent: fix quoting of
 omiclient parameters
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

Signed-off-by: Christopher Ng <facboy@...277...>
---
 openvpn/ovpnagent/win/ovpnagent.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/openvpn/ovpnagent/win/ovpnagent.cpp b/openvpn/ovpnagent/win/ovpnagent.cpp
index 8a31b0aa..fa020e7d 100644
--- a/openvpn/ovpnagent/win/ovpnagent.cpp
+++ b/openvpn/ovpnagent/win/ovpnagent.cpp
@@ -444,14 +444,16 @@ public:
 
       // create command line for openvpn process
       std::ostringstream ss;
-      ss << "client --config " << config_dir << "\\" << config_file << " --exit-event-name "
+      ss << "client --config \"" << config_dir << "\\" << config_file << "\" --exit-event-name "
 	 << exit_event_name << " --auth-retry interact --management " << management_host << " "
 	 << management_port << " stdin --management-query-passwords --management-hold " << "--log"
-	 << (log_append ? "-append " : " ") << log;
+	 << (log_append ? "-append \"" : " \"") << log << "\"";
       std::string cmd = ss.str();
       std::unique_ptr<char[]> buf(new char[cmd.length() + 1]);
       strcpy(buf.get(), cmd.c_str());
 
+      // OPENVPN_LOG("Launching omiclient: " << config.omiclient_exe.c_str() << " " << buf.get());
+
       STARTUPINFO startup_info = { 0 };
       startup_info.cb = sizeof(startup_info);
       startup_info.dwFlags = STARTF_USESTDHANDLES;
-- 
2.34.1


