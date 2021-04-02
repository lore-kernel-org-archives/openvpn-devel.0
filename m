Date: Fri, 2 Apr 2021 15:47:43 +0200 (CEST)
Message-Id: <202104021347.132Dlhpa013442@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210324220853.31246-1-arne@...1227...>
References: <20210324220853.31246-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement '--compress migrate'
 to migrate to non-compression setup
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

Your patch has been applied to the master branch.

As discussed extensively I do not like having to rewrite OCC strings
in the middle of the session handshake - the code is complex enough
as it is.  OTOH I've let myself be convinced that the alternative 
approaches ("use management interface", "wait for de-fused OCC on all
clients encountered") are not really better - so we go with this, and
I've opened a Trac ticket as reminder for "get rid of this again" (#1397).

WRT testing: I have extended one of my server instances to include
"compress migrate", and then thrown a few client test cases with and
without "comp-lzo", "compress lz4", ... against it (2.2 .. master).  

As expected it fails to handle a 2.3 client compiled with --enable-small
(because that disables OCC).   2.3 + 2.4 + master succeed.

Somewhat unexpectedly it also fails for the 2.2 client with comp-lzo - the 
server recognizes that it it has an OCC client with compression

  Note: 'compress migrate' detected remote peer with compression enabled

but fails to send "comp-lzo no".  This is due to this code part

+    if (!peer_info)
+    {
+        return CC_RET_SUCCEEDED;
+    }

which only acts if the client pushes any sort of peer info, which is
not default in 2.2 - if I tell the 2.2 client to do "--push-peer-info",
it works.

Since the whole point of this patch is to "make crappy clients work"
I'd suggest to move the "peer_info" check inside the 

+    if (o->comp.flags & COMP_F_MIGRATE && mi->context.c2.tls_multi->remote_usescomp)

clause (-> if (peerinfo && strstr(peer_info, "IV_COMP...") ) which
will make the server behave for 2.2 clients as well.


Since this is more of a nuisance than a showstopper, I will proceed
with merging, and have sent a fix patch to the list.


commit 8fa8a17528c001abc7d5f45e9c2ffa3ed2f6af43 (master)
Author: Arne Schwabe
Date:   Wed Mar 24 23:08:53 2021 +0100

     Implement '--compress migrate' to migrate to non-compression setup

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210324220853.31246-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21801.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


