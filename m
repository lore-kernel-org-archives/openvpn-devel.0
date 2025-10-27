Date: Mon, 27 Oct 2025 11:01:53 +0100 (CET)
Message-Id: <202510271001.59RA1r1d044649@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251026143521.13291-1-gert@...1296...>
References: <20251026143521.13291-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_mbedtls: fix missing
 perf_pop() call
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

While this is sort-of a NOP in 2.6, at least it's a consistent NOP now :-)

Your patch has been applied to the release/2.6 branch.

commit e83c63f58135913bb2ca2f4345da8cd77098474b
Author: Steffan Karger
Date:   Sun Oct 26 15:35:14 2025 +0100

     ssl_mbedtls: fix missing perf_pop() call

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1305
     Message-Id: <20251026143521.13291-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33870.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


