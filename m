Date: Tue, 15 Jul 2025 15:52:57 +0200 (CEST)
Message-Id: <202507151352.56FDqvv9087357@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250715122957.22311-1-gert@...1296...>
References: <20250715122957.22311-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup/simplify mbed TLS
 related define from autoconf
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

This was slightly painful... but now we're at a point where this is
much simpler than before, arguably correct, and proven to work with
mbedtls 2.24, 2.28.3, 3.6.3 and 3.6.4 (TLS1.3, finally)...

Your patch has been applied to the master branch.

commit 5f34a7a0362ac228787b6d9d0968318132c78276
Author: Arne Schwabe
Date:   Tue Jul 15 14:29:49 2025 +0200

     Cleanup/simplify mbed TLS related define from autoconf

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250715122957.22311-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32145.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


