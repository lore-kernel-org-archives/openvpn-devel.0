Date: Tue, 24 May 2022 09:45:22 +0200 (CEST)
Message-Id: <202205240745.24O7jMoB081153@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220523091724.3418887-1-arne@...1227...>
References: <20220523091724.3418887-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix client-pending-auth error
 message to say ERROR instead of SUCCESS
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

"paramter" adjusted as suggested. SOB added.

Your patch has been applied to the master and release/2.5 branch.

commit d681e9d42e11b08668fae6e7b61d6a040c93082d (master)
commit 5288c578b8b45dc1486bd51811a3e4462a8a9597 (release/2.5)
Author: Arne Schwabe
Date:   Mon May 23 11:17:24 2022 +0200

     Fix client-pending-auth error message to say ERROR instead of SUCCESS

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220523091724.3418887-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24421.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


