Date: Tue, 5 Nov 2024 22:22:31 +0100 (CET)
Message-Id: <202411052122.4A5LMV3h095412@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <f8845c0c5aa74e5bab537463249a251d@...2828...>
References: <f8845c0c5aa74e5bab537463249a251d@...2828...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add calls to nvlist_destroy to
 avoid leaks
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
To: remi.farault@...2828...
Cc: openvpn-devel@lists.sourceforge.net

Thanks for that patch, and for sending a typo-fixed v2.  I did ask
for changes to the commit message which were not done :-( - so I added
the SOB, Github reference plus a bit more explanatory text (from the 
GH MR) myself.

Kristof approved in the GH MR, and I reviewed and tested the change
myself (FreeBSD 14, server and client tests) and things look good -
so recording Kristof's ACK and adding mine.

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit dee0748a1e0f57c326cf2b83f8499998ac9d1187 (master)
commit a5d2544ca3a95eba0127ab9cc8a8277fd1d1f974 (release/2.6)
Author: Rémi Farault
Date:   Tue Oct 29 12:06:35 2024 +0100

     Add calls to nvlist_destroy to avoid leaks

     Signed-off-by: Rémi Farault <remi.farault@...2828...>
     Acked-by: Kristof Provost <kp@...1249...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <f8845c0c5aa74e5bab537463249a251d@...2828...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29701.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


