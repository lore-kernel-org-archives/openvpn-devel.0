Date: Sun, 13 Nov 2016 19:22:55 +0100 (CET)
Message-Id: <201611131822.uADIMt73008075@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474085439-28766-2-git-send-email-selva.nair@...277...>
References: <1474085439-28766-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support --block-outside-dns on
	multiple tunnels
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

The patch is basically the same as the previously-acked master patch
(plus code cleanups).

I have only reviewed this one, and not built a test installer and tested
it - I'll go test the snapshot as soon as buildbot makes one for me, but
given that the code changes are quite similar, I expect no surprises.

Your patch has been applied to the release/2.3 branch.

commit f65f85275aeee79ebfdee5e1e00008b6f6508106
Author: Selva Nair
Date:   Sat Sep 17 00:10:39 2016 -0400

     Support --block-outside-dns on multiple tunnels

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474085439-28766-2-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12466.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


