Date: Wed, 14 Dec 2022 08:57:43 +0100 (CET)
Message-Id: <202212140757.2BE7vhJT042381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221213225430.1892940-1-arne@...1227...>
References: <20221213225430.1892940-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve debug logging of DCO
 swap key message and Linux dco_new_peer
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

As instructed I have changed the wording a bit, it's now

  "... currently %d keys installed"

which should make it clear that we are talking about the number of keys,
and not a key ID.  "currently installed %d" is ambiguous here.

I have not tested this beyond "does it compile?", but since this is all
just messages (and a bit of string formatting with an existing gc) the
risk for "it will explode on platform X or with compile-time option Y"
is minimal.

Your patch has been applied to the master and release/2.6 branch.

commit 63f838e384df3fb644bdeae6ede777b54dc968db (master)
commit 8910b5b6028ee0feb9c324b1baf137cae5b4d9bd (release/2.6)
Author: Arne Schwabe
Date:   Tue Dec 13 23:54:28 2022 +0100

     Improve debug logging of DCO swap key message and Linux dco_new_peer

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20221213225430.1892940-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25680.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


