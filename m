From: "James Yonan" <jim@...41...>
Message-ID: <twig.1062740798.74062@...41...>
Subject: [Openvpn-devel] New feature proposal:  --route option
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Sep  4 22:48:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

I would like to implement a --route option that will be a proxy for the route
command, similar to the way that the --ifconfig option is a proxy for the
ifconfig command.

The goal would be to present a kind of least-common-denominator route
functionality which is basic enough to be portable across OpenVPN's platform
space.

I'm thinking of a syntax such as

  --route network netmask gateway

I'm looking for a syntax that will cover basic routing -- for more advanced
usage, one can always write a script.

The overall goal is to simplify configuration by getting the common operations
out of --up scripts and into the OpenVPN config file where they will be
portable and easier to support.

Comments?

James


