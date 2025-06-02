Date: Mon, 2 Jun 2025 17:30:27 +0200 (CEST)
Message-Id: <202506021530.552FURqE073596@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250602152115.27130-1-gert@...1296...>
References: <20250602152115.27130-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not segfault on missing --dh
 in server config
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Apologies.

"The more trivial a patch looks, the more testing it warrants"...

Now *this* patch is rather trivial, and *have* verified that it, indeed,
makes a config "with no --dh in it" work with no segfault.

Your patch has been applied to the master branch.

commit 92b9cb5e0363a1c19b76a5a6e5f36c9891406590
Author: Frank Lichtenheld
Date:   Mon Jun 2 17:21:08 2025 +0200

     Do not segfault on missing --dh in server config

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250602152115.27130-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31844.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


