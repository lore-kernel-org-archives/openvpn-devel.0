Date: Mon, 20 Mar 2023 18:57:45 +0100 (CET)
Message-Id: <202303201757.32KHvjTh071877@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230318141330.1315235-1-selva.nair@...277...>
References: <20230318141330.1315235-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve error message on short
 read from socks proxy
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks, this change makes sense.  I have not actively tried to provoke
it (like, by connecting to a "fake SOCKS server" that will trigger it),
but the change is obviously an improvement to "if it's not ==1, it 
must be a TCP error!").

I do test the SOCKS code in my t_client runs, but all my SOCKS servers
are well-behaved (and the regular t_client cannot handle "expect failure" 
cases anyway).  Room for improvement.

So, I've tested this on a regular client using a well-behaved SOCKS
proxy, and as expected, "it does not break anything" :-)

Your patch has been applied to the master and release/2.6 branch.

commit 172640189277c940439d24fd31a59b8faffd0b3e (master)
commit c20a15844829a186b4d5256b0e8d76b8eb074845 (release/2.6)
Author: Selva Nair
Date:   Sat Mar 18 10:13:30 2023 -0400

     Improve error message on short read from socks proxy

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230318141330.1315235-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26437.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


