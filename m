Date: Fri, 24 Feb 2017 20:59:54 +0100 (CET)
Message-Id: <201702241959.v1OJxsqt074557@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170224135222.44640-1-gert@...1296...>
References: <20170224135222.44640-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix '--dev null'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.4 branch.

As ordered, '||' have been moved to pos_arith=lead, and the tab 
has been extabinated.

commit 22c5381b71710ad0e1dbbccc1d5680fccb602311 (master)
commit 2085c1f3875b9c96ac739941712247b805677efa (release/2.4)
Author: Gert Doering
Date:   Fri Feb 24 14:52:22 2017 +0100

     Fix '--dev null'

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170224135222.44640-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14186.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


