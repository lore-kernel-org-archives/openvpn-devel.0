Date: Mon, 17 Nov 2025 08:59:35 +0100 (CET)
Message-Id: <202511170759.5AH7xZFp081027@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251116215433.29257-1-gert@...1296...>
References: <20251116215433.29257-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Clean up type handling in
 parse_early_negotiation_tlvs()
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

And with that, the #pragma in ssl.c can finally go...

Change makes sense (took me a bit to understand the intricacies of
buf_read_u16() and why it's not returning an uint16_t) - and this is arguably
more correct, as the old code did not handle the "buffer too small" case
nicely (it did, by having "len" end up being 0xffff, and buf_len() will
then be 0 or 1, which is definitely smaller then "len" - but now it's
quite explicit and easier to understand).

Smoke tested on Linux.

Your patch has been applied to the master branch.

commit abe32bce066ccf77db7e49159ea0f8111c02a3c4
Author: Frank Lichtenheld
Date:   Sun Nov 16 22:54:27 2025 +0100

     ssl: Clean up type handling in parse_early_negotiation_tlvs()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1302
     Message-Id: <20251116215433.29257-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34487.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


