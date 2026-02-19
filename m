Date: Thu, 19 Feb 2026 16:51:29 +0100 (CET)
Message-Id: <202602191551.61JFpTHb035930@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260219110954.21471-1-gert@...1296...>
References: <20260219110954.21471-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: DCO Linux: Fix setting DCO
 ifmode failing on big endian archs
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

Interesting catch, this :-) - I have tested this for "master" and "release/2.6"
on a regular Intel system, just to be sure there was no accidential breakage
on the other endiannes... (things still work).

Your patch has been applied to the master, release/2.7 and release/2.6 branch
(in 2.6, the "SITNL_ADDATTR()" line is wrapped differently, pre-clang-format
formatting, but that was trivially adjusted)

commit b3e0e8696b162794beefc22aad7406b328471cf6 (master)
commit 1c9f9bfa5c1f5e23036b1ffab683d926cd4c1aef (release/2.7)
commit a2037b264169530e7e6ee22007587369becec4be (release/2.6)
Author: Arne Schwabe
Date:   Thu Feb 19 12:09:48 2026 +0100

     DCO Linux: Fix setting DCO ifmode failing on big endian archs

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1547
     Message-Id: <20260219110954.21471-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35752.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


