Date: Fri, 14 Feb 2025 17:03:26 +0100 (CET)
Message-Id: <202502141603.51EG3Qn3011584@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250214153434.18539-1-gert@...1296...>
References: <20250214153434.18539-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway(): Prevent
 passing IPV4_INVALID_ADDR as a destination
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

There has been quite a bit of discussion about this one-liner on
#openvpn-devel - this is not a particularily pretty piece of code, nor
easy to understand.  It's intended as a "do not break existing setups"
bandaid, while we spend more thoughts on making this work better, and
also clarify for ourselves and the documentation what "default gateway"
and "route ... net_gateway" really means :-) - and possibly drop
"non def1" redirection, which will simplify more of this.

Thanks for looking into this :-)

Your patch has been applied to the master branch.

commit 75ba07d496da269b13fc368311f8a063b65d58e7
Author: Marco Baffo
Date:   Fri Feb 14 16:34:34 2025 +0100

     get_default_gateway(): Prevent passing IPV4_INVALID_ADDR as a destination

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250214153434.18539-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30895.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


