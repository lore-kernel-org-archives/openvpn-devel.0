Date: Sat, 26 Oct 2024 11:51:22 +0200 (CEST)
Message-Id: <202410260951.49Q9pMwu009381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241026092515.30559-1-gert@...1296...>
References: <20241026092515.30559-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: use wait instead
 of marker files
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

Tested on FreeBSD with the "this server is intentionally ignoring signals"
patch, to make it fail.  BB tested all the other platforms with well-behaved
openvpn binaries.

Your patch has been applied to the master branch.

commit 5dd1b8b06335831206077a1eb4aa81c3ceb3f3ee
Author: Samuli Seppänen
Date:   Sat Oct 26 11:25:14 2024 +0200

     t_server_null: use wait instead of marker files

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241026092515.30559-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29664.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


