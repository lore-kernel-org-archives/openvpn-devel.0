Date: Sat, 28 Aug 2021 15:40:10 +0200 (CEST)
Message-Id: <202108281340.17SDeApA033569@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210826061725.22169-1-a@...2181...>
References: <20210826061725.22169-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: pass the right
 parameter to IN6_IS_ADDR_UNSPECIFIED
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond "openvpn --show-gateway", and that one
still works :-) - also, we've discussed this on IRC before.

Your patch has been applied to the master and release/2.5 branch (bugfix).

2.4 does not contain the offending code.

commit aa0e44e235f7bee0e12707b6899d00bad85195fc (master)
commit 477781335cbca1aec69a372cbc18bf086155eea1 (release/2.5)
Author: Antonio Quartulli
Date:   Thu Aug 26 08:17:25 2021 +0200

     route.c: pass the right parameter to IN6_IS_ADDR_UNSPECIFIED

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20210826061725.22169-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22767.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


