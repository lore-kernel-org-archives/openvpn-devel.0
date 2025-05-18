Date: Sun, 18 May 2025 19:27:09 +0200 (CEST)
Message-Id: <202505181727.54IHR9nk040213@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250518172329.21239-1-gert@...1296...>
References: <20250518172329.21239-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Explicit-exit-notify and
 multisocket interaction
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

Does the job :-) - back to 2.6 level wrt "ctrl-c and EEN".

The whole event loop looks a bit unsatisfying, though, with checking
the signals twice in such a short loop... but I guess this needs much
deeper digging.

Your patch has been applied to the master branch.

commit 565d7cf48120d4394258fc3f2aa1b710315cd4e9
Author: Gianmarco De Gregori
Date:   Sun May 18 19:23:23 2025 +0200

     Explicit-exit-notify and multisocket interaction

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250518172329.21239-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31688.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


