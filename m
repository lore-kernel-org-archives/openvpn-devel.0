Date: Wed, 3 Apr 2024 09:41:01 +0200 (CEST)
Message-Id: <202404030741.4337f1gL073980@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240125110122.16257-1-frank@...2641...>
References: <20240125110122.16257-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: forked-test-driver: Show test
 output always
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
previous commit, we get useful (for me) "I can see what make check is doing
all the time" behaviour back.

I'm still not convinced that this is a better way forward than just
using the old test-driver and possibly tweaking Makefiles a bit, but
"this does work for me", and automake upstream seems to think it's the
way to go...  thanks, Frank, for doing the actual work :-)

Your patch has been applied to the master branch.

commit e2ff9161e1b1b3e8c83bf01e3c488e0601834c0c
Author: Frank Lichtenheld
Date:   Thu Jan 25 12:01:22 2024 +0100

     forked-test-driver: Show test output always

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240125110122.16257-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28133.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


