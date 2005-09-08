From: Charles Duffy <cduffy@...294...>
Message-ID: <dfq2em$c3b$1@...165...>
References: <Pine.LNX.4.58.0509062125110.12112@...41...> <432012B6.9080104@...177...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] New subnet topology feature ready for testing
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
Date: Thu Sep  8 12:17:07 2005
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

Farkas Levente wrote:

> i always like to know my vpn enpoint has a static ip address so if i'd
> like to access joe's vpn i can simply use joe.vpn.company.com name.

This doesn't require a static address. I've posted a script to OpenVPN-users
for dynamically updating a DNS server when called by the learn-address
hook.


