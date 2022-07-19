Date: Tue, 19 Jul 2022 22:13:47 +0200 (CEST)
Message-Id: <202207192013.26JKDlfs043429@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220624083809.23487-18-a@...2181...>
References: <20220624083809.23487-18-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: extract close_tun_handle
 into its own fucntion and print correct type
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

Code change looks good.  Did not actually test anything, but it *does*
pass compilation on MinGW / Unbuntu 18.04 :-)

The change to print the actual adapter type confuses "--color-move=zebra", 
but is a nice enhancement.

Your patch has been applied to the master branch.

commit abceec65daed9aa6359314a0243246acc1cc25bf
Author: Arne Schwabe
Date:   Fri Jun 24 10:38:01 2022 +0200

     tun: extract close_tun_handle into its own fucntion and print correct type

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220624083809.23487-18-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24527.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


