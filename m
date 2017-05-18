Date: Thu, 18 May 2017 19:40:43 +0200 (CEST)
Message-Id: <201705181740.v4IHeh5I089532@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170509152422.12606-1-a@...2181...>
References: <20170509152422.12606-1-a@...2181...>
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

ACK, thanks.

For reference, this is the same patch as 14670a9d654b in master, just
adapted to the different code style in 2.3.  Tested on FreeBSD 11.

Your patch has been applied to the release/2.3 branch.

commit 0b339bf9588a8bca70b74926f03f8be05f06faa6
Author: Antonio Quartulli
Date:   Tue May 9 23:24:22 2017 +0800

     fix redirect-gateway behaviour when an IPv4 default route does not exist

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170509152422.12606-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14602.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


