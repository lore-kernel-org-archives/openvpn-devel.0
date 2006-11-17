Message-ID: <15c1dfa0611171039x3e3de194q4b69b9424986606b@...278...>
Date: Fri, 17 Nov 2006 19:39:57 +0100
From: "Ulrik Mikaelsson" <ulrik.mikaelsson@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Patch that provides unidirectional IGMP snooping in
	the multi-client server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

I would like to announce the attached patch, it's not very pretty, but have
proved to be working well under my required circumstances.

What it does:
 * Handles IGMPv2 snooping
 * Handles mcast-traffic flowing "downstream" on the server-side of a
multi-client server.
 * Handles both group-timeouts, and immediate-leave.
 * Handles TAP-VPN
 * Works well with even relatively heavy multicast-traffic without much
extra system-load. (Of course offloads the server, compared to the previous
broadcast-behaviour.)
 * Spit out some extra output for debugging purposes.
 * Have been round-the-clock running on a relatively heavily used system for
a couple of months now, without noticeable issues in stability or memory
consumption.
 * Run with a vanilla 2.0.x OpenVPN client (multiple releases tested)

What it does not:
 * Respect general queries
 * Handle TUN-VPN
 * Handle IGMPv3 (at least probably not, it does in theory, but without
_any_ testing performed)
 * Pretty much anything else

I do not recommend this for inclusion into OpenVPN, since it may very well
crash OpenVPN if ran in TUN-mode. This patch is strictly submitted for
anyone curious to notice.

A proper patch should be written taking gq:s and TUN into consideration from
start.

If you want to reply, ensure you do it with a cc to me, since I'm not on the
list.

Regards
/ Ulrik
