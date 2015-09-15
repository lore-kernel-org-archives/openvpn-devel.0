Date: Tue, 15 Sep 2015 13:05:47 +0200 (CEST)
Message-Id: <201509151105.t8FB5lGC079049@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1442309019-7586-4-git-send-email-arne@...1227...>
References: <1442309019-7586-4-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't redirect the gateway on
	Android even if requested
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

Argh, too fast...

"ACK!"

And I expect we'll need a similar patch for the IPv6 routing bits, as soon 
as they are fully merged - the code is not needed on Android, and the best
thing it can do is "get in the way", so #ifndef is good :)


Your patch has been applied to the master branch.

(I've taken the liberty to replace the UTF-8 apostroph in "Don't" with
a 7 bit one... still living in ISO8859-1 land and this messes up my 
terminals :) )

commit ad80d6779488e77bc81f395f61d4052184f9a589

Author: Arne Schwabe
Date:   Tue Sep 15 11:23:34 2015 +0200

     Don?t redirect the gateway on Android even if requested

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1442309019-7586-4-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10113
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


