Date: Mon, 16 Feb 2026 15:33:56 +0100 (CET)
Message-Id: <202602161433.61GEXuOD067213@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260216123026.3310-1-gert@...1296...>
References: <20260216123026.3310-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: clang-format: Add missing
 InsertBraces: true
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

Yeah.  Interesting that this seems to be one the few things where
"not set" means "leave either formatting alone" - so, since the existing
code base was already clean wrt braces, nobody noticed... good catch.

Your patch has been applied to the master and release/2.7 branch
(the coding style is identical, so the formatting rules also need to be).

commit 344f13fcdfc159277e7ba7d28e23537d718e7cef (master)
commit 6edd5fee44fd0c2b1b338e90b329054db6313c90 (release/2.7)
Author: Frank Lichtenheld
Date:   Mon Feb 16 13:30:20 2026 +0100

     clang-format: Add missing InsertBraces: true

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1529
     Message-Id: <20260216123026.3310-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35635.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


