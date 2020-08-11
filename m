Date: Tue, 11 Aug 2020 22:56:01 +0200 (CEST)
Message-Id: <202008112056.07BKu1Ud059560@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200810143707.5834-3-arne@...1227...>
References: <20200810143707.5834-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup tls_pre_decrypt_lite
 and tls_pre_encrypt
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

"diff -w" shows that this is really "C99, early return, whitespace".

Nevertheless, full client and server tested :-) (and passes).

Your patch has been applied to the master branch.

commit 162499591d03155e853ed44c90c12771307ee0eb
Author: Arne Schwabe
Date:   Mon Aug 10 16:36:52 2020 +0200

     Cleanup tls_pre_decrypt_lite and tls_pre_encrypt

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200810143707.5834-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20676.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


