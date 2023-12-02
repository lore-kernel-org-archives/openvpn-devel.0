Date: Sat, 2 Dec 2023 16:26:20 +0100 (CET)
Message-Id: <202312021526.3B2FQKJK083758@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201112243.15541-1-frank@...2641...>
References: <20231201112243.15541-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace character_class_debug
 with proper unit test
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

This is definitely more useful than having conditional tests that
nobody ever runs... done a quick test on FreeBSD, passes...

[ RUN      ] test_character_class
[       OK ] test_character_class
[==========] 14 test(s) run.
[  PASSED  ] 14 test(s).
PASS: buffer_testdriver

Your patch has been applied to the master branch.

commit 0a27c98a61ae103d29065610abe1e4e0b61f3375
Author: Arne Schwabe
Date:   Fri Dec 1 12:22:43 2023 +0100

     Replace character_class_debug with proper unit test

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231201112243.15541-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27628.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


