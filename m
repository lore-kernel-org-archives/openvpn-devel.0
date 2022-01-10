Date: Mon, 10 Jan 2022 17:59:50 +0100 (CET)
Message-Id: <202201101659.20AGxoBq034973@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220107123550.188-1-lstipakov@...277...>
References: <20220107123550.188-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: auth_token.c: add NULL
 initialization
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

I have not done real testing, as it's quite obvious what it's doing :)

commit 4b6073b8253dafeb425361fb55bab0f2cdc5474f (master)
commit 813d1ee3c8b6a914599e4705eee3b8835d606e4b (release/2.5)
Author: Lev Stipakov
Date:   Fri Jan 7 14:35:50 2022 +0200

     auth_token.c: add NULL initialization

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220107123550.188-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23511.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


