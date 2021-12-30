Date: Thu, 30 Dec 2021 12:35:27 +0100 (CET)
Message-Id: <202112301135.1BUBZRFB066221@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211229163445.1893687-1-arne@...1227...>
References: <20211229163445.1893687-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add helper functions to
 calculate header/payload sizes
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

With the latest comment changes (v2/2) and wiscii's grammar fix these
code parts are now much easier to understand.

There is not much to actually test yet, as the new functions are not
called.  I have visually compared with crypto_adjust_frame_parameters()
and "it seems to do the smae thing" (if(occ)).

The comments in mtu.h are helpful to understand the terminology used
regarding "header" and "payload (including compression *header*").

Your patch has been applied to the master branch.

commit de018b5e93d6a85f39e5e8ecd3c986320fde8a2f
Author: Arne Schwabe
Date:   Wed Dec 29 17:34:45 2021 +0100

     Add helper functions to calculate header/payload sizes

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211229163445.1893687-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23476.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


