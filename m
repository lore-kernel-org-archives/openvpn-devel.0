From: Boris <borisl@...573...>
Message-ID: <loom.20060316T181952-312@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] route in client-config-dir file
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
Date: Thu Mar 16 09:31:07 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there!

Why route command is not supported in client-specific files?
I want to create dynamic-routed client structure, e.g.
3 clients with some network behind them to share with other openvpn-clients.

When some of them connects/disconnects to openvpn server, server's routing 
table must be updated by adding/deleting item.




