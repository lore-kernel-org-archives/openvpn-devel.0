Date: Sat, 9 Dec 2023 11:05:02 +0100 (CET)
Message-Id: <202312091005.3B9A52pp029121@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231208173346.94820-1-frank@...2641...>
References: <20231208173346.94820-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move tls_get_cipher_name_pair
 and get_num_elements to ssl_utils.c
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

"git show --color-moved=zebra" confirm that this is indeed only moving
code around.  "make check" still passes fine.

Your patch has been applied to the master branch.

commit 3094d8fb061c56ea73eda00c464fa81cdcd55c94
Author: Arne Schwabe
Date:   Fri Dec 8 18:33:46 2023 +0100

     Move tls_get_cipher_name_pair and get_num_elements to ssl_utils.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231208173346.94820-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27726.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


