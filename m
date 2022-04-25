Date: Mon, 25 Apr 2022 17:57:12 +0200 (CEST)
Message-Id: <202204251557.23PFvC8p074067@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-7-arne@...1227...>
References: <20220422134038.3801239-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move ssl function related to
 control channel wrap/unwrap to ssl_pkt.c/h
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"git show --color-moved=zebra" confirms that this is just code being
moved around, *except* for the swap_hmac() comment (*that* comment),
which actually gets changed in the process.  But it's still correct :-)

"make check" and "make distcheck" agree that all configure/autoconf
related bits are fine with the new files.  "make check" tested on a
OpenSSL and mbedTLS build.

Whitespace in Makefile.am fixed, missing end-of-file newline in ssl_pkt.c
fixed.

Your patch has been applied to the master branch.

commit 788ce35cf09aff09b79f428cdd6cfc0ff8627934
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:35 2022 +0200

     Move ssl function related to control channel wrap/unwrap to ssl_pkt.c/h

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24149.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


