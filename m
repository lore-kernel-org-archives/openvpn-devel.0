Date: Mon, 2 Aug 2021 12:39:06 +0200 (CEST)
Message-Id: <202108021039.172Ad60U071576@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210802100740.694474-1-arne@...1227...>
References: <20210802100740.694474-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unistd.h from unit test
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

Acked-by: Gert Doering <gert@...1296...>

That was an easy one for a change :-)

We should make our mind on all the other includes, though - like
<stdio.h>, <stdlib.h>, <stdarg.h> - they come via "syshead.h" as
well today, and are included another time in all the test_*.c files.

Did not do windows compilation, but tested Linux and FreeBSD, and
(unsurprisingly) no change wrt the unit tests.

Your patch has been applied to the master branch.

commit f9dbf645fa5b6fdda06abebedbed772a83d8f0d9
Author: Arne Schwabe
Date:   Mon Aug 2 12:07:40 2021 +0200

     Remove unistd.h from unit test

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210802100740.694474-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22685.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


