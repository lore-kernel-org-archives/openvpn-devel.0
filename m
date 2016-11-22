Date: Tue, 22 Nov 2016 17:33:22 +0100 (CET)
Message-Id: <201611221633.uAMGXMFq034557@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479814716-20116-1-git-send-email-arne@...1227...>
References: <1479814716-20116-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle DNS6 option on Android
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

ACK.  Code looks reasonable and straightforward (and even C99 :) ), 
but not having an Android build environment I can't say whether it 
compiles or even works :-) - it won't break anything else, though.

Your patch has been applied to the master branch.

commit 39b7d4da02c40e76640c4da96ef7da7a6354cc00
Author: Arne Schwabe
Date:   Tue Nov 22 12:38:36 2016 +0100

     Handle DNS6 option on Android

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479814716-20116-1-git-send-email-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13195.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


