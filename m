Date: Sat, 9 Nov 2024 11:42:50 +0100 (CET)
Message-Id: <202411091042.4A9AgopL065821@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241108173851.436-1-gert@...1296...>
References: <20241108173851.436-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for compression
 on send
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

Looked at the code, tested on server and client testbeds and GHA, 
everything seems to work as before :-) - I put my ACK on v6, but
the real review was done by Arne in v5, so recording both ACKs
(v5->v6 is documentation changes only).

I have not tested all variants of building with --disable-lzo or
--disable-lz4, but from looking at the code and the BB results, I do
not expect surprises from that side.

Your patch has been applied to the master branch.

commit 7f0214c9e2ca2991bd8affd5754bf9286b904bf7
Author: Frank Lichtenheld
Date:   Fri Nov 8 18:38:51 2024 +0100

     Remove support for compression on send

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241108173851.436-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29718.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


