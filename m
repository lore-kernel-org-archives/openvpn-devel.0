Date: Tue, 20 May 2014 11:02:39 +0200 (CEST)
Message-Id: <201405200902.s4K92d8I007508@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1399589436-8730-3-git-send-email-james@...515...>
References: <1399589436-8730-3-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: In socket.c,
	fixed issue where uninitialized value (err) is being passed to to
	gai_strerror.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the release/2.3 branch only.

This code is not present in "master" (most likely due to the dual-stack 
refactoring).

commit 302655c98503850765f860951a2b80280bc17385
Author: James Yonan
Date:   Thu May 8 16:50:32 2014 -0600

     In socket.c, fixed issue where uninitialized value (err) is being passed to to gai_strerror.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1399589436-8730-3-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8713
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


