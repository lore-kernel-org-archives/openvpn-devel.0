Date: Thu, 12 Mar 2026 08:35:21 +0100 (CET)
Message-Id: <202603120735.62C7ZLTI038149@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260311195925.5600-1-gert@...1296...>
References: <20260311195925.5600-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: DNS/DHCP: Make _len attributes
 consistently unsigned
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

Quite a few changes, but it all makes sense.  BB happy :-).

Compile-tested on Ubuntu 24.04 / mingw64.  Did not actually test the
resulting binaries.

Your patch has been applied to the master branch.

commit 28a7bd69953af35f976a4005835523a65e13e558
Author: Frank Lichtenheld
Date:   Wed Mar 11 20:59:20 2026 +0100

     DNS/DHCP: Make _len attributes consistently unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1520
     Message-Id: <20260311195925.5600-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36038.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


