Date: Sat, 8 Aug 2015 15:07:49 +0200 (CEST)
Message-Id: <201508081307.t78D7ns8026133@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1438859835-3977-1-git-send-email-arne@...1227...>
References: <1438859835-3977-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Show extra-certs in current
	parameters, fix clang warning and logic error in preresolve
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

ACK.

Your patch has been applied to the master and release/2.3 branch
(release/2.3 only gets the - trivial - SHOW_STR() chunk, the bugfix
for --preresolve does not apply and isn't needed anyway)

commit 291c227d2ccecaa92602eaa5259a23c7093e30e5 (master)
commit d7ab314c57a0b851e0e714c903c2bc5ececac3ae (release/2.3)

Author: Arne Schwabe
Date:   Thu Aug 6 13:17:15 2015 +0200

     Show extra-certs in current parameters, fix clang warning and logic error in preresolve

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1438859835-3977-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10005
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


