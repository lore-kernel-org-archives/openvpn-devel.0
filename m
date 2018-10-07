Date: Sun, 7 Oct 2018 10:00:46 +0200 (CEST)
Message-Id: <201810070800.w9780kNF086885@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180413155517.895-1-simon@...2293...>
References: <20180413155517.895-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change quoted to angled form
 when #including external .h files
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because that's what C recommends" - local header files get "myext.h"
while system files get <sysext.h>

Your patch has been applied to the master branch.

commit 3b7c7858dddc0ddd492acb9d1316e2dd42a807bf
Author: Simon Rozman
Date:   Fri Apr 13 17:55:17 2018 +0200

     Change quoted to angled form when #including external .h files

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180413155517.895-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16760.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


