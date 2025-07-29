Date: Tue, 29 Jul 2025 15:34:28 +0200 (CEST)
Message-Id: <202507291334.56TDYS4L001313@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250729104056.27634-1-gert@...1296...>
References: <20250729104056.27634-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE: Added
 remove_option() and do_update().
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

As for the previous patch, this had quite a journey...

+2 from Lev on v12, then rebases up to v21, stylistic discussions with
me (and "please add comments so we can remember in two months why this
extra check needs to be done" ;-) ), to be integrated into v22, +2'ed
again, and v23 another rebase... so recording my +2 as "Acked-by:".

Lev has tested this and confirms the new stuff (808+809+810) works.

I have stared long and hard at the code, and run the client/server side
testbeds on it, and nothing breaks.  I have not tested the PUSH_UPDATE
machinery yet  (the t_client tests do excercise the change to split
delete_routes(), but that's trivial enough)


Your patch has been applied to the master branch.

commit 73f3247e89bd66fa0b5142e3e1773951f6c3cba0
Author: Marco Baffo
Date:   Tue Jul 29 12:40:50 2025 +0200

     PUSH_UPDATE: Added remove_option() and do_update().

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250729104056.27634-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32407.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


