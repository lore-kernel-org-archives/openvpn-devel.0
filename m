Date: Fri, 8 Mar 2024 12:25:00 +0100 (CET)
Message-Id: <202403081125.428BP0Pr015498@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240216123037.3670448-1-frank@...2641...>
References: <20240216123037.3670448-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re:
 check_compression_settings_valid: Do not test for LZ4 in LZO check
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

"Makes sense" :-)

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit 4076d24f2f4adc432753aa62bd8158e3bf89ee21 (master)
commit 7a810e64e54eda264c9cf184f442a3bae8df66af (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Feb 16 13:30:37 2024 +0100

     check_compression_settings_valid: Do not test for LZ4 in LZO check

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240216123037.3670448-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28251.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


