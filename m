Date: Fri, 17 Jul 2020 14:21:46 +0200 (CEST)
Message-Id: <202007171221.06HCLkxv010745@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200716134315.17742-1-arne@...1227...>
References: <20200716134315.17742-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

Your patch has been applied to the master branch.

Tested on the test rig, stared-at-code by antonio, and commit-message-adjusted
by me :-) (a few "defferred" and integrating the new call convention)

commit dfb40edc4acae5f17b0062ecb13ad1fa760ed529
Author: Arne Schwabe
Date:   Thu Jul 16 15:43:10 2020 +0200

     client-connect: Add CC_RET_DEFERRED and cope with deferred client-connect

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200716134315.17742-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20395.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


