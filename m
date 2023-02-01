Date: Wed, 1 Feb 2023 17:24:01 +0100 (CET)
Message-Id: <202302011624.311GO1FV018658@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230130172936.3444840-1-arne@...1227...>
References: <20230130172936.3444840-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix unaligned access in
 auth-token
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

This one is fairly straightforward.  We had discussions on IRC if
we really need to make this network byte order ("the data in the token
is only for the server, nobody else needs to care") but then decided
that if someone wants to run a cluster of an intel + a s390 host,
they need to be compatible wrt timestamp representation...

Tested on the server testbed, just to be sure (it has an auth-token test) -
things still work, including token expiry after the configured time.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit f6ccff6d7ea806711f9af59c9de52b7cf80d9c81 (master)
commit 6241b2f8dbe39062a3273499a0259750d2f02cf8 (release/2.6)
Author: Arne Schwabe
Date:   Mon Jan 30 18:29:32 2023 +0100

     Fix unaligned access in auth-token

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230130172936.3444840-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26103.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


