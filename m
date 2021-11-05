Date: Fri, 5 Nov 2021 16:17:27 +0100 (CET)
Message-Id: <202111051517.1A5FHRdS085687@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211030185756.1831-1-selva.nair@...277...>
References: <20211030185756.1831-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid memory leak in
 hmac_ctx_new (OpenSSL 3.0 only)
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I have not done "real" testing, just "compile and make check" on 
ossl 3.0.0 - but if you and Arne agree, this is definitely good enough 
for me :-)

Your patch has been applied to the master branch.

commit 31e200f807033ac27566bf37a8d9d32820600a83
Author: Selva Nair
Date:   Sat Oct 30 14:57:56 2021 -0400

     Avoid memory leak in hmac_ctx_new (OpenSSL 3.0 only)

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211030185756.1831-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23080.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


