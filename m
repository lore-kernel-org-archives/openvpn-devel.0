Date: Mon, 22 Jul 2019 20:44:17 +0200 (CEST)
Message-Id: <201907221844.x6MIiHtw009666@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1548101094-4449-1-git-send-email-lstipakov@...277...>
References: <1548101094-4449-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix broken fragment/mssfix with
 NCP
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

Your patch has been applied to the master branch.

I have not tried to understand the actual change, but the general
explanation makes sense and with two ACKs already... I did run t_client
tests, though :-)  (and there is a fragment test).

I did try to apply it to 2.4, because it's a bugfix (so "can I have it
for release/2.4, please!") and while it *applied* fine, it did not 
compile :-( - the function signature for crypto_adjust_frame_parameters() 
is different in 2.4 - "use_iv" still exists.  Can you have a look, 
please, and send a 2.4 version?

commit d22ba6b2c551fa83d23b5cf668e08a08fde446bc (master)
Author: Lev Stipakov
Date:   Mon Jan 21 22:04:54 2019 +0200

     Fix broken fragment/mssfix with NCP

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1548101094-4449-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18135.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


