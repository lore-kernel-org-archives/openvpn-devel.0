Date: Wed, 8 Nov 2017 13:42:41 +0100 (CET)
Message-Id: <201711081242.vA8CgfDh068193@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1510143174-15248-1-git-send-email-steffan.karger@...1435...>
References: <1510143174-15248-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: doxygen: add make target and
 use relative paths
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

"Does what it says on the lid", easy access to documentation is good :-)

Tried in-tree and out-of-tree builds, and both gave me a nice HTML
and Latex documentation.   "make distclean" now works as well, as does
"make distcheck" :-)

Your patch has been applied to the master branch.

commit 66bf378e686872dfab22a983184f65599af494f8
Author: Steffan Karger
Date:   Wed Nov 8 13:12:54 2017 +0100

     doxygen: add make target and use relative paths

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1510143174-15248-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1510143174-15248-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


