Date: Fri, 11 Sep 2020 18:25:03 +0200 (CEST)
Message-Id: <202009111625.08BGP33J064177@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200911154259.13837-1-davids@...515...>
References: <20200911154259.13837-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: man: Add missing --server-ipv6
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks :)

I have removed one line
 
  +  This is only accepted if ``--mode server`` or ``--server`` is set.

as this is no longer correct after merging of Antonio's ipv6-only
patch set (but the corresponding doc change might have gotten lost in
between).

Your patch has been applied to the master and release/2.5 branch.

commit 8120e1ad4f20d4ec1fa9e191f3b15740c4aec448 (master)
commit a4c03b46b24f952489a6ad19a434f2dff13d1276 (release/2.5)
Author: David Sommerseth
Date:   Fri Sep 11 17:42:59 2020 +0200

     man: Add missing --server-ipv6

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200911154259.13837-1-davids@...515...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200911154259.13837-1-davids@...515...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


