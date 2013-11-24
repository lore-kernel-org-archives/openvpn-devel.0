Date: Sun, 24 Nov 2013 13:05:20 +0100
Message-Id: <201311241205.rAOC5KNd016662@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385236624-3776-1-git-send-email-arne@...1227...>
References: <1385236624-3776-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Split the PROTO_UDP_xx options
	into AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.
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

ACK.

I have fixed a few bits of whitespace, and one occurrence of proto2ascii()
where the second parameter wasn't "proto.af".

Patch with those changes has been applied to the master branch.

commit 30077d1f415b8dc9bd7c8a1ac6a7585136ac6261 (master)

Author: Arne Schwabe
Date:   Sat Nov 23 20:57:04 2013 +0100

     Split the PROTO_UDP_xx options into AF_INET/AF_INET6 and PROTO_TCP/PROTO_UDP part.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385236624-3776-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8043
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


