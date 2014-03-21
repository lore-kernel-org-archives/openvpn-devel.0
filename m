Date: Fri, 21 Mar 2014 19:29:07 +0100 (CET)
Message-Id: <201403211829.s2LIT7h4010115@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-2-git-send-email-arne@...1227...>
References: <1395407925-25518-2-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix connecting to localhost on
	Android
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

Patch has been applied to the master branch.

(It's only affecting #ifdef ANDROID, and if you tell me it needs it, that's
good enough for me)

commit 5118787158eb6fafa3bfef9cb87acb1c76264a90
Author: Arne Schwabe
Date:   Fri Mar 21 14:18:34 2014 +0100

     Fix connecting to localhost on Android

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-2-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8375
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


