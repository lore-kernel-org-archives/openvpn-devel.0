Date: Fri, 8 May 2020 23:52:15 +0200 (CEST)
Message-Id: <202005082152.048LqFcx073537@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200508114243.15532-1-davids@...515...>
References: <20200508114243.15532-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Fix failing inline
 tls-auth/crypt with persist-key
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Have not done any testing, but the code change looks very reasonable
and exactly like it would fix the bug :-)

commit e8e410fdc6fb91451d8119b129bac7be00ff81df
Author: David Sommerseth
Date:   Fri May 8 13:42:43 2020 +0200

     options: Fix failing inline tls-auth/crypt with persist-key

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200508114243.15532-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19858.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


