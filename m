Message-ID: <40A0D23D.30902@...199...>
From: Mike Auty <m.auty@...199...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0 Multi-client and transparent bridged firewalling
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
Date: Tue May 11 06:22:09 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James,
	Our current setup is one where we have staff and clients using the VPN 
to connect into our network, staff for normal work, clients for remote 
troubleshooting.  We'd like to block clients off from both each other 
and the main network with connection tracking so that they cannot make 
connections into staff areas, but staff can make connections into them. 
  Also Staff must be allowed total access.
	As far as I understand it at the moment, even though the OpenVPN 2.0 
system can work as it's own router, it will by default pass packets out 
to the system for firewalling/routing etc.  This is exactly what I'm 
after, so that's great.  What I'm trying to do now is have the 
--client-connect script determine which MAC addresses come from which 
remote client and firewall them appropriately.  I was firstly wondering 
if this was possible and secondly, assuming that at the moment it 
wasn't, how best it might be handled in the new system.  Perhaps calling 
a script when a MAC is learnt, or kernel packet tagging or creating many 
virtual adaptors.  The last two ideas are neither scalable nor good 
solutions, but the scripting idea also seems cumbersome unless the same 
script is called with the common name and the new MAC learnt...
	My current ideas for work arounds are to parse the logs looking for 
"MULTI: learn" lines, then call scripts and firewall based on that.  The 
other more feasible idea is since there are only really two divisions 
(staff and clients) to set up two adaptors and have one allow only 
clients, and the other only staff.  This however sidesteps the issue of 
linking a certificate common name to network traffic in some way.  Any 
ideas/comments would be appreciated...
	Thanks,
	Mike  5:)

