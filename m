Date: Tue, 20 May 2014 11:09:43 +0200 (CEST)
Message-Id: <201405200909.s4K99hDE014606@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1399589436-8730-5-git-send-email-james@...515...>
References: <1399589436-8730-5-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: MSVC 2008 doesn't support
	dimensioning an array with a const var nor using %z as a
	printf format specifier.
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

ACK.

Your patch has been applied to the release/2.3 branch only.

"master" already has the change, as part of 46e02127

commit 11fbe93b08180acddc8ac301e6eff6553b9f78e1
Author: James Yonan
Date:   Thu May 8 16:50:34 2014 -0600

     MSVC 2008 doesn't support dimensioning an array with a const var nor using %z as a printf format specifier.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1399589436-8730-5-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8710
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


