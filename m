Date: Fri, 5 Oct 2018 16:39:36 +0200 (CEST)
Message-Id: <201810051439.w95Eda88043704@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181005135849.28718-1-steffan@...1856...>
References: <20181005135849.28718-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix --disable-crypto build
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

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Makes sense, and passes the test (Linux with --disable-crypto)

Your patch has been applied to the release/2.4 branch.

commit ee80ce3d6f2ebc59068338757311e0488ae620fc
Author: Steffan Karger
Date:   Fri Oct 5 15:58:49 2018 +0200

     Fix --disable-crypto build

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20181005135849.28718-1-steffan@...1856...>
     URL: https://www.mail-archive.com/search?l=mid&q=20181005135849.28718-1-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


