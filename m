Date: Sat, 13 Aug 2022 14:42:42 +0200 (CEST)
Message-Id: <202208131242.27DCgga1048291@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220813120428.6767-1-a@...2181...>
References: <20220813120428.6767-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: do_close_tun: get rid of one
 level of indentation
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

Side note: Arne has changed quite a few functions in this way during
TLS/Frame stuff refactorings, so this is "the agreed way" to handle
"we can not do anything here if this is not true" clauses.

Mildly tested on FreeBSD client.

Your patch has been applied to the master branch.

commit c05a0502b168fbb1b3b3b1071cee6b7e435cfb89
Author: Antonio Quartulli
Date:   Sat Aug 13 14:04:28 2022 +0200

     do_close_tun: get rid of one level of indentation

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220813120428.6767-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24908.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


