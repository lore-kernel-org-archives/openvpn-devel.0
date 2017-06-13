Date: Tue, 13 Jun 2017 11:28:57 +0200 (CEST)
Message-Id: <201706130928.v5D9SvC1071105@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1495461253-20111-1-git-send-email-steffan.karger@...1435...>
References: <1495461253-20111-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: openssl: fix overflow check for
 long --tls-cipher option
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK ("stared at code").  

Have no ASAN setup here so replicating the original problem involved
a bit of extra msg()'ing and then scratching my head, but I can confirm
that the original math ended up with an integer underflow / unsigned,
and the comarison not firing...

Your patch has been applied to the master, release/2.4 and release/2.3 branch.

commit e6bf7e033d063535a4414a4cf49c8f367ecdbb4f (master)
commit b52c1ff43b23c3cf438fb99b807a7309d3229a56 (release/2.4)
commit 236807276368514f8ab80155f440a1d377ab412b (release/2.3)
Author: Steffan Karger
Date:   Mon May 22 15:54:13 2017 +0200

     openssl: fix overflow check for long --tls-cipher option

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1495461253-20111-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14716.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


