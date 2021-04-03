Date: Sat, 3 Apr 2021 13:48:39 +0200 (CEST)
Message-Id: <202104031148.133BmdaD087893@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317130312.8585-1-arne@...1227...>
References: <20210317130312.8585-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move auth deferred related
 members into its own struct
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

As Antonio has already stated, this really only moves 3 structure 
elements into their own substructure, and all functions working on 
these elements are now passed a pointer to the substructure (so the
next patch can then use two substructures to have individual files
for "plugin" and "script" deferred auth).  

I'm slightly worried about the "setenv" bits (using the same name in 
all cases) but if the flow of events is linear enough ("create files, 
start plugin, create other sets of files, start script") this should 
not be a problem.

I have fixed the conflict caused by commit 997b006a26 on the fly 
(trivial).

Tested on the server test rig that found the "now auth fails" problem
with the v4 patch.  All green so far :-)

Your patch has been applied to the master branch.

commit c5fec838e749e4a1806a42c1f593f195c2d60b3b
Author: Arne Schwabe
Date:   Wed Mar 17 14:03:11 2021 +0100

     Move auth deferred related members into its own struct

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210317130312.8585-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21671.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


