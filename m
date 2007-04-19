Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <A06302D8-1633-4FCB-A8EE-8EC6A58FF3F3@...1018...>
From: Dave Cramer <davec@...1018...>
Date: Thu, 19 Apr 2007 08:51:39 -0400
Subject: [Openvpn-devel] learn address problems with chroot, or userid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The only way I can get learn-address script to work is by running  
openvpn as root

Ideally I'd like to create an openvpn user, and chroot to / 
openvpnprivate/

then run

learn-address /script

However when I tried this I get "cannot execute cmd"  error

So is this driver error , or a bug ?

Dave



