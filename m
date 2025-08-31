Date: Sun, 31 Aug 2025 18:50:39 +0200 (CEST)
Message-Id: <202508311650.57VGod8K074488@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250831151259.25788-1-gert@...1296...>
References: <20250831151259.25788-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket_util: Clean up
 conversion warnings in add_in6_addr
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

The patch itself is straight forward, but having a unit test for all
the possible overflows is very welcome - "it will test itself, across
all platforms".  BB is all green, local test on Linux also passes.

Your patch has been applied to the master branch.

commit 84ef4848e7c7325759c67a1bfee231e13efe9f89
Author: Frank Lichtenheld
Date:   Sun Aug 31 17:12:52 2025 +0200

     socket_util: Clean up conversion warnings in add_in6_addr

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250831151259.25788-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32725.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


