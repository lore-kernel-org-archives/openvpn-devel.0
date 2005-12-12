From: Till Maas <opensource@...519...>
Message-id: <200512130015.39902.opensource@...519...>
MIME-version: 1.0
Subject: [Openvpn-devel] BUG --daemon & --auth-retry interact: openvpn won't daemonize after
 interaction
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
Date: Mon Dec 12 15:16:06 2005
Content-type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hiyas,

when I start openvpn 2.0.5 (debian unstable) with --daemon --auth-retry 
interact it won't daemonize when I provide the correct password after the 
second password prompt. If I enter the right password the first time it does.

I would really appreciate it when you fix this and thank you for developing 
openvpn.

Regards,
Till



