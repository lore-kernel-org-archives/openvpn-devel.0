Date: Tue, 7 Jun 2016 22:53:36 +0200 (CEST)
Message-Id: <201606072053.u57KraKt036987@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465162884-32520-1-git-send-email-selva.nair@...277...>
References: <1465162884-32520-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add an option to filter options
	received from server
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

ACK.  Stared at the code, tested, works.

I like the way using a linked list actually made this code more simple 
(which hints that the previous version might not have been ideal, but 
anyway).

I'm not sure I agree with the style used in apply_pull_filter() - I might
have coded it as "first do the strncmp(), and if that matches, use a 
switch/case block for the rest" (avoid repeating the strnmcp(), and it's
actually minimally more effective as the current code always tests the 
filter type *and* strncmp()'s, while it could skip the filter type on 
no match) - but that is going very much into personal coding style land.

Your patch has been applied to the master branch.

commit 7f74c27e105a365d278181d00708c55a299398a0
Author: Selva Nair
Date:   Sun Jun 5 17:41:23 2016 -0400

     Add an option to filter options received from server

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465162884-32520-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11808
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


