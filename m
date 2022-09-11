Date: Sun, 11 Sep 2022 18:12:41 +0200 (CEST)
Message-Id: <202209111612.28BGCfF9036216@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220818144431.208337-1-a@...2181...>
References: <20220818144431.208337-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: trigger ping timeout event
 only if the peer expired
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

"This seems to make sense" :-)  (aka, do what the commit message says)

Tested on the Ubuntu/DCO client/server test bench.

Your patch has been applied to the master branch.

commit a179d788c77d537b3a302320ebc476ca412c4e44
Author: Antonio Quartulli
Date:   Thu Aug 18 16:44:31 2022 +0200

     dco: trigger ping timeout event only if the peer expired

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220818144431.208337-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25000.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


