Date: Mon, 15 Dec 2025 16:35:47 +0100 (CET)
Message-Id: <202512151535.5BFFZlso058834@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251215150500.18898-1-gert@...1296...>
References: <20251215150500.18898-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Fix wrong sigma value in
 multi_push_restart_schedule_exit
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Indeed, the original code looks wrong here, according to the new 
documentation just added :-) - interesting functions we have there.

Stared-at-code, not tested beyond "BB says it's all green".

Your patch has been applied to the master branch.

commit 310c6b9e789a102b71ad9d4ba56bc11d1c8a0a73
Author: Frank Lichtenheld
Date:   Mon Dec 15 16:04:54 2025 +0100

     multi: Fix wrong sigma value in multi_push_restart_schedule_exit

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1311
     Message-Id: <20251215150500.18898-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35075.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


