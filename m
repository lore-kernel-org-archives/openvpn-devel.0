Date: Thu, 1 Apr 2021 15:41:52 +0200 (CEST)
Message-Id: <202104011341.131DfqL1084690@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-2-arne@...1227...>
References: <20210401131337.3684-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove code for aligning
 non-swapped compression
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

Acked-by: Gert Doering <gert@...1296...>

I was a bit worried about this breaking existing setups, and then
Arne remarked that "this is dead code anyway" - it is only compiled if
built with --disable-lz4, which we do for testing on some buildbots,
but not for production builds.  So, ripping out dead code is not going
to break anything.

Still, lightly client side tested on Linux.  With compression :)

Your patch has been applied to the master branch.

commit 137eb6705e57d3324fe45367419413e34a424976
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:24 2021 +0200

     Remove code for aligning non-swapped compression

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


