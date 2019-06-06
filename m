Date: Thu, 6 Jun 2019 08:50:06 +0200 (CEST)
Message-Id: <201906060650.x566o635087246@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-7-a@...2181...>
References: <20181219050118.6568-7-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: unit tests: implement test for
 sitnl
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Since this is not depending on 5/7, no reason to stall - so, here we
are.

Comments...

 - it's sourcing t_client.rc, but only for the SUDO definition - this is
   a bit confusing, and might warrant a comment in the script

 - maybe make this a bit more verbose what it does?

make  check-TESTS
make[4]: Entering directory '/rhome/gert/src/openvpn-maint/test-build-master-ossl111/tests'
PASS: t_net.sh

   (all our other tests print "test this, ok, test that, ok", which I find
   good feedback)

 - maybe feed the list of things to test from a "t_net.rc" file, so you
   can more easily extend the test set (when developing)?  Right now, 
   the test is hardcoded in the C source, but the script needs to know
   how many tests there are to call them in sequence...

 - "make check" in an --enable-iproute2 build fails like this:

./../openvpn/tests/t_net.sh: eval: line 150: syntax error near unexpected token `;'
./../openvpn/tests/t_net.sh: eval: line 150: `;'
FAIL: t_net.sh

    I expected it to fail in some interesting way, but this looks like
    it at least needs more sanity checking on setting of $OUT and $CMD
    (or maybe fail more explicitly for non-sitnl builds).


  - code wise:

 t_scripts = t_client.sh
+test_scripts = t_net.sh
+test_scripts += t_client.sh
 test_scripts += t_lpback.sh t_cltsrv.sh

    ... why are we having two lines that add one script each and one
    line that adds two scripts here?  Why not just "one line for all"?


  - if you want bash, ask for bash...

+#!/bin/sh
..
+# Note: statements in the rest of the script may not even pass syntax check on
+# solaris/bsd. It uses /bin/bash

    /bin/sh on Linux will not always be bash (dash on Debian, for example),
    so either do not use bash features, or ask for /bin/bash.

  - comments taken over verbatim from t_client.sh are more confusing
    than useful here:

+# make sure we have permissions to run ifconfig/route from OpenVPN
+# can't use "id -u" here - doesn't work on Solaris

  - all the KILL_EXEC stuff should be removed from t_net.sh - you never
    run "sudo kill <something>", so don't carry over that code
    (we need to explicitely test this in t_client.sh because otherwise
    we might end up with openvpn binaries that we have started in the 
    background and cannot kill anymore - "sudo openvpn" allowed, but
    "sudo kill" not allowed)

  - in the tests: good practice is to always use 2001:db8::/32 for
    "demo and testing", not addresses that might be assigned to someone
    else one day.  But also use an ULA network (fdxx:xxxx:xxxx::/48, with
    "xx" selected by rolling a dice) in case "something" handles these
    differently - ULA is the new RFC1918 stuff, globally unique but still
    not routed.


commit c4d5bcd7c90abbab2378ac865e326933b0ff1e1c
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:17 2018 +1000

     unit tests: implement test for sitnl

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-7-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18027.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


