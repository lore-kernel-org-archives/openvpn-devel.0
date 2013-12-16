Date: Mon, 16 Dec 2013 19:02:50 +0100 (CET)
Message-Id: <201312161802.rBGI2oU6025368@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1384209366-26170-1-git-send-email-alon.barlev@...277...>
References: <1384209366-26170-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: pkcs11: use generic evp key
	instead of rsa
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branch.

(I have not actually tested that it *works* - my gentoo system only
installs pkcs11-helper 1.10, which isn't sufficient for --enable-pkcs11
with this patch.  So I just tested that it doesn't break default compiles)

commit 6575ad483702dd53c0f683093b5f26a87518c6a8 (master)
commit f8b590d5a6692324a8cb8522ddc598358a215ac5 (release/2.3)

Author: Alon Bar-Lev
Date:   Tue Nov 12 00:36:06 2013 +0200

     pkcs11: use generic evp key instead of rsa

     Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1384209366-26170-1-git-send-email-alon.barlev@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7960
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


