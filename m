Date: Fri, 24 May 2019 14:03:32 +0200 (CEST)
Message-Id: <201905241203.x4OC3W6N049150@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190524090236.10760-1-arne@...1227...>
References: <20190524090236.10760-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix poll.h logic in syshead.h
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Obvious oversight".  More configure silliness might be fixable, but 
this is like easy and direct :-) - smoke tested on FreeBSD.

Your patch has been applied to the master branch.

commit e077726c768c24809531a55332ae1e273f8e41c2
Author: Arne Schwabe
Date:   Fri May 24 11:02:36 2019 +0200

     Fix poll.h logic in syshead.h

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190524090236.10760-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18475.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


