Date: Wed, 1 Apr 2020 15:23:49 +0200 (CEST)
Message-Id: <202004011323.031DNnMu090098@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200314125801.1031-1-simon@...2293...>
References: <20200314125801.1031-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun.c: revise the IPv4 ifconfig
 flow on Windows
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I had to slightly massage the hunk at tun.c:6413 because the context
had been changed (&gc introduction).  The actual code change is the same.

Test compiled on MinGW.

commit 09ae628027493959c733ba07c7d018c04465052c
Author: Simon Rozman
Date:   Sat Mar 14 13:58:01 2020 +0100

     tun.c: revise the IPv4 ifconfig flow on Windows

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200314125801.1031-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19560.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


