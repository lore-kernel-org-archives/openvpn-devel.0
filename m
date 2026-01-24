Date: Sat, 24 Jan 2026 18:41:36 +0100 (CET)
Message-Id: <202601241741.60OHfatk047162@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260119215058.27888-1-gert@...1296...>
References: <20260119215058.27888-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Add a first unit
 test
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

This is most welcome... the function in question has so many edge cases 
it's really hard to "just review", and being able to systematically test
is great (more tests could be necessary to cover everything :-) ).

The "mingw <-> autoconf <-> cmocka (cross-build)" interaction is not
really perfect yet - if there is no cross-built cmocka, configure will
not notice, and "make check" will just fail with

  pkey_test_utils.c:32:10: fatal error: cmocka.h: No such file or directory
     32 | #include <cmocka.h>
        |          ^~~~~~~~~~

.. more work needed.  But not not fault of this patch...  so, tested
with Github Actions, and that compiles all UTs fine.  It does not yet
*run* them, as far as I can see... so work on the build.yaml seems
needed.

Your patch has been applied to the master branch.

commit b10ee38ccde5f155d02fcd3e8f1b1ab454826ab0
Author: Frank Lichtenheld
Date:   Mon Jan 19 22:50:53 2026 +0100

     openvpnserv: Add a first unit test

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1459
     Message-Id: <20260119215058.27888-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35345.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


