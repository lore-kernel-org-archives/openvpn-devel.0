Date: Fri, 16 Aug 2013 17:41:39 +0200
Message-Id: <201308161541.r7GFfdMM007250@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1375049135-21444-1-git-send-email-james@...515...>
References: <1375049135-21444-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: MSVC fixes
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

patch has been applied to the master branch (not to release/2.3, as it's
fixing code that does not exist in 2.3).  Sorry for making a mess with
the multi_output_peer_info_env() stuff... still trying to find my way.

commit 46e02127a44270c7199f458f43807bff2ddb11f3
Author: James Yonan
Date:   Sun Jul 28 16:05:35 2013 -0600

     MSVC fixes

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1375049135-21444-1-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7777
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


