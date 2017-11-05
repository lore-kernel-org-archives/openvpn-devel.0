Date: Sun, 5 Nov 2017 11:12:32 +0100 (CET)
Message-Id: <201711051012.vA5ACWVu032844@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171104224551.3079-1-steffan@...1856...>
References: <20171104224551.3079-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re:
 buffer_list_aggregate_separator(): add unit tests
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, test code is good :-)  (it passes the tests now, and does not change
anything else).  Applying to 2.4 as well, since "test good is good", even
if we might not apply the refactoring bits there.

Your patch has been applied to the master and release/2.4 branch.

commit 2ddb527abe38f5866ff01e91f8ee89d0f9700762 (master)
commit a202f6e74b32beabad764ee4226781a7f7e9c1c6 (release/2.4)
Author: Steffan Karger
Date:   Sat Nov 4 23:45:50 2017 +0100

     buffer_list_aggregate_separator(): add unit tests

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171104224551.3079-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15748.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


