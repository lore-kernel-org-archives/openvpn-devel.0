Message-ID: <35f70db10709130128x55c0f13agf43a6a17215cadcf@...278...>
Date: Thu, 13 Sep 2007 10:28:38 +0200
From: "Ross Cameron" <ross.cameron@...1049...>
Sender: abalour@...277...
MIME-Version: 1.0
Subject: [Openvpn-devel] Additional feature
Reply-To: ross.cameron@...1049...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Sorry for cross posting across the users and devel lists.

I'm thinking of adding a port knocking (and in time SPA - Single
Packet Authentication) module to OpenVPN.
      And before anyone asks,.... we're using port knocking as a thin
layer to obscure the devices from automated script kiddy scans.
      I am aware that it should not (and indeed is not) relied on as a
security measure,... but it serves the purpose of making life a little
harder for those without inside information to find the device/system
service.

So far I have a VERY cludgy implementation that does what I need it to
do in the lab,... but I'd like to build a proper module for this.

What I need the module to do is as follows...
================================
Whenever the OpenVPN service wants to connect to a remote OpenVPN
server installation it need to take the address or hostname of the
device it wants to connect to,...

Parse that against a config file,... or config section of the current
OpenVPN config file,... and collect the port knock sequence.

Run the port knock sequence against the target host,... wait one (1)
second to allow for the remote port opening,... and then run the
standard OpenVPN protocol from there on.
      The opened port is opened ONLY to the host/IP from which the
knock came and also only for 15seconds (reconfigurable).
      Thereafter the successfully initialized VPN traffic will be
allowed through the ESTABLISHED rules of the firewall.

This should work for multiple upstream servers and each port knock
should be uniquely configurable per upstream server.

And the port knock should be run regardless of the reason for the
tunnel being brought down,... and it must be run whenever OpenVPN
tries to recover from a stale or locked up tunnel as well.

Any advice??? Anyone want to work on a project like this???

Any and all assistance more than gratefully accepted.

