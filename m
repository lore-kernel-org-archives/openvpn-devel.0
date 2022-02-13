Date: Sun, 13 Feb 2022 11:42:15 +0100 (CET)
Message-Id: <202202131042.21DAgF5W047495@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220207155757.22314-1-a@...2181...>
References: <20220207155757.22314-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: Get rid of README.IPv6 and
 TODO.IPv6
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

What Antonio says.  We have reached the stage where IPv6 is "just normal",
so no need for a special README.IPv6 anymore :-)  (or so we claim).

We might introduce a README.IPv4 at some point... ("yes, we do still
support this old stuff").  But maybe implement IPX first?  ;-)

Your patch has been applied to the master branch.

commit 9cc7e32827bdb778970eb6231d319b0f18fb56c6
Author: Antonio Quartulli
Date:   Mon Feb 7 16:57:57 2022 +0100

     Get rid of README.IPv6 and TODO.IPv6

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220207155757.22314-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23729.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


