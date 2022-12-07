Date: Wed, 7 Dec 2022 13:03:01 +0100 (CET)
Message-Id: <202212071203.2B7C319J097883@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221207100201.6467-1-a@...2181...>
References: <20221207100201.6467-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: disable DCO if --secret is
 specified
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Nicely trivial, and gets the job done :-) - 

Dec  7 11:21:02 ubuntu2004 tun-udp-p2p[1139052]: --secret is set. Disabling data channel offload

.. and subsequently, tests succeed, and the instance does not crash
anymore.  Thanks.  (Tested only on the Linux/DCO Server + Client, because
the code path is irrelevant on non-DCO systems)

I have added "Github: OpenVPN/openvpn#188" to the commit message, as
discussed on IRC just now.

Your patch has been applied to the master and release/2.6 branch.

commit f5febf7f8998e425afb051cd6f965f4dd40b1659 (master)
commit 952a33a879ee106ee0877b872ad3d6c58983b521 (release/2.6)
Author: Antonio Quartulli
Date:   Wed Dec 7 11:02:01 2022 +0100

     disable DCO if --secret is specified

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221207100201.6467-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25629.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


