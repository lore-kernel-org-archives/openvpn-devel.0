Date: Sat, 17 Apr 2021 10:44:49 +0200 (CEST)
Message-Id: <202104170844.13H8in0A079591@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210408120029.19438-2-arne@...1227...>
References: <20210408120029.19438-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Also restore/save compress
 related options in reconnects
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

Stared-at-code (looks good), client side tested with the usual parcours
(good), and also tested with my two known-weird/broken test cases 
for "compress not restored" (fixed!).

Your patch has been applied to the master branch.

I tried to apply it to release/2.5, but the resulting binary did not
behave - I can see that it restored the comp settings, but it does so
*after* OCC handshake (so the OCC warning is still there) *and* it does
not re-init compression - so the case "config has comp-lzo, server A
pushes compress lz4, server B pushes nothing" (so it should do LZO)
still fails.  I think I need one of the other patches that changes
the "when are options saved/restored" as prerequisite here.

Will come back...

commit 2a414c3c79bba089183a517a2d355b5aaae0b4a4 (master)
Author: Arne Schwabe
Date:   Thu Apr 8 14:00:28 2021 +0200

     Also restore/save compress related options in reconnects

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210408120029.19438-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22078.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


