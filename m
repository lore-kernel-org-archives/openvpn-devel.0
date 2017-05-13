Date: Sat, 13 May 2017 20:17:16 +0200 (CEST)
Message-Id: <201705131817.v4DIHG9I006125@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494552754-30060-1-git-send-email-selva.nair@...277...>
References: <1494552754-30060-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Pass correct buffer size to
	GetModuleFileNameW()
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

ACK, thanks.  (No tests run whatsoever, but we've had a discussion about
that on the security@ lists, and there was agreement that _countof is 
the thing to use - just nobody did it before, so thanks again :-) ).

Your patch has been applied to the master and release/2.4 branch.

Release/2.3 has "MAX_PATH" instead of sizeof or _countof, which is 
actually correct (but in contrast, it has no error checking for 
GetModuleFileNameW()...)

commit 986b930862c7fecb2a42645f1dc23a53ab2cf6bb (master)
commit 9092397ce02616b06c5c748de0b45775c7aa1e73 (release/2.4)
Author: Selva Nair
Date:   Thu May 11 21:32:34 2017 -0400

     Pass correct buffer size to GetModuleFileNameW()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1494552754-30060-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14647.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


