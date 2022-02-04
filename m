Date: Fri, 4 Feb 2022 12:15:39 +0100 (CET)
Message-Id: <202202041115.214BFdmX005790@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220203193655.28791-1-a@...2181...>
References: <20220203193655.28791-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: move validation logic
 from cipher_get to cipher_valid
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

Basic client test works, quick glance looks reasonable.

Your patch has been applied to the master branch.

commit 2d822550ad990fbd498523fb1ab62ca19b3bb93c
Author: Antonio Quartulli
Date:   Thu Feb 3 20:36:54 2022 +0100

     crypto: move validation logic from cipher_get to cipher_valid

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20220203193655.28791-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23713.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


