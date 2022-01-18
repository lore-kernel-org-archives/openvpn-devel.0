Date: Tue, 18 Jan 2022 14:01:51 +0100 (CET)
Message-Id: <202201181301.20ID1pJY032163@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220117093508.17681-1-a@...2181...>
References: <20220117093508.17681-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: use 'static inline' instead of
 'inline static'
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Looks good.  Not tested beyond a simple compile test.

Your patch has been applied to the master branch.

commit 943fb256ded24e8637a2bbaabd525e4b85ecc810
Author: Antonio Quartulli
Date:   Mon Jan 17 10:35:08 2022 +0100

     use 'static inline' instead of 'inline static'

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20220117093508.17681-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23554.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


