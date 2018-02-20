Date: Tue, 20 Feb 2018 13:23:56 +0100 (CET)
Message-Id: <201802201223.w1KCNueS066894@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1511026858-23281-2-git-send-email-selva.nair@...277...>
References: <1511026858-23281-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make most registry values
 optional
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense".  Stared at the code, compile-tested on 16.04.

Same issue as in 1/2 with the "reg_path" change...  but again, only
conflicts in context, not actual code, and context that is not affected 
by the code changes.

Your patch has been applied to the master and release/2.4 branch.

commit db04bca6729e9fe1ea60f0b3bd0329244a6ed611 (master)
commit c07bdace820753ab29def5edc3a6cadbf233cd03 (release/2.4)
Author: Selva Nair
Date:   Sat Nov 18 12:40:58 2017 -0500

     Make most registry values optional

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1511026858-23281-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15892.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


