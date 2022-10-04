Date: Tue, 4 Oct 2022 18:43:47 +0200 (CEST)
Message-Id: <202210041643.294GhlTL003657@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221004145142.19091-1-gert@...1296...>
References: <20221004145142.19091-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: use boolean '||' to join two
 bools, not bitwise '|'
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

For sanity reasons, tested on the oldest system I have around
(FreeBSD 7.4).  No complaints (none expected).

Patch has been applied to the master branch.

commit facb6fffb35f51e67eefaab8ba357b676b3c6328
Author: Gert Doering
Date:   Tue Oct 4 16:51:42 2022 +0200

     use boolean '||' to join two bools, not bitwise '|'

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20221004145142.19091-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25333.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


