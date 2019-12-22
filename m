Date: Sun, 22 Dec 2019 20:09:30 +0100 (CET)
Message-Id: <201912221909.xBMJ9U6X088292@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191220193805.34-1-simon@...2293...>
References: <20191220193805.34-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: register ring buffers
 when iterating adapters
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

Your patch has been applied to the master branch.

Compile tested on Ubuntu 1604/mingw.  Lightly stared at the code.  

Explanation makes sense (but I have not looked hard enough to see if
it actually does what it says :) ).

commit c1a555585c90aa26390ef2f50cadd479b47541f2
Author: Simon Rozman
Date:   Fri Dec 20 20:38:05 2019 +0100

     wintun: register ring buffers when iterating adapters

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20191220193805.34-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19288.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


