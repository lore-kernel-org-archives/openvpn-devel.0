Date: Wed, 12 Mar 2025 12:20:34 +0100 (CET)
Message-Id: <202503121120.52CBKYDI089829@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250312101156.5756-1-gert@...1296...>
References: <20250312101156.5756-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: do not use netsh to set
 name server addresses
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Stared at code, looks reasonable.

There is a bit of unsafe code (the address copying loop will overrun *if*
we ever increase the number of allowed addresses in dns_cfg_message_t
and forget to increase this buffer) - but it cannot overflow with anything
accepted today, and increasing the message size is not something trivially
done.

Lev has tested that it actually works :-)

Since mail-archive.org is broken again I've referenced the sf.net mail
archive (+ the gerrit URL) instead.

Your patch has been applied to the master branch.

commit 99b35c3783477b837735cff0aa1cf7c5ba4aa366
Author: Heiko Hund
Date:   Wed Mar 12 11:11:50 2025 +0100

     dns: do not use netsh to set name server addresses

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250312101156.5756-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59159531/
     URL: https://gerrit.openvpn.net/c/openvpn/+/825
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


