Date: Tue, 6 Dec 2016 21:37:21 +0100 (CET)
Message-Id: <201612062037.uB6KbLtU022073@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480707729-19578-1-git-send-email-selva.nair@...277...>
References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Correctly state the default
	dhcp server address in man page
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

ACK.  Because it makes documentation match code.

(This particular part of code needs to get some sanity, but this won't
happen before 2.4.0)

Your patch has been applied to the master and release/2.3 branch.

commit 251cc8f2042cc0cb8281230f7fb33f2cdec5b809 (master)
commit a1b9e4c1ac4ea1ebccf485ba2eaeb9745ef88cae (release/2.3)
Author: Selva Nair
Date:   Fri Dec 2 14:42:09 2016 -0500

     Correctly state the default dhcp server address in man page

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480707729-19578-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13387.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


