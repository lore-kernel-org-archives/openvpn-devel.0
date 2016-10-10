Date: Mon, 10 Oct 2016 10:55:07 +0200 (CEST)
Message-Id: <201610100855.u9A8t7ik006390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1475613736-1529-1-git-send-email-lstipakov@...277...>
References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compilation in pedantic mode
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

ACK.  I've decided to leave the whitespace changes as they were in your
patch ("git show -w" will confirm only whitespace and comments have been
changed), and changed the multiline comment to "leading *" style, as
discussed previously.

Your patch has been applied to the release/2.3 branch.

commit d72c3835e20593091d4d2c69466329f994b69ae6
Author: Lev Stipakov
Date:   Tue Oct 4 23:42:16 2016 +0300

     Fix compilation in pedantic mode

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1475613736-1529-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12600.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


