Date: Mon, 25 Jul 2016 20:04:10 +0200 (CEST)
Message-Id: <201607251804.u6PI4A26036641@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1467149771-10374-1-git-send-email-steffan@...1856...>
References: <1467149771-10374-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add server-side support for
	cipher negotiation
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

Another ACK from me.

Stared at the code, tested it vs. iOS OpenVPN and 2.2/2.3/git master 
clients (works!), and we've discussed it quite a bit on IRC, so it finally
all made sense :-)

Testing this turned up something we need to fix: with the patch set 1-5 
enabled, and "delayed key init" active on the server, mssfix is broken 
("does not do anything") - and if setting "ncp-disable", mssfix works 
again.  Going back to commit d728ebeda8 (4/5 v4) on the server side makes 
mssfix on the server side work, but running it on the client it is still
broken - so I think it's related to the delayed initialization (though 
I have no idea yet what it is).  

Still applying this one, as it's not the culprit.

Your patch has been applied to the master branch.

commit a17aa98180319f34c3240aea617bf8114d0bcaf7
Author: Steffan Karger
Date:   Tue Jun 28 23:36:11 2016 +0200

     Add server-side support for cipher negotiation

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1467149771-10374-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/12009
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


