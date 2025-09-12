Date: Fri, 12 Sep 2025 17:23:55 +0200 (CEST)
Message-Id: <202509121523.58CFNtBF095109@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250912131207.42597-1-frank@...2641...>
References: <20250912131207.42597-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Multi-socket win: avoid
 repeated socket_set()
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

I can't claim I understand what exactly upsets what here, but since
Gianmarco is the "multi event expert" and Lev has confirmed that this
fixes the observed windows issues, *and* there is now a comment that
explains to casual readers what this is about, good enough for me :-)
(plus the CI infra agrees that things still work).

Again, mail-archive.org claims this was never sent to the list, so
linking to sf.net archive & our gerrit.

Your patch has been applied to the master branch.

commit 3b429925fb9b4a822facc6ea9f13b927b6021944
Author: Gianmarco De Gregori
Date:   Fri Sep 12 15:12:07 2025 +0200

     Multi-socket win: avoid repeated socket_set()

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250912131207.42597-1-frank@...2641...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59232443/
     URL: https://gerrit.openvpn.net/c/openvpn/+/1174
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


