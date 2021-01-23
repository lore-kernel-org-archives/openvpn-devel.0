Date: Sat, 23 Jan 2021 13:16:54 +0100 (CET)
Message-Id: <202101231216.10NCGsOX047059@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210121133929.20186-1-gert@...1296...>
References: <20210121133929.20186-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make OPENVPN_PLUGIN_ENABLE_PF
 failures FATAL
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

Patch has been applied to the master and release/2.5 branch.

release/2.4 has different code and does not fail, so does not need
the patch.

commit 6a0c51baaa4d2b329183601ec35d3d16f127519e (master)
commit cbbdcd4f97bb19e5be6c11cf94397b38e869a0ee (release/2.5)
Author: Gert Doering
Date:   Thu Jan 21 14:39:29 2021 +0100

     Make OPENVPN_PLUGIN_ENABLE_PF failures FATAL

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210121133929.20186-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21464.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


