Date: Thu, 14 Jul 2022 20:20:18 +0200 (CEST)
Message-Id: <202207141820.26EIKI5p024154@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220712221655.19333-1-a@...2181...>
References: <20220712221655.19333-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: create tun_name_is_fixed
 helper
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

Acked-by: Gert Doering <gert@...1296...>

Trivial enough, and confirmed that it does not break anything.

(Having the "has_digit()" in buffer.*h* when it is only ever called
from tun.c smells like "we might eventually include this in 
tun_name_is_fixed() and get rid of the inline helper" - but this is
a patch for another day.  Also, we might do it the other way round,
"everything that is not exactly 'tun', 'tap' or 'null' is considered 
fixed" - this whole open_tun() thing is a hairy mess of historic insanity).

Your patch has been applied to the master branch.

commit 4a88d2fbe73a64f8f3861089a2b6e3b8e583e71b
Author: Antonio Quartulli
Date:   Wed Jul 13 00:16:55 2022 +0200

     tun: create tun_name_is_fixed helper

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220712221655.19333-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24676.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


