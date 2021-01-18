Date: Mon, 18 Jan 2021 20:03:54 +0100 (CET)
Message-Id: <202101181903.10IJ3s0Q052676@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201224115910.10129-1-domagoj@...2540...>
References: <20201224115910.10129-1-domagoj@...2540...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove 1 second delay before
 running netsh
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
To: Domagoj Pensa <domagoj@...2540...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and releae/2.5 branch.

I have not tested it, not even test compiled - but if Lev says
it works, this is all we need :-)

(As a side note: this reduces the *retry* delay on an error from
5 seconds to 4 seconds now - which should not make any interesting
difference)

commit b1a8213ee3fe35a4617608ec7653e4dffea79207 (master)
commit e7641f9b53bb6075fe7be7d5e6d16378eabebabd (release/2.5)
Author: Domagoj Pensa
Date:   Thu Dec 24 12:59:10 2020 +0100

     Remove 1 second delay before running netsh

     Signed-off-by: Domagoj Pensa <domagoj@...2540...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20201224115910.10129-1-domagoj@...2540...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21405.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


