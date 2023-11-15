Date: Wed, 15 Nov 2023 16:14:20 +0100 (CET)
Message-Id: <202311151514.3AFFEKx2000770@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231115120656.6825-1-gert@...1296...>
References: <20231115120656.6825-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn if pushed options require
 DHCP
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

The patch looks reasonable so far.  Haven't tested it, just test compiled
with GHA.

Looking forward to the day we can get rid of --ip-win32, and simplify
all these messages having '"%s ...", prefix' in them.

I have taken the liberty of wrapping the open_tun() line - "80-110 chars"
is our limit, not "155".

Your patch has been applied to the master branch.

commit 85fc834b0229b87e466b4f60bd2618b2ecd27a5f (master)
commit 6127858f302785fa81cb9b943a71af972531070c (release/2.6)
Author: Lev Stipakov
Date:   Wed Nov 15 13:06:56 2023 +0100

     Warn if pushed options require DHCP

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231115120656.6825-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27403.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


