Date: Fri, 20 Feb 2026 15:24:36 +0100 (CET)
Message-Id: <202602201424.61KEOaLt055762@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260220102106.32024-1-gert@...1296...>
References: <20260220102106.32024-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: adjust to native
 inotify support for FreeBSD 15+
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

Tested on FreeBSD 14 ("needs libinotify pkg") and 15 ("built-in, no 
pkg, no CFLAGS etc. needed").

Patch has been applied to the master, release/2.7 and release/2.6 branch
(long-term compat).

commit 38243844f225517fa1d288517db9a34a33c5ad13 (master)
commit d9279c77f796a45cd94e929376d5d4d9cbae34eb (release/2.7)
commit a4bf28df70385b71934ab0016560eadf4c4ea542 (release/2.6)
Author: Gert Doering
Date:   Fri Feb 20 11:20:58 2026 +0100

     configure.ac: adjust to native inotify support for FreeBSD 15+

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1535
     Message-Id: <20260220102106.32024-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35761.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


