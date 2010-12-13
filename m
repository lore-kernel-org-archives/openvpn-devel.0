MIME-Version: 1.0
Date: Mon, 13 Dec 2010 15:16:52 -0800
Message-ID: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Subject: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
  If my openvpn plugin spawns its own thread and from that thread
wants to kill a tunnel specified by IP:port how can that be done?
(something like what the 'telnet' management provides: "kill IP:port")
This plugin is meant to do other stuff and in certain scenarios wants
to close specific tunnels.
First I thought of using the plugin to write code to establish a
telnet-client sessions and send over "kill IP:port" command. But I
notice an issue with the management listener: if I run more than 1
telnet session only the first one can pass through data whereas all
others' telnet sessions just hang.

Is this even possible?

Vineet

