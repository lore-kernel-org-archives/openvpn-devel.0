Date: Wed, 23 Jul 2025 17:00:03 +0200 (CEST)
Message-Id: <202507231500.56NF03eu028897@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723133918.19431-1-gert@...1296...>
References: <20250723133918.19431-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: only pass struct context
 to init function
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Rarely I have seen a single ("simple!") patch cause *so* much build break
e-mails... :-o - but anyway, v4 is good now, and passes compile on all
platforms.  It also passes actual client/server testing with DCO on 
Linux, and my critical stare-at-code test...

Your patch has been applied to the master branch.

commit a699681bb86c6e9a2c9f205543f60400208aea4b
Author: Antonio Quartulli
Date:   Wed Jul 23 15:39:11 2025 +0200

     dco: only pass struct context to init function

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723133918.19431-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32293.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


