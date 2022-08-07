Date: Sun, 7 Aug 2022 16:58:46 +0200 (CEST)
Message-Id: <202208071458.277Ewk1W003677@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220807100404.8618-1-a@...2181...>
References: <20220807100404.8618-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: turn supported ciphers
 list into a function
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

As this is really identical to 18/25 v1 (just offsets and context) I've
taken the ACK from Heiko, and not done very much testing of my own, just
one round of "client tests with DCO in kernel" (unchanged).

Your patch has been applied to the master branch.

commit f9aafa3580a84e2e74a220e6482170130f43bc81
Author: Antonio Quartulli
Date:   Sun Aug 7 12:04:04 2022 +0200

     dco: turn supported ciphers list into a function

     Signed-off-by: Lev Stipakov <lev@...515...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220807100404.8618-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24835.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


