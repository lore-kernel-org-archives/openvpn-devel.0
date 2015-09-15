Date: Tue, 15 Sep 2015 11:57:15 +0200 (CEST)
Message-Id: <201509150957.t8F9vFRP078664@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1441985627-14822-5-git-send-email-gert@...1296...>
References: <1441985627-14822-5-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Create basic infrastructure for
	IPv6 default gateway handling / redirection.
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

Patch has been applied to the master branch, with an addition to 
openvpn.8 (see below).

commit d8a8656f1a8721f56a08439afe24916beadfef55
Author: Gert Doering
Date:   Fri Sep 11 17:33:41 2015 +0200

     Create basic infrastructure for IPv6 default gateway handling / redirection.

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1441985627-14822-5-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10087
     Signed-off-by: Gert Doering <gert@...1296...>


According to Arne's comment, openvpn.8 has been extended as follows, to
actually document --show-gateway

--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5616,6 +5616,15 @@ module will be queried.
 .B \-\-verb
 option can be used BEFORE this option to produce debugging information.
 .\"*********************************************************
+.SS Standalone Debug Options:
+.\"*********************************************************
+.TP
+.B \-\-show\-gateway [v6target]
+(Standalone)
+Show current IPv4 and IPv6 default gateway and interface towards the
+gateway (if the protocol in question is enabled).  If an IPv6 address
+is passed as argument, the IPv6 route for this host is reported.
+.\"*********************************************************
 .SS IPv6 Related Options
 .\"*********************************************************
 The following options exist to support IPv6 tunneling in peer-to-peer


--
kind regards,

Gert Doering


