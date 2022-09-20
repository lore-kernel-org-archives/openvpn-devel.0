Date: Tue, 20 Sep 2022 14:26:18 +0200 (CEST)
Message-Id: <202209201226.28KCQI8D051473@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220914170134.2659433-1-arne@...1227...>
References: <20220914170134.2659433-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement AUTH_FAIL,
 TEMP message support
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

Stared-at-code.

Fixed file name reference in the documentation (as agreed), and TAB
in Makefile.am.

Tested with the "regular" server and client setups - nothing breaks,
but the new functionality isn't excercised, so this is not surprising.

Unit tests pass, too, which is good :-) - there is no real test for
"advance addr" vs. "advance remote" (there is "advance remote", but the
flags are not tested).  Maybe these could be added?


To actually *test* (and continuiously verify) the functionality I needed to
trick around a bit, creating a server-side script that "remembers" the
last TEMP fail, and succeeds on the 4th try...  but with that, it does
what it says on the tin - advance (to next addr) or not, stick to the
specified backoff time (remember to configure "--connect-retry 1" to *see*
the effect of short backoff timers :-) )

Your patch has been applied to the master branch.

commit c9474fa316a6f73286ed97b36c8f8b1ba62141bd
Author: Arne Schwabe
Date:   Wed Sep 14 19:01:34 2022 +0200

     Implement AUTH_FAIL, TEMP message support

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220914170134.2659433-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25210.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


