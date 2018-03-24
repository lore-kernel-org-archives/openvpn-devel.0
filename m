Date: Sat, 24 Mar 2018 17:45:51 +0100 (CET)
Message-Id: <201803241645.w2OGjppj054556@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1520316568-8983-1-git-send-email-selva.nair@...277...>
References: <1520316568-8983-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid overflow in wakeup time
 computation
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch (bugfix).

Tested by running with the config from #922, which leads to

./../../openvpn/src/openvpn/interval.c:54:37: runtime error: signed integer overflow: 1521909676 + 1000000000 cannot be represented in type 'int'

without the patch, and no error with it (Linux/amd64).

commit f158c0e1df13ae1b697cdc7f189ddd1575a0c1aa (master)
commit 6d16c87de38610b05ec768af28a76a9389791134 (release/2.4)
Author: Selva Nair
Date:   Tue Mar 6 01:09:28 2018 -0500

     Avoid overflow in wakeup time computation

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1520316568-8983-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16634.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


