Date: Sat, 21 Dec 2024 16:29:16 +0100 (CET)
Message-Id: <202412211529.4BLFTGIr033226@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241213164630.266045-1-frank@...2641...>
References: <20241213164630.266045-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: clone options via pointer
 instead of copy
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

It's not immediately obvious to me why this is a useful change (except
"do not copy structs around if not needed"), but the actual change looks
good and should not change operational behaviour in any way - no memory
handling or anything involved, just "the midlayer" function referencing
structure elements via pointer now.

Compile tested :-)

Your patch has been applied to the master branch.

commit db46d4d38bec59435a76bb0968d530b9426c551e
Author: Heiko Hund
Date:   Fri Dec 13 17:46:30 2024 +0100

     dns: clone options via pointer instead of copy

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20241213164630.266045-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30112.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


