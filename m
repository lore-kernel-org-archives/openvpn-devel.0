Date: Wed, 11 Dec 2024 19:43:38 +0100 (CET)
Message-Id: <202412111843.4BBIhcih086179@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241211171349.8892-1-gert@...1296...>
References: <20241211171349.8892-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: forward: Fix potential
 unaligned access in drop_if_recursive_routing
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

Thanks for that.  We had quite a discussion on IRC on why this is needed
and whether it's a bug in clang - turns out it is not, the linux 
implementation of IN6_ARE_ADDR_EQUAL() uses 4x 32bit compare, which is
sensitive to alignment, while all the rest of the world uses memcmp()
which does not care...  so this code now does the same on Linux,
and does not crash on "unaligned ipv6 header in an outgoing TAP packet"
(the buf is aligned, but the ethernet header misaligns everything).

Your patch has been applied to the master and release/2.6 branch
(minor bug).

Mildly tested on a FreeBSD and a Linux t_client setup (and, of course,
the buildbot army which uncovered this in the "tap" client tests).

Uncrustify complains about multline comment not having a "*", so
fixed on the fly.

commit 387c2076af14a0f1ba97b6ca0175d81d1e8391a5 (master)
commit 62d41dec8db8c87f9b005c168827bb3387ea5c65 (release/2.6)
Author: Frank Lichtenheld
Date:   Wed Dec 11 18:13:48 2024 +0100

     forward: Fix potential unaligned access in drop_if_recursive_routing

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241211171349.8892-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20241211171349.8892-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


