Date: Fri, 12 Nov 2021 17:08:49 +0100 (CET)
Message-Id: <202111121608.1ACG8njk095596@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211109015927.311-1-lstipakov@...277...>
References: <20211109015927.311-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use network address for
 emulated DHCP server as a default
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Not sure, really, why this did not get enough traction 5 years ago... so
thanks for pushing it :-) - and I understand that Selva did not want to
ACK it.

I have not tested it, just stared a bit at the code (fine) and test
compiled on MinGW (also fine).

Getting rid of the if() statement in tun.c is okay, though the 
resulting line is violating our line length... this is a big ugly.
(Also, just passing in "tt->options.dhcp_masq_offset" always (as it 
defaults to "0") would do the job fine now...)

Your patch has been applied to the master and release/2.5 branch.

commit 7df6583d76fc2ff485186ede75f00c9b7dc3e42c (master)
commit 93e4f286b906391a21697e44a02a00b871b977ba (release/2.5)
Author: Lev Stipakov
Date:   Tue Nov 9 03:59:27 2021 +0200

     Use network address for emulated DHCP server as a default

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211109015927.311-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23156.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


