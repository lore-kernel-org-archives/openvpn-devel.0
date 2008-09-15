Message-ID: <48CDF70A.8000909@...1114...>
Date: Mon, 15 Sep 2008 07:47:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc9 - environment variable dissappeared?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


I'm writing a plugin for OpenVPN in C, and I'm collecting some information for statistic usage.
After upgrading to OpenVPN 2.1_rc9, I discovered that the proto environment variable is not
available anymore ... Is this correct?  Was this planned or is it a bug?  I've been trying 2.1_rc7
and 2.0.9, but I don't recall now if it also disappeared in 2.1_rc7.

All I need to know is if this was planned or not.  If it was planned, I will not try to collect the
protocol used anymore.



kind regards,

David Sommerseth

