From: Philippe Lemesle <lemeslep@...260...>
Message-ID: <loom.20060208T222649-976@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Feature request : connect to non-SSL HTTP proxy
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
Date: Wed Feb  8 13:52:49 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello, all.

At work, the admins are so paranoid that the policy is to block all internet 
access to ensure security. 
The only way to go to the Internet is by the way of an HTTP-proxy which offers 
SSL functionnality.
The admins are aware the some employees use VPN over SSL. In fact, they are 
currently studying the option of cutting down SSL functionnality of the HTTP-
proxy.
So it's possible that in the near future I won't be able to use OpenVPN anymore.

I've studied alternative solutions and found a software called HTTHost (coupled 
with HTTPort for the client part). 
HTTHost is able to pass plain non-SSL HTTP-proxy via an option called "remote 
host".
But it's less flexible than OpenVPN because it only tunnels TCP connections and 
doesn't offer true VPN functionnality.

So, it would be really nice if someone could add a functionality to the --http-
proxy command so that we can connect to remote host through an non-SSL HTTP 
proxy.

Sincerely,

Philippe Lemesle
lemeslep@...260...






