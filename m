Date: Thu, 17 Mar 2022 13:44:41 +0100 (CET)
Message-Id: <202203171244.22HCifqS067398@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220223080628.4773-1-a@...2181...>
References: <20220223080628.4773-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: use
 OPENVPN_ETH_ALEN instead of ETH_ALEN
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

Acked-by: Gert Doering <gert@...1296...>

Change makes sense, brings no behavioural change.

Your patch has been applied to the master and release/2.5 branch.

commit 8d487b4cc5b896cff5277adef6dd491b5918381f (master)
commit 445cc852727a59f7338e59f0e594714d2b722beb (HEAD -> release/2.5)
Author: Antonio Quartulli
Date:   Wed Feb 23 09:06:28 2022 +0100

     networking: use OPENVPN_ETH_ALEN instead of ETH_ALEN

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220223080628.4773-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23882.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


