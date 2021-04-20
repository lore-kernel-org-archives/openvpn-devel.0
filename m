Date: Tue, 20 Apr 2021 12:28:32 +0200 (CEST)
Message-Id: <202104201028.13KASWlO013077@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210328120241.27605-2-arne@...1227...>
References: <20210328120241.27605-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix condition to generate
 session keys
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

Adding my own ACK because it needed a bit of whack to go in, and due
to my own testing.

The patch "as it is" applies to release/2.5 just fine, but conflicts with
master because 2 of 3 hunks are already in, in a slightly different
formatting.  So, master only received the middle hunk, and the 2.5 change
was not done by cherrypicking but by directly applying the patch.

Tested master and release/2.5 on the server torture test bed, including
the "client connects, renegotiates, disconnects, and starts anew from
the same source port" test, which would yield a broken session and now
works fine.

Your patch has been applied to the master and release/2.5 branch.

I have added a reference to Trac #1316 to the commit message.

commit a005044be9ca77ee8a47cb65a603d0b1c41b99f4 (master)
commit 227fbc117d58a87465804f7b2a5cd95ef1b94da6 (release/2.5)
Author: Arne Schwabe
Date:   Sun Mar 28 14:02:41 2021 +0200

     Fix condition to generate session keys

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210328120241.27605-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21873.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


