Date: Thu, 23 Jun 2022 15:34:26 +0200 (CEST)
Message-Id: <202206231334.25NDYQ30022342@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220524091916.145-1-lstipakov@...277...>
References: <20220524091916.145-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set o->use_peer_id flag for p2p
 mode
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is p2p NCP, which is all new in 2.6(-to-be) - and needed for DCO.

I have not tested this more than "it compiles", but Lev and Antonio have.

Your patch has been applied to the master branch.

commit 0d46c4963ae47581eadd94dbd2190c66086b9ecb
Author: Lev Stipakov
Date:   Tue May 24 12:19:16 2022 +0300

     Set o->use_peer_id flag for p2p mode

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220524091916.145-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24430.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


