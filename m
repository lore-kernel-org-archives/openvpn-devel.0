From: Vladimir Kamarzin <vvk@...1868...>
In-Reply-To: <1393929449-423915-1-git-send-email-vvk@...1868...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
MIME-Version: 1.0
Message-Id: <12561393929895@...1869...>
Date: Tue, 04 Mar 2014 16:44:55 +0600
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Tested on versions 2.2 and 2.3, patch applies to git master branch. I'm not sure this functionality should be wrapped with #ifdef.

Waiting for comments and your opinion regarding this change.

