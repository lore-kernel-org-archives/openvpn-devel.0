Date: Mon, 11 Jul 2016 22:23:39 +0200 (CEST)
Message-Id: <201607112023.u6BKNdGp097552@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1467149700-10042-1-git-send-email-steffan@...1856...>
References: <1467149700-10042-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add options to restrict cipher
	negotiation
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

Another ACK from me.  This is fairly trivial (compared to 3/5, at least).

As a side note: as discussed on IRC, the extra copy of ciphername and
authname in c1.* is needed because "this is what is in the initial config"
and the variables in "options->*" might be overwritten by PUSH_REPLY
(I was confused, others might be as well, spelling it out here).

Your patch has been applied to the master branch.

commit d728ebeda8c94fe401dc41b9fbda682ea0d780c9
Author: Steffan Karger
Date:   Tue Jun 28 23:35:00 2016 +0200

     Add options to restrict cipher negotiation

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1467149700-10042-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/12008
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


