Date: Mon, 9 Jan 2023 17:04:29 +0100 (CET)
Message-Id: <202301091604.309G4Tnh022030@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230107162558.59659-1-gert@...1296...>
References: <20230107162558.59659-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Undo FreeBSD 12.x workaround on
 IPv6 ifconfig for 12.4 and up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review and for fixing my fat fingers :-)

Patch has been applied to the master and release/2.6 branch.

commit 16d7f2cd4d904274580b2f031e92dde2f7f260c9 (master)
commit d9906d1523a8ed46fce81cb8d559279e345bf849 (release/2.6)
Author: Gert Doering
Date:   Sat Jan 7 17:25:58 2023 +0100

     Undo FreeBSD 12.x workaround on IPv6 ifconfig for 12.4 and up

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230107162558.59659-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25911.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


