Date: Wed, 16 Nov 2022 13:30:34 +0100 (CET)
Message-Id: <202211161230.2AGCUY4L081791@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221115122940.1947284-1-arne@...1227...>
References: <20221115122940.1947284-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix logic error in checking
 early negotiation support check
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

The discussion in the mail thread and on IRC explains why we need
to check the full EARLY_NEG_START value (because it's "0x0f" in the
topmost byte, not "just one bit set").  This is because it was done
that way initially, and now it is what it is...  so what this patch
adds is "ignore the uppermost 4 bits in comparison, should we want
to use these 4 bits for protocol extention in the future".

Arguably one could just do "(pin.id & EARLY_NEG_START) == EARLY_NEG_START"
here, but maybe this way it's clear what is being looked at.

Only compile tested.

Your patch has been applied to the master branch.

commit 543f709f13bca9887cabd4545554539f18346e3c
Author: Arne Schwabe
Date:   Tue Nov 15 13:29:40 2022 +0100

     Fix logic error in checking early negotiation support check

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221115122940.1947284-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25519.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


