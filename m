Date: Thu, 24 Jun 2021 13:21:55 +0200 (CEST)
Message-Id: <202106241121.15OBLtjw072652@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210520151148.2565578-1-arne@...1227...>
References: <20210520151148.2565578-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move auth_token_state from
 multi to key_state
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

Your patch has been applied to the master branch.

I did some stare-at-code and testing of my own, and most of this patch
is fairly straightforward - it's only that long because the auth-token-test
module is really extensive, and due to the pointer change, lots of lines
change.

Also tested with the "renegotiate, then reconnect from same port" nuisance
client, and that seems to be a bit worse now (this re-introduces "we send 
a PUSH_REPLY right away on client-reconnect-same-port") but I understand 
that this is fixed in 3/9+4/9 (and verified that it is).

commit 716049923e3e70c3de938d6da5d05f529ec515b5
Author: Arne Schwabe
Date:   Thu May 20 17:11:40 2021 +0200

     Move auth_token_state from multi to key_state

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210520151148.2565578-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22415.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


