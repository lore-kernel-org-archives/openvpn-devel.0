Date: Sun, 22 Oct 2023 12:48:51 +0200 (CEST)
Message-Id: <202310221048.39MAmpCC060057@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231022082751.8868-1-gert@...1296...>
References: <20231022082751.8868-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: warn if DATA_V1 packets
 are sent to userspace
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

This is actually "V3" of the patch, but I forgot to add the -v3 when
sending from gerrit to the list.

The change is basically the same as in v1, just leaving the "real"
code alone, defusing it by setting c->c2.buf.len = 0 in the new
branch.  Plus comments :-)

As in v1, this adds diagnostics to detect a non-fixable incompatibility
between 2.4.0-2.4.4 servers and DCO-enabled clients (it can only be fixed
by upgrading the server, not by a code change on the client side, or by
disabling DCO on the client - but neither can be done automatically).

Tested on the server testbed, which has DCO and no-DCO peers, V1 and V2,
which should trigger "false alarms" nicely.

Your patch has been applied to the master and release/2.6 branch (compat).

commit df7beea404df48745a608c584d863c5a377b7a1e (master)
commit e78f88d8ea113585ca16945ef0361710b838ec7d (HEAD -> release/2.6)
Author: Lev Stipakov
Date:   Sun Oct 22 10:27:40 2023 +0200

     dco: warn if DATA_V1 packets are sent to userspace

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231022082751.8868-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27272.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


