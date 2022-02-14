Date: Mon, 14 Feb 2022 18:54:10 +0100 (CET)
Message-Id: <202202141754.21EHsAxG022064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220214092607.3785665-1-arne@...1227...>
References: <20220214092607.3785665-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove FRAME_HEADROOM,
 PAYLOAD_SIZE, EXTRA_FRAME and TUN_LINK_DELTA macros
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

Logical consequence of making the frame structure much simpler.  Now all
the old macros are gone, and with the underlying variables being "simple",
no more macros needed.

Stared at the code change ("is this really the straightforward change
in each case"), ran client + server side tests for good measure.

Your patch has been applied to the master branch.

commit d2e6605fec0d8641deef0ec7807811d0222bb71e
Author: Arne Schwabe
Date:   Mon Feb 14 10:26:07 2022 +0100

     Remove FRAME_HEADROOM, PAYLOAD_SIZE, EXTRA_FRAME and TUN_LINK_DELTA macros

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220214092607.3785665-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23785.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


