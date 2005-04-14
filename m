From: RN <rn23@...160...>
Message-ID: <loom.20050414T234219-298@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Plugins programming issue
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 14 14:56:08 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

OpenVPN issue on rc21: I experience a very big oddity when a plugin is 
initialized with OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY flag on, but the VPN 
config is set to TLS: on ssl.c, we get into the "if" on line 2581, but this is 
IMO not correct. Then we go further to read_string on line 2589 and finally 
fail.

I also wonder if something of the sort happens then the VPN is set to work 
with U/P and the plugin is initialized with OPENVPN_PLUGIN_TLS_VERIFY.

The problem, is that the plugin may be initialized for informational purposes 
only to handle the event. The bigger problem, is that one configuration may 
have TLS and another one U/P, and both may use the same plugin. My plugin 
sends all the event to an ODBC source, therefore suffering a great deal from 
this IMO broken behaviour.

IMO, the condition on line 2581 should lead in this case directly to 
the "else" on line 2624 to behave correctly.

Unfortunately I am not legally allowed to contribute GPL'ed fixes, so I would 
appreciate a community fix.

TIA,
RN



