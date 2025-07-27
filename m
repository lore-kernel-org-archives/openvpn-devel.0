Date: Sun, 27 Jul 2025 12:45:29 +0200 (CEST)
Message-Id: <202507271045.56RAjTA6089731@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250727102245.24931-1-gert@...1296...>
References: <20250727102245.24931-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: clean up PEER_GET
 trigger and parser
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Nice :-) - stared at the code, tested on Linux, FreeBSD (because of the
change to dco_freebsd.c).  The affected Windows function is a no-op, so
"BB compiled this fine" is good enough for me.

(I only tested p2mp server side, as that's what we've spent most of the
time with all the float changes - since p2p client side is basically
using the exact same code before and afterwards, *this* change would not
break it)

There is more work to do in this counter arena ("BYTECOUNT" for server,
at least, and also test BYTECOUNT on all clients).

Your patch has been applied to the master branch.

commit d1f2afc26bc8cc1837c2c12981e7eb6afdd4fcf6
Author: Antonio Quartulli
Date:   Sun Jul 27 12:22:40 2025 +0200

     dco_linux: clean up PEER_GET trigger and parser

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250727102245.24931-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32361.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


