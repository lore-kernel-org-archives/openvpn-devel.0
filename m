Date: Tue, 8 Nov 2016 11:20:21 +0100 (CET)
Message-Id: <201611081020.uA8AKLXt032846@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1478596632-22842-1-git-send-email-gert@...1296...>
References: <1478596632-22842-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check previously-unchecked
	buf_alloc_write() call in crypto self-test.
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

Patch has been applied to the master branch (with the offending space removed).

commit 63bdc6ce66a970f0584bbb1d4a8cae98b36ee831
Author: Gert Doering
Date:   Tue Nov 8 10:17:12 2016 +0100

     Check previously-unchecked buf_alloc_write() call in crypto self-test.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1478596632-22842-1-git-send-email-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12940.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


