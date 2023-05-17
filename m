Date: Wed, 17 May 2023 19:10:37 +0200 (CEST)
Message-Id: <202305171710.34HHAb1h076749@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230517084422.70547-2-frank@...2641...>
References: <20230517084422.70547-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_buffer: add tests for
 buf_catrunc and its caller format_hex_ex
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

Acked-by: Gert Doering <gert@...1296...>

Unit Tests are good, this function-under-test is a bit weird, and
having the UTs in tree (and working) before the actual patch gives
double assurance that it's still working in the same weird way :-)

[ RUN      ] test_buffer_printf_catrunc
[       OK ] test_buffer_printf_catrunc
[ RUN      ] test_buffer_format_hex_ex
[       OK ] test_buffer_format_hex_ex

Your patch has been applied to the master branch.

commit eecf9e9d70955018225e47d96d57da72511c48a0
Author: Frank Lichtenheld
Date:   Wed May 17 10:44:22 2023 +0200

     test_buffer: add tests for buf_catrunc and its caller format_hex_ex

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230517084422.70547-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26680.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


