Date: Wed, 30 Nov 2016 19:45:27 +0100 (CET)
Message-Id: <201611301845.uAUIjRUq069167@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480470535-6287-1-git-send-email-selva.nair@...277...>
References: <1480470535-6287-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Map restart signals from event
	loop to SIGTERM during exit-notification wait
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Same (reproduceable) problem, similar fix, good :-)

Your patch has been applied to the release/2.3 branch.

commit 4d397fcbc023271c7117cb83b13114389bf3265b
Author: Selva Nair
Date:   Tue Nov 29 20:48:55 2016 -0500

     Map restart signals from event loop to SIGTERM during exit-notification wait

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480470535-6287-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13310.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


