Date: Thu, 17 Sep 2020 10:45:56 +0200 (CEST)
Message-Id: <202009170845.08H8juQs054283@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200916141755.1923-1-themiron@...2010...>
References: <20200916141755.1923-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix fatal error at switching
 remotes (#629)
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.5 and release/2.4 branch
(bugfix).

I have fixed a few "addinfo" occurances and re-wrapped the comment 
slightly.  Not checked the actual code, just ran a t_client test on
2.4 "to be sure".

As Arne wrote there is a "fix for real" dangling here... :-)

commit 3ad86c2534a92af137809b6d446d570193e6d01f (master)
commit 6554025a422d3d7e5465bcbfad34fa3e196b53b0 (release/2.5)
commit 7fdcd286a15fb4f64e979c4fdbf52223d4bdede0 (release/2.4)
Author: Vladislav Grishenko
Date:   Wed Sep 16 19:17:55 2020 +0500

     Fix fatal error at switching remotes (#629)

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200916141755.1923-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21019.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


