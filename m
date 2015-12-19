Date: Sat, 19 Dec 2015 14:24:18 +0100 (CET)
Message-Id: <201512191324.tBJDOIq5092171@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1450525169-12961-1-git-send-email-steffan@...1856...>
References: <1450525169-12961-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Upgrade OpenVPN 2.3 to PolarSSL
	1.3
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

ACK, based on

 - most of the changes are fairly mechanical (cert->crt, rsa->pk, and so on)
 - some of the larger "changes" are mostly whitespace changes, and the
   actual change makes sense (using features of 1.3 not available before)
 - I remember (and ACKed) half of the other changes from master
 - not touching stuff outside PolarSSL
 - and works for my tests built with 1.3(.9) :-)

Your patch has been applied to the release/2.3 branch.

I have added the change to Changes.rst, and committed that separately.

commit a40b2304fe967053debb4249704a344223707c96 (release/2.3)

Author: Steffan Karger
Date:   Sat Dec 19 12:39:28 2015 +0100

     Upgrade OpenVPN 2.3 to PolarSSL 1.3

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1450525169-12961-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10856
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


