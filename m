Date: Fri, 17 Oct 2025 21:30:05 +0200 (CEST)
Message-Id: <202510171930.59HJU5VH091593@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251017191612.15642-1-gert@...1296...>
References: <20251017191612.15642-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: warn and ignore
 --reneg-bytes/pkts when DCO is enabled
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

We discussed this at length on IRC, and v3 is the result of that - our
handling of AEAD ciphers, both in kernel space and in userland, is
different from "old ciphers" because we auto-honour the given safety
limits for AES key use.  Since the kernel only does AEAD, no interface
was made to send other arbitrary reneg-limits - and thus, we just ignore
them in DCO mode.

The new thing in this patch is "OpenVPN will tell you", and so does the
documentation.  v1 went for "turn off DCO if this option is used", which
was the wrong thing to do, given the abundance of openvpn config with
stale cruft in them...  but, we tell users :-)

Your patch has been applied to the master branch.

commit c9a320649bd4ec43d3f2640f70476178d8fcc660
Author: Ralf Lici
Date:   Fri Oct 17 21:16:06 2025 +0200

     options: warn and ignore --reneg-bytes/pkts when DCO is enabled

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1280
     Message-Id: <20251017191612.15642-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59248122/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


