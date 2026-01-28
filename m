Date: Wed, 28 Jan 2026 14:19:00 +0100 (CET)
Message-Id: <202601281319.60SDJ0HF035359@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260128110443.24410-1-gert@...1296...>
References: <20260128110443.24410-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prevent NULL pointer
 dereference with --dns-updown
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

Thanks for the quick fix (and compliments to SR Labs for finding all these...).

For the sake of the archives - while this is a NULL-pointer crashbug, it
can not be pushed or triggered "from the outside", so it does not get a CVE,
it's just a bug.

The BBs do "does it compile and does t_client with --dns-updown work?" tests,
and this is all green, so I didn't do more than stare-at-code for a bit.

It's also not in 2.6.x, so no backporting needed.

Your patch has been applied to the master branch.

commit 62a17417de26735e04cb527c5df8137e4d50454a
Author: Heiko Hund
Date:   Wed Jan 28 12:04:37 2026 +0100

     Prevent NULL pointer dereference with --dns-updown

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1498
     Message-Id: <20260128110443.24410-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35479.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


