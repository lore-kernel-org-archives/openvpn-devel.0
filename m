Date: Sat, 6 Aug 2022 12:33:02 +0200 (CEST)
Message-Id: <202208061033.276AX2Zt078451@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220805150837.8169-1-a@...2181...>
References: <20220805150837.8169-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: perform pull options check
 only if we pulled any option
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

We really want to check "pushed options", so we should do this when
we actually have --pull in our config :-)

Stared at code (ok), and tested on DCO build with DCO kernel, with the
three scenarios

  - client, normal operation -> works
  - client, with "--pull-filter ignore peer-id" (-> triggers message)
  - server, connecting clients -> annoying message is gone now

Your patch has been applied to the master branch.

commit f9ef554a5bda5c354e59261f9dbf6519e2815388
Author: Antonio Quartulli
Date:   Fri Aug 5 17:08:37 2022 +0200

     dco: perform pull options check only if we pulled any option

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220805150837.8169-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24824.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


