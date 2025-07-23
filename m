Date: Wed, 23 Jul 2025 10:15:05 +0200 (CEST)
Message-Id: <202507230815.56N8F5D1016920@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250723062012.22781-1-gert@...1296...>
References: <20250723062012.22781-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: fix case statement
 by using proper error value
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

Stared at the code, makes sense.  Test compiled (after the explosion tonight,
you can never test enough :-) ).

Your patch has been applied to the master branch.

commit f1a2a37897a6517c4c321abb7bc343bf495c94e2
Author: Antonio Quartulli
Date:   Wed Jul 23 08:20:06 2025 +0200

     dco_linux: fix case statement by using proper error value

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250723062012.22781-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32269.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


