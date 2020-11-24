Date: Tue, 24 Nov 2020 20:28:48 +0100 (CET)
Message-Id: <202011241928.0AOJSmvb023195@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200830140736.16571-2-arne@...1227...>
References: <20200830140736.16571-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Normalise ncp-ciphers option
 and restrict it to 127 bytes
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

It's a prerequisite for the (desirable) IV_CIPHERS patch 
for 2.4.  It passes the client side tests (though the code
is not exercised very strongly).  The code looks different
from the "master" patch due to changes to cipher_kt_get()
and because it's called "--data-ciphers" there - but these
are straightforward.  Besides that, it's exactly the same
code.

NOTE: the patch includes a copy of ssl_ncp.h, which is 
not needed *and* not referenced, so I've dropped that part.

Your patch has been applied to the release/2.4 branch.

commit 7e3cd06d514476658709506c5e8e0703008efc5f
Author: Arne Schwabe
Date:   Sun Aug 30 16:07:35 2020 +0200

     Normalise ncp-ciphers option and restrict it to 127 bytes

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200830140736.16571-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20846.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


