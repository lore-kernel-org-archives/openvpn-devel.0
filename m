Date: Sat, 11 Jun 2016 20:15:06 +0200 (CEST)
Message-Id: <201606111815.u5BIF6Dq077959@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465656195-12722-1-git-send-email-arne@...1227...>
References: <1465656195-12722-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: ] Remove http-proxy-timeout,
	socks timeout and set default of server-poll-timeout to 120s
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Stared at the code for a while, and went out testing it
(also, we got a feature-ACK for that waaay back in Munich already).

I have added a note to Changes.rst explaining the change, and how to
get back the old default behaviour of a 10s timeout on TCP connects.

Your patch has been applied to the master branch.

commit f2134b7bea37df15756c599b94f16d4bffafbbd6
Author: Arne Schwabe
Date:   Sat Jun 11 16:43:15 2016 +0200

     Remove http-proxy-timeout, socks timeout and set default of server-poll-timeout to 120s

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465656195-12722-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11899
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


