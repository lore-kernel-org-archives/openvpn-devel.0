Date: Thu, 29 Jun 2017 20:47:11 +0200 (CEST)
Message-Id: <201706291847.v5TIlBVS057051@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170627222029.26623-1-steffan@...1856...>
References: <20170627222029.26623-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Undo cipher push in client
 options state if cipher is rejected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

ACK.  Counting in Arne's ACK as well, as v2 is basically the same actual
code change, and the "const" change does not have any further effect 
("options" is not const in the callers).

Your patch has been applied to the master and release/2.4 branch.

commit 3be9a1c1cd75627c30dca05bed28c84ad4dc1d37 (master)
commit e050c762e2bd3695275ee675f197f062c63e2b6f (release/2.4)
Author: Steffan Karger
Date:   Wed Jun 28 00:20:29 2017 +0200

     Undo cipher push in client options state if cipher is rejected

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170627222029.26623-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14984.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


