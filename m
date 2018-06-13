Date: Wed, 13 Jun 2018 15:12:32 +0200 (CEST)
Message-Id: <201806131312.w5DDCWZo008952@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180613122824.4207-2-a@...2181...>
References: <20180613122824.4207-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: ensure gc and argv are
 properly handled
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Proper code hygiene"... thanks.  "Stared at code" plus run on a few
platforms, including AIX ("because I can!").

Your patch has been applied to the master branch.

commit 18225f0fd5c45164308d4d66db055a1ad3960887
Author: Antonio Quartulli
Date:   Wed Jun 13 20:28:22 2018 +0800

     tun: ensure gc and argv are properly handled

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180613122824.4207-2-a@...2181...>
     URL: https://www.mail-archive.com/search?l=mid&q=20180613122824.4207-2-a@...2181...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


