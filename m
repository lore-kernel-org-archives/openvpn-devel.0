Date: Tue, 21 Feb 2017 16:37:32 +0100 (CET)
Message-Id: <201702211537.v1LFbW0M023539@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170119162518.31752-1-a@...2181...>
References: <20170119162518.31752-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix redirect-gateway behaviour
	when an IPv4 default route does not exist
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Verified the problematic behaviour (connected from a FreeBSD 11 system
without an IPv4 default route to a v6-transport VPN server, and it refused
"redirect-gateway", with or without "def1") - and with the patch, it does
the expected thing.

Also, stared at the code :-)

Your patch has been applied to the master and release/2.4 branch.

commit 14670a9d654be48f92b58ac47e6f74d3dcfe1733 (master)
commit 5340f56b62c9fe7ad892e815029321f378660714 (release/2.4)
Author: Antonio Quartulli
Date:   Fri Jan 20 00:25:18 2017 +0800

     fix redirect-gateway behaviour when an IPv4 default route does not exist

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170119162518.31752-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13905.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


