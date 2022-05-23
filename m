Date: Mon, 23 May 2022 16:15:30 +0200 (CEST)
Message-Id: <202205231415.24NEFUiR055127@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220523103546.3425388-1-arne@...1227...>
References: <20220523103546.3425388-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Translate OpenSSL 3.0 digest
 names to OpenSSL 1.1 digest names
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

This is basically the same change as commit 88342ed8277c5797 (master),
just without the Big MD Refactoring.

Tested, works :-) - --show-digests shows what to expect (without this
patch, ossl 3 builds show "SHA2-256", with this patch, "SHA256"), and
so does OCC.

Your patch has been applied to the release/2.5 branch.

commit b158125f67b49149ffd3e2617479fbd27860713c
Author: Arne Schwabe
Date:   Mon May 23 12:35:45 2022 +0200

     Translate OpenSSL 3.0 digest names to OpenSSL 1.1 digest names

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220523103546.3425388-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24424.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


