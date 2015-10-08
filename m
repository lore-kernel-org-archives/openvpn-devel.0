Date: Thu, 8 Oct 2015 10:12:42 +0200 (CEST)
Message-Id: <201510080812.t988CggU011619@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1444148440-10564-1-git-send-email-steffan@...1856...>
References: <1444148440-10564-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: polarssl: Improve PolarSSL
	logging
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

ACK.  Lots of small changes, but they all look correct to me, and make
the code in total easier to read (at least, if the reader understands
what polar_ok() does :-) ).

Your patch has been applied to the master branch.

commit d17d362dfec1abc5bedcea2f1154470018c82eca
Author: Steffan Karger
Date:   Tue Oct 6 18:20:40 2015 +0200

     polarssl: Improve PolarSSL logging

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1444148440-10564-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10197
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


