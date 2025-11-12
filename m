Date: Wed, 12 Nov 2025 11:37:51 +0100 (CET)
Message-Id: <202511121037.5ACAbpaI035419@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251112092216.22703-1-gert@...1296...>
References: <20251112092216.22703-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: remove checks for
 PATHCCH_ENSURE_TRAILING_SLASH
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

Yeah, that looks a bit silly in retrospective... adding it for Cmake,
fixing it for autoconf, and then ripping it out again... but in the end,
the code is nicer this way, and we all learn on the journey ;-)

Sanity compiled on ubuntu 24.04 / mingw.

Your patch has been applied to the master branch.

commit 763160a16a8910d039cdb2359b10ec61b8041e4b
Author: Heiko Hund
Date:   Wed Nov 12 10:22:10 2025 +0100

     win: remove checks for PATHCCH_ENSURE_TRAILING_SLASH

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1354
     Message-Id: <20251112092216.22703-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34335.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


