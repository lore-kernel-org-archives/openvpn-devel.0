Message-ID: <49EDBEAA.5000207@...1187...>
Date: Tue, 21 Apr 2009 14:40:10 +0200
From: Robert Fischer <rf@...1187...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Record source ip address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

We're using the "multihome" option for running one openvpn instance on 
multiple IP addresses.

In order to find out on which server IP address the client got 
connected, currently we check the logfile for the pattern:

Peer Connection Initiated with clientip:port (via serverip)

where serverip is the needed information.

It would be great if this information could be gathered from the openvpn 
status logfile or via management interface.

However, I suppose, adding that information would break some 
scripts/programs which rely on the current status logfile, respectively 
management interface field structure.

Are there any comments on this?

best regards,
Robert Fischer


