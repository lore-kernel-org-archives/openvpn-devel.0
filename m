Date: Wed, 13 Jul 2022 12:27:40 +0200 (CEST)
Message-Id: <202207131027.26DARe66071279@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220711122348.8756-1-a@...2181...>
References: <20220711122348.8756-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: don't export local
 function pre_connect_save()
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

"git show --color-moved=zebra" is very clear on this :-) - so I did not
bother to do more testing than "does it really still compile?"

Your patch has been applied to the master branch.

commit ad085464b15d63324846d0a5151141f58ccb5a34
Author: Antonio Quartulli
Date:   Mon Jul 11 14:23:48 2022 +0200

     options: don't export local function pre_connect_save()

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20220711122348.8756-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24666.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


