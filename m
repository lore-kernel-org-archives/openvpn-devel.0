Date: Thu, 18 Mar 2021 10:34:14 +0100 (CET)
Message-Id: <202103180934.12I9YEw4086581@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210316124421.1635-1-arne@...1227...>
References: <20210316124421.1635-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid generating unecessary
 mbed debug messages
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

Tested with exactly that testbed that initially discovered the SIGSEGV,
and as expected, it no longer crashes.  Verified that it still crashes
with "--verb 8" (it does).

Code also looks secure and does what it says on the lid.

That said, ACKed and merged, I'm still not totally happy with the
approach chosen - this is quite some new lines of code to change one 
"3" into a "2", depending on the value of one other variable...  but we
discussed this before, and Arne did not want to have the mbedTLS code
"peek" into get_debug_level() to get at the --verb setting.  Since
Steffan is fine with this approach, I'm clearly the minority here...


.. while writing this, the ACK from Steffan came in... so, recording
that as well... MULTI-ACK! :-) - and fixing the comment as requested.


Your patch has been applied to the master and release/2.5 branch
(stability / long-term compat thing).

commit 4524feb2bbbb6d1bd463a0c5c2d53aae5bdf360a (master)
commit 475d17a53eba85591f270008f8b583383a5b9afa (release/2.5)
Author: Arne Schwabe
Date:   Tue Mar 16 13:44:21 2021 +0100

     Avoid generating unecessary mbed debug messages

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210316124421.1635-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21667.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


