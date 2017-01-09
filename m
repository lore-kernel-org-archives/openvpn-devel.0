Date: Mon, 9 Jan 2017 20:50:10 +0100 (CET)
Message-Id: <201701091950.v09JoAtW076141@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1483475883-17450-1-git-send-email-selva.nair@...277...>
References: <1483475883-17450-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Always release dhcp address in
	close_tun()
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

ACK.  This change enforces good manners, as we do on all other platforms
- ensure the IP address is released/removed when we release the interface
(some platforms do not have code for that because it's automatic, others
have).  Having an extra not-very-well-known option for this is a bit
peculiar.

I have changed the commit message as requested, and also changed the
tile line to add "... on Windows", to make clear this is platform specific.

Your patch has been applied to the master and release/2.4 branch.

commit db5b9b45508ea8f66ea80565279af3edd9300499 (master)
commit 139cd1b14c57501bee36c1ec1dc5a037617ec29e (release/2.4)
Author: Selva Nair
Date:   Tue Jan 3 15:38:03 2017 -0500

     Always release dhcp address in close_tun() on Windows.

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1483475883-17450-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13814.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


