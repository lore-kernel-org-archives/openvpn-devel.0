Date: Thu, 20 Jun 2024 12:20:14 +0200 (CEST)
Message-Id: <202406201020.45KAKEJX014540@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240619144629.1718-2-lev@...515...>
References: <20240619144629.1718-2-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: Improve access
 control for gui<->service pipe
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Indeed, the patch differs only in a single line, related to the snprintf()
cleanup (which is only in master).  Thanks, Lev, and Selva.

Stared at code differences (fine) and test compiled via GHA and local
ubuntu/mingw - all good.

Your patch has been applied to the master branch.

commit babf312ee0486e50ff1f7db5b544afc72ff7c922
Author: Lev Stipakov
Date:   Wed Jun 19 17:46:08 2024 +0300

     interactive.c: Improve access control for gui<->service pipe

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20240619144629.1718-2-lev@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28808.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


