Date: Sat, 24 Dec 2022 22:47:42 +0100 (CET)
Message-Id: <202212242147.2BOLlgT8008003@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-2-arne@...1227...>
References: <20221224194253.3202231-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename TM_UNTRUSTED to
 TM_INITIAL
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

Acked-by: Gert Doering <gert@...1296...>

This is trivial renaming, and makes sense together with 2/9.

I will also squash these two, because this alone does not compile...
(one TM_UNTRUSTED in ssl.c survived The Great Rename).

Your patch will been applied to the master & release/2.6 branch,
together with 2/9, if 2/9 passes stare-at-code and review.

commit eecf9ee30f27b34533fde963b256176829cfffcf (to be squashed)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:45 2022 +0100

     Rename TM_UNTRUSTED to TM_INITIAL

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


