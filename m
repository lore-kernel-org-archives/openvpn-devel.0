Date: Sun, 22 Dec 2024 11:47:54 +0100 (CET)
Message-Id: <202412221047.4BMAlsHP082902@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241221224136.20984-1-gert@...1296...>
References: <20241221224136.20984-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: service: add utf8to16 function
 that takes a size
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

v1 looked like a nice and trivial change with not much to go wrong, and
then GHA exploded - one of the builds runs without "-O2", and with
an inline function without "static inline" this leads to link time
errors (function is not inlined due to missing -O2, but not instantiated
either, so "nowhere to be found").  v1 to v2 only differ in the "static",
so I'm recording Frank's ACK on v1 plus adding my own.

Your patch has been applied to the master branch.

commit d92df90470a059f0ea231250d85ab47b72bc4791
Author: Heiko Hund
Date:   Sat Dec 21 23:41:36 2024 +0100

     service: add utf8to16 function that takes a size

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241221224136.20984-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30158.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


