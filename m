Date: Thu, 7 Jan 2016 11:22:27 +0100 (CET)
Message-Id: <201601071022.u07AMRcU044993@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1452158116-17363-1-git-send-email-steffan.karger@...1435...>
References: <1452158116-17363-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: polarssl: optimize polar_ok()
	for non-errors
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Slightly more work for the compiler, but supposedly they are smarter
these days :-) - and actually slightly easier to read than v1.

Your patch has been applied to the master branch.

commit 3a39bf7dfe5a57fe8bc43c073b2a009bb6994e78
Author: Steffan Karger
Date:   Thu Jan 7 10:15:16 2016 +0100

     polarssl: optimize polar_ok() for non-errors

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1452158116-17363-1-git-send-email-steffan.karger@...1435...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10949
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


