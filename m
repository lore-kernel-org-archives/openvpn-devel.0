Date: Fri, 4 Nov 2016 10:39:44 +0100 (CET)
Message-Id: <201611040939.uA49diRR035965@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478208503-25929-1-git-send-email-lstipakov@...277...>
References: <1478208503-25929-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Drop recursively routed packets
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
To: Lev Stipakov <lev.stipakov@...2164...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (finally).

Tested with tun+tap for proper recursion drops on v4+v6 (works, though
on tap it's sometimes non-trivial to reproduce as you need an valid ARP
entry first...), and with all I have for client or server side breakage 
(tun, tap, p2mp, p2p, --inetd, ...) - no breakage.

Your patch has been applied to the master and release/2.3 branch.

I've taken the liberty to add trac#642 to the commit message, fix
an indentation oversight in proto.h, shorten the Changes.rst lines 
somewhat, and adjust 2.3 Changes.rst to "2.3 style" :-)

commit e8c42658ff8df10ad56659788a73900648b9d92d (master)
commit 748974b960a099ef4fdf083f25226659775603b9 (release/2.3)

Author: Lev Stipakov
Date:   Thu Nov 3 23:28:23 2016 +0200

     Drop recursively routed packets

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1478208503-25929-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12894.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


