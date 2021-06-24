Date: Thu, 24 Jun 2021 17:25:40 +0200 (CEST)
Message-Id: <202106241525.15OFPehD080592@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210624130840.2583433-1-arne@...1227...>
References: <20210624130840.2583433-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure tls session is
 authenticated before sending push reply
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

For whatever reason, this particular code path escaped previous patches,
so now it's fixed as well.  And verified - even with the previous 3 
patches (and I was sure I had seen it fixed!) sometimes I hit the
"PUSH_REPLY sent too fast" thing.  Now, gone.

Not tested on the client side (this is server-only code).

Server side test rig succeeded.  Since this is a fairly isolated
change, verifying that PUSH_REQUEST/PUSH_REPLY still works was easy
(but tested all of it, for good measure).

Your patch has been applied to the master branch.

commit 87c8c081d5a1ede46b3cb01e0c25a876441f074b
Author: Arne Schwabe
Date:   Thu Jun 24 15:08:40 2021 +0200

     Ensure tls session is authenticated before sending push reply

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210624130840.2583433-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22587.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


