Date: Fri, 31 Oct 2025 11:07:24 +0100 (CET)
Message-Id: <202510311007.59VA7OrB052702@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030195244.2659-1-gert@...1296...>
References: <20251030195244.2659-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: invalid
 read bug-fix and unit-tests improvements
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

I have stared-at-code for a while (looks reasonable), subjected to the
client/server testbed (which does not actually *do* PUSH_UPDATE yet, still),
and ran a few manual tests.  This all works as it did before - did not
try to find new and interesting edge cases.  (I did *not* actively try, but
still found #889...)

We might eventually clean up the repeated

         {
+            buffer_list_free(msgs);
             gc_free(&gc);
             return 1;
         }

clauses into a common "cleanup:" clause...  but this is also not important
right now.  We should refrain from adding even more cleanups there, though ;-)


The extra unit tests are very welcome.

Your patch has been applied to the master branch.

commit 6b0208e962aadf285ecc7ab47cc973a9018e3f24
Author: Marco Baffo
Date:   Thu Oct 30 20:52:35 2025 +0100

     PUSH_UPDATE server: invalid read bug-fix and unit-tests improvements

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1316
     Message-Id: <20251030195244.2659-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34073.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


