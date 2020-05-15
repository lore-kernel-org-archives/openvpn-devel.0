Date: Fri, 15 May 2020 18:11:16 +0200 (CEST)
Message-Id: <202005151611.04FGBGfp032936@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200507132534.6380-1-arne@...1227...>
References: <20200507132534.6380-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not write extra 0 byte for
 --gen-key with auth-token/tls-crypt-v2
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

Your patch has been applied to the master branch.

Lightly tested on my side ("make check" with OpenSSL and mbedTLS builds).

commit 14a57be4609fc23e4775072948bf722f21f25099
Author: Arne Schwabe
Date:   Thu May 7 15:25:34 2020 +0200

     Do not write extra 0 byte for --gen-key with auth-token/tls-crypt-v2

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Message-Id: <20200507132534.6380-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19852.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


