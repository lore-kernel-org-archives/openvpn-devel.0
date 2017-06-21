Date: Wed, 21 Jun 2017 12:07:17 +0200 (CEST)
Message-Id: <201706211007.v5LA7HSB073905@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170613200832.15027-1-gert@...1296...>
References: <20170613200832.15027-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix remotely-triggerable
 ASSERT() on malformed IPv6 packet.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master, release/2.4 and release/2.3 branch.

commit c3f47077a7756de5929094569421a95aa66f2022 (master)
commit ed28cde3d8bf3f1459b2f42f0e27d64801009f92 (release/2.4)
commit fc61d1bda112ffc669dbde961fab19f60b3c7439 (release/2.3)
Author: Gert Doering
Date:   Tue Jun 13 22:08:32 2017 +0200

     Fix remotely-triggerable ASSERT() on malformed IPv6 packet.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170613200832.15027-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20170613200832.15027-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


