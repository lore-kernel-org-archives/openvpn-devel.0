Date: Sun, 22 Nov 2015 17:24:47 +0100 (CET)
Message-Id: <201511221624.tAMGOlvQ030539@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447728489-14991-1-git-send-email-selva.nair@...277...>
References: <1447728489-14991-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle ctrl-C and ctrl-break
	events on Windows
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

ACK, on the basis that the code looks reasonable, solves a real problem
on Win32 and does not affect other platforms.  I have *not* tested it

Your patch has been applied to the master and release/2.3 branch.

commit 87f1be66e88303c51520925f169dc5a8aa58a7f2 (master)
commit 29f883fb31b362ffa21f11b672f3f4ea638c360e (release/2.3)

Author: Selva Nair
Date:   Mon Nov 16 21:48:09 2015 -0500

     Handle ctrl-C and ctrl-break events on Windows

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1447728489-14991-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10513
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


