Date: Wed, 17 Sep 2025 18:26:29 +0200 (CEST)
Message-Id: <202509171626.58HGQTYh039521@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250917090557.25414-1-gert@...1296...>
References: <20250917090557.25414-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Fix writing
 messages to the event log
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

So this has a bit of a complicated journey - the initial patch was
gerrit 1183 for 2.6, which had v1..v3, and then this one for master,
which only got up to v2 but is now the same code change, essentially.

I have tested a 2.6 installer with this, and it makes really nice 
log entries in the event log - so definitely a MUST HAVE.

HEADS UP: when building installers with "autoconf" on mingw, this will
not currently produce the necessary .dll to proceed.  I'll send a patch
to add this.  The official way releases are built is "cmake with msvc"
or "cmake with mingw", and both produce the new .dll - and for "just
build a test openvpn.exe with configure/mingw" this is not critical
(which is what I usually do).

Your patch has been applied to the master branch.

commit 06919a60ae61d6d88546b23b52092f742599a8ae
Author: Lev Stipakov
Date:   Wed Sep 17 11:05:48 2025 +0200

     openvpnserv: Fix writing messages to the event log

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1188
     Message-Id: <20250917090557.25414-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59234559/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


