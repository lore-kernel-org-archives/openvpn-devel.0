Date: Tue, 1 Oct 2019 12:54:16 +0200 (CEST)
Message-Id: <201910011054.x91AsGeD072215@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190917121039.13791-1-arne@...1227...>
References: <20190917121039.13791-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement a permanent session
 id in auth-token
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
To: Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Again, lightly tested with client side test runs.

There is a typo in the man page change:

-.B \-\-auth\-gen\-token [lifetime]
+.B \-\-auth\-gen\-token [lifetime] [auth]

this flag is called "external-auth" (the *text* correctly says so, and
options.c agrees).  I have fixed this on the fly.

Not exactly sure why we need a workaround for an OpenVPN3 bug in 2.5,
though...  when 2.5 comes close to release, there should no longer be
any buggy OpenVPN3 client around that mishandles username sending?  
So maybe we want to take that part *out* again...?

commit c8723aa7bebb0ddb088819590d5a9bea6ea0d669
Author: Arne Schwabe
Date:   Tue Sep 17 14:10:39 2019 +0200

     Implement a permanent session id in auth-token

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20190917121039.13791-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18819.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


