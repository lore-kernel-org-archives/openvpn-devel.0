Message-ID: <a6589cd60410221425748baad@...278...>
From: Hans Fugal <fugalh@...277...>
Reply-To: Hans Fugal <fugalh@...277...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Foolproof rollout
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
Date: Fri Oct 22 14:27:43 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm new to openvpn, coming from a PPTP and IPsec background. I like
what I see. We have been having trouble with connectivity on our IPsec
(netscreen appliance and netscreen remote (safenet) software on the
roadwarrior computers), and we're looking at moving to OpenVPN, at
least for the people that have connectivity issues.

The problem is that some of these people are not computer savvy by any
definition of the word, and as it stands openvpn requires too much
configuration - there are too many places they can jump off into the
deep end.

The ideal situation would be something like this use case: The user
gets an email from me saying something like: "Run the attached
installer, reboot, and double click the new VPN icon on your desktop."

I believe this is possible, and this is how I see it working. I create
and sign the certificate and the config file (which doesn't change
from user to user). I run a script or make target that creates a
custom installer that has the certificate, key, and config file and
will put them in the right place (that part's easy), set up a shortcut
that will start the vpn (not too hard), and configure the network
settings (DNS for example - this might not be necessary if we use dhcp
over tap).

I intend to do this, if there aren't hidden demons that make it
unfeasible, and if someone else hasn't already done it or isn't
already doing it. Would this be something that would fit as part of
openvpn itself, or would it be better to do it as a separate project
and/or patch? Do you have any pointers on where to start?

-- 
De gustibus non disputandum est.

