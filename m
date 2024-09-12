Date: Thu, 12 Sep 2024 19:19:30 +0200 (CEST)
Message-Id: <202409121719.48CHJUNs029658@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240912165339.21058-1-gert@...1296...>
References: <20240912165339.21058-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: mark peer as deleted from
 kernel after receiving CMD_DEL_PEER notification
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Trivial enough, and makes sense... not tested further (not that easy
to reproduce).

Your patch has been applied to the master branch.

commit 45bef145f3cc39c4c13609866f07b6cf9f8960a6
Author: Antonio Quartulli
Date:   Thu Sep 12 18:53:39 2024 +0200

     dco: mark peer as deleted from kernel after receiving CMD_DEL_PEER notification

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240912165339.21058-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29226.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


