Date: Fri, 23 May 2025 09:55:12 +0200 (CEST)
Message-Id: <202505230755.54N7tCoA071781@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250523073848.20848-1-gert@...1296...>
References: <20250523073848.20848-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: avoid bogus text
 when netlink message is not parsed
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

"Because it makes sense" :-) - this is one of the messages we can
really live without in the log (and *if* there is something to report,
the platform specific layer do so).

Your patch has been applied to the master branch.

commit 4a48841da2d4179a96348994f841661ec9e5ce1d
Author: Antonio Quartulli
Date:   Fri May 23 09:38:41 2025 +0200

     dco_linux: avoid bogus text when netlink message is not parsed

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250523073848.20848-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31763.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


