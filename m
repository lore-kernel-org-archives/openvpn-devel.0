Date: Mon, 15 Sep 2025 22:27:39 +0200 (CEST)
Message-Id: <202509152027.58FKRdRM052859@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250915130344.2906-1-gert@...1296...>
References: <20250915130344.2906-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: replace wmic invocation
 with powershell
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

This is exactly the same change (modulo some formatting differences)
as was applied to tun.c/win32.c in release/2.6 / commit d383d6e
(the iservice part is not needed in master/2.7 as the DNS stuff has been
fully rewritten).

So I did not re-test this, besides "does it compile with mingw" (and the
BBs are happy).

Your patch has been applied to the master branch.

commit 5681535b1927c339398196707b359a94786fd2c0
Author: Lev Stipakov
Date:   Mon Sep 15 15:03:38 2025 +0200

     win: replace wmic invocation with powershell

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1187
     Message-Id: <20250915130344.2906-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32951.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


