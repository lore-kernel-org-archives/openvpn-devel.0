content-class: urn:content-classes:message
MIME-Version: 1.0
Message-ID: <946499570EB7294690F512C1EF182F881EB899@...102...>
From: "Bert Shuler" <bshuler@...103...>
Subject: [Openvpn-devel] RE: [Openvpn-users] Windows tun driver
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
Date: Tue Sep 16 08:33:05 2003
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>, Inode <inode@...101...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

James:
Are you aware of a Windows tun project? While most windows users may
prefer tap, I am interested in the point-to-point nature of the tun
device. When setting up many routed connections, it seems that each TAP
connection will use 1 ip and waste 2 others. I can also live without
broadcast traffic and non-IP protocols.

_SNIP_

I think that Windows users are going to prefer a tap interface anyways,
because it carries the kind of traffic and protocols which Windows
applications generate, such as broadcast traffic and non-IP protocols.

James

