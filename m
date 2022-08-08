Date: Mon, 8 Aug 2022 12:43:26 +0200 (CEST)
Message-Id: <202208081043.278AhQR6026657@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220807193535.15377-1-gert@...1296...>
References: <20220807193535.15377-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup: get rid of 'dynamic'
 argument of open_tun_generic()
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

Whitespace in "strcmp()" adjusted as instructed :-)

Tested by feeding to the buildbot army, which did not complain.

Patch has been applied to the master branch.

commit 4c31a3ca0660e2693e18430d836957edf6e128ea
Author: Gert Doering
Date:   Sun Aug 7 21:35:35 2022 +0200

     Cleanup: get rid of 'dynamic' argument of open_tun_generic()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20220807193535.15377-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24838.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


