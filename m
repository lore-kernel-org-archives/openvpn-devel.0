Date: Thu, 17 Mar 2022 12:38:50 +0100 (CET)
Message-Id: <202203171138.22HBcow3065632@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220314131356.11577-1-a@...2181...>
References: <20220314131356.11577-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: drop useless netmask
 variable
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

Trivial change, obviously correct.  I *did* test-compile this :-) but
did not actually test any iroute stuff (that will come next in the 
"DCO server" testbed).

Your patch has been applied to the master branch.

commit 07be493796250ad680a4a41c26e19c1938bf37ce
Author: Antonio Quartulli
Date:   Mon Mar 14 14:13:56 2022 +0100

     options: drop useless netmask variable

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220314131356.11577-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23941.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


