Date: Fri, 13 Nov 2015 09:50:48 +0100 (CET)
Message-Id: <201511130850.tAD8om0e028815@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447242487-30243-1-git-send-email-lstipakov@...277...>
References: <1447242487-30243-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use adapter index instead of
	name
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, and thanks for your patience.

Your patch has been applied to the master and release/2.3 branch.

I have reformatted and updated the commit message a bit for readability,
and added a NOTE: about the temporary variable.

commit efeaf947c9c5c88d77d16ac4917c1350c447c8dc (master)
commit e2afbdb61392e750cfc54cc2ac9d08e5b6db4794 (release/2.3)

Author: Lev Stipakov
Date:   Wed Nov 11 13:48:07 2015 +0200

     Use adapter index instead of name for windows IPv6 interface config

     Signed-off-by: Olli Mannisto <olmannisto@...277...>
     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1447242487-30243-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10484
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


