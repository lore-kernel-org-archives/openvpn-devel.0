Date: Mon, 1 Jan 2024 19:41:03 +0100 (CET)
Message-Id: <202401011841.401If3va054393@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240101092714.18992-1-gert@...1296...>
References: <20240101092714.18992-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway() HWADDR
 overhaul
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

Patch has been applied to the master and release/2.6 branch (I did apply
the "other" get_default_gateway() patch because it was clearly a bugfix
for the undefined behaviour on MacOS, and I think this is the better bugfix,
so, 2.6 as well).

Have not explicitly tested this again, but fed it to GHA and the buildslaves
to make really really sure nothing breaks.

commit 76d11614797617708c31dc3db22e3568fee3de6d (master)
commit bfd5b12e49785cc658f6f2f86360797fd2201cdc (release/2.6)
Author: Gert Doering
Date:   Mon Jan 1 10:27:14 2024 +0100

     get_default_gateway() HWADDR overhaul

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20240101092714.18992-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27891.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


