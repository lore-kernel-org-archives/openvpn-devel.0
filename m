From: "Robin G. Wenninger" <grw@...152...>
Message-ID: <20040907225456.GA2638@...152...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Connect several subnets with OpenVPN2.0
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
Date: Tue Sep  7 15:56:04 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi list,

I have a kind of "problem" here.

I thought about connecting several subnets with 2.0 and for this purpose
use the PUSH/PULL-Options.

So I used options like
	push "route 10.0.0.0 255.255.255.0"
	push "route 192.168.1.0 255.255.255.0"

To push all known subnets to the Clients. But the problem is, if I push
route 10.0.0.0 255.255.255.0 to the Client which "owns" this subnet it
overwrites the old routing entry and kicks its Subnet.

My recommendation would be a kind of exception list.
Something like
	push "route 10.0.0.0 255.255.255.0" except common-name

What do you think about this, is there any other (good to administrate)
solution?

Kind regards,
	Robin Wenninger

P.S. (Right me when I'm wrong.)

