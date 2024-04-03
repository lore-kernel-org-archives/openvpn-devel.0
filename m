Date: Wed, 3 Apr 2024 09:38:54 +0200 (CEST)
Message-Id: <202404030738.4337csUN073882@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240125110036.16070-1-frank@...2641...>
References: <20240125110036.16070-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: fork default automake
 test-driver
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

Tested this in various build environments, including Ubuntu/MinGW,
and GHA, and things still work & test "as before".  Combined with the
next commit, we get useful (for me) "I can see what make check is doing
all the time" behaviour back.

Your patch has been applied to the master branch.

commit aea6e9aa854b454f98671382eb751662dd9e1e03
Author: Frank Lichtenheld
Date:   Thu Jan 25 12:00:36 2024 +0100

     tests: fork default automake test-driver

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240125110036.16070-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28132.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


