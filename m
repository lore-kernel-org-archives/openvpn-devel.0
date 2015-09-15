Date: Tue, 15 Sep 2015 13:34:35 +0200 (CEST)
Message-Id: <201509151134.t8FBYZLV079264@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442309019-7586-3-git-send-email-arne@...1227...>
References: <1442309019-7586-3-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove #ifdefs for client nat
	support.
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

ACK.  I can't remember when we discussed this (some IRC meeting), but as
this is always enabled anyway, and all the #ifdefs are really hurting the
eyes, away with it :-)

(I admit I have never used it and have no idea what nice stuff one can
do with it... should set up a test case for it!)

Your patch has been applied to the master branch.

commit 8db23a57c878abd5b01c784c7db570176de555ef
Author: Arne Schwabe
Date:   Tue Sep 15 11:23:33 2015 +0200

     Remove #ifdefs for client nat support.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1442309019-7586-3-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10109
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


