Date: Sun, 6 Mar 2016 10:13:29 +0100 (CET)
Message-Id: <201603060913.u269DTRY045751@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1457241559-23374-1-git-send-email-selva.nair@...277...>
References: <1457241559-23374-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix interactive service
	ignoring stop command if openvpn is running
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

https://msdn.microsoft.com/en-us/library/windows/desktop/ms682396(v=vs.85).aspx
explains the behaviour described in trac#666 (only a single thread is 
stopping, all the rest does not receive the event due to auto-reset 
behaviour).

I'm not sure if the ResetEvent() call is actually needed but it's certainly
good style to acknowledge in the master thread after all clients are done.

Your patch has been applied to the master branch.

commit 239d09938b300f8eafa12bfb8c43373f0215f7bd
Author: Selva Nair
Date:   Sun Mar 6 00:19:19 2016 -0500

     Fix interactive service ignoring stop command if openvpn is running

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1457241559-23374-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11317
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


