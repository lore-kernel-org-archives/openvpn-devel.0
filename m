Date: Tue, 6 Oct 2015 13:20:57 +0200 (CEST)
Message-Id: <201510061120.t96BKvJ5098296@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1444130113-23387-1-git-send-email-lstipakov@...277...>
References: <1444130113-23387-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Continuation of MSVS fixes
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  The need for this change was expected (because GetIpRoute2() is not
part of the "XP" API but needs VISTA), and thanks for testing that the
*rest* of the new stuff actually works on a MSVC build :-)

Your patch has been applied to the master branch.

commit b0fe94115fc4a75094d15452b7b89a0c0849087c
Author: Lev Stipakov
Date:   Tue Oct 6 14:15:13 2015 +0300

     Continuation of MSVS fixes

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1444130113-23387-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10194
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


