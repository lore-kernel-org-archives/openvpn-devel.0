Date: Tue, 28 Oct 2025 17:35:04 +0100 (CET)
Message-Id: <202510281635.59SGZ4vF009524@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028162843.18189-1-gert@...1296...>
References: <20251028162843.18189-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: sitnl: set FD_CLOEXEC on socket
 to prevent abuse
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

Straightforward enough :-)

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit b9b5470521294209146c7253a97012d399978d72 (master)
commit 12a2e88b9e9fc7b0e6f8fce0125b5272980ec51b (release/2.6)
Author: Antonio Quartulli
Date:   Tue Oct 28 17:28:38 2025 +0100

     sitnl: set FD_CLOEXEC on socket to prevent abuse

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1314
     Message-Id: <20251028162843.18189-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33952.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


