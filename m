Date: Wed, 28 Jan 2026 14:28:11 +0100 (CET)
Message-Id: <202601281328.60SDSBrl035663@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260128110425.24350-1-gert@...1296...>
References: <20260128110425.24350-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tunnel_server(): close correct
 inotify fd
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This was an... interesting chase.  It started out by testing the fix for
a management-interface weirdness (commit 4bf05d487c) and all of a sudden
I had the server crash with ASSERT(!mi->halt) on me... which turned out
to be a bug in really ancient code... (commit 619c3e9a0 moved around the
inotify stuff in the context of multisocket, but did not introduce the
confusion on "top" contexts - that was already in the initial inotify
commit 0d1a75bfe).  Full details in the github issue...

For now, this patch has been applied to the master branch (to progress
towards 2.7_rc6).  I will come back here to see which branches need the
fix, or whether different "top context" handling actually made it do the
right thing 10 years ago...

commit 5521872f80313060b659c27c55df2a6fdb74ec7a
Author: Gert Doering
Date:   Wed Jan 28 12:04:19 2026 +0100

     tunnel_server(): close correct inotify fd

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1497
     Message-Id: <20260128110425.24350-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35478.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


