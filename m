Date: Sat, 17 Aug 2019 20:09:49 +0200 (CEST)
Message-Id: <201908171809.x7HI9nS0051735@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190816204945.7937-1-a@...2181...>
References: <20190816204945.7937-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: fix segfault by
 calling mbedtls_cipher_free() in cipher_ctx_free()
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

As already written, the explanation makes sense, and it fully fixes the
problems observed on the buildslaves -> so, another ACK from me.

Thanks for the quick investigation & fix.

commit 2a74fc3f66bb9f73fc957719d187256922ca003f
Author: Antonio Quartulli
Date:   Fri Aug 16 22:49:45 2019 +0200

     mbedtls: fix segfault by calling mbedtls_cipher_free() in cipher_ctx_free()

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20190816204945.7937-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18781.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


