MIME-Version: 1.0
Date: Tue, 29 Jul 2014 10:56:05 +0000
Message-ID: <CAGyAFMWg5j+ki56=fwOOZwcpAdixE8eDyJXFgktrNsOqrYZRcA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: [Openvpn-devel] Async OPENVPN_PLUGIN_CLIENT_CONNECT plugin support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I am pondering about asynchronous OPENVPN_PLUGIN_CLIENT_CONNECT
callback. Basically, I want _not_ to establish connection until
response is received and ofcI  don't want to block rest of traffic.

My idea is to have some kind of connect_control_file (similar to
auth_conrol_file) and pass its path via env to
OPENVPN_PLUGIN_CLIENT_CONNECT. In case of plugin (or maybe script
too?) has returned OPENVPN_PLUGIN_FUNC_DEFERRED, I continue executing
"multi_connection_established" as usual except I don't set
"push_reply_deferred" to False (to prevent push response from being
sent) and I set some "connect-deferred" flag.

Next, when "process_incoming_push_msg" get called and flag
"connect-deferred" is set, I check the state of connect_control_file.
If there is, say, "1" - I send push reply and connection got
established.

What do you think about that? Does that approach sound reasonable?

-- 
-Lev

