Date: Mon, 15 Sep 2025 09:01:26 +0200 (CEST)
Message-Id: <202509150701.58F71Qtw026203@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250915062013.2555-1-gert@...1296...>
References: <20250915062013.2555-1-gert@...1296...>
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

Tested on Win11 22H4 ("brand new install") which does not bring a wmic.exe
binary - with 2.6.14 out of the box, setting the DNS domain for the 
interface does no longer work with DCO, and a wmic error is logged in
the event log (see issue #842).  With this patch applied, setting the
domain works again.  Heiko also tested this with iservice and privileged
openvpn.exe calls.

DHCP on TAP is never affected, because in that case everything is sent
to windows "using DHCP", but of course we need DCO to function.

Under normal conditions we'd not change something like this at the end
of a release lifespan (2.6.14 -> 2.6.15, with 2.7.0 very close) - but
we'll see usage of 2.6.x versions for a long time, and with Microsoft
breaking functionality behind our backs, what shall we do...

This change affects windows only.

Your patch has been applied to the release/2.6 branch.

commit d383d6ed6270b8d1f95716d08e9da3dd0d712f2d (release/2.6)
Author: Lev Stipakov
Date:   Mon Sep 15 08:20:06 2025 +0200
     win: replace wmic invocation with powershell

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1183
     Message-Id: <20250915062013.2555-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32938.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


