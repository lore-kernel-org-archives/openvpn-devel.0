Date: Sat, 2 Apr 2016 22:36:54 +0200 (CEST)
Message-Id: <201604022036.u32Kasbn073984@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1459528980-8304-1-git-send-email-steffan@...1856...>
References: <1459528980-8304-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix potential null-pointer
	dereference
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK - "because it obviously makes sense" :-) - thanks.

Your patch has been applied to the master branch.

I have added a note to credit the bug spotter (Daniel Hirche).

commit b064b8111c718f3c4f996f256674ccd3ab62217f
Author: Steffan Karger
Date:   Fri Apr 1 18:43:00 2016 +0200

     Fix potential null-pointer dereference

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1459528980-8304-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11372
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


