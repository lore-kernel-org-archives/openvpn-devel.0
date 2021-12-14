Date: Tue, 14 Dec 2021 09:23:55 +0100 (CET)
Message-Id: <202112140823.1BE8Ntbt012438@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211207170211.3275837-5-arne@...1227...>
References: <20211207170211.3275837-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix triggering assertion of
 ks->authenticated after tls_deauthenticate
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

I have not tested the actuall ASSERT() crash, but went through the 
change asking myself "so, what will happen instead, now?"

- handle_data_channel_packet() will now ignore all keys that are
  no longer KS_AUTH_TRUE, so if there is no other key, it will end
  up in "TLS error: local/remote TLS keys are out of sync" and drop
  the incoming packet (buf->len = 0).

- tls_select_encryption_key() will also ignore those keys, and possibly
  return NULL.  This is only called from tls_pre_encrypt(), which will
  log "TLS Warning: no data channel send key available" in this case,
  and drop the outgoing packlet (buf->len = 0).

Looking at tls_deauthenticate(), the problem described sounds real - this
function sets all keys to KS_AUTH_FALSE, without changing ks->state,
thus the next incoming or outgoing packet for that peer would trigger
the ASSERT()  (and this looks like could happen on regular renegotiation, 
like on a username or CN change, so this sounds like an actual DoS vector
againt a "master" server...).  

The patch should fix this, without introducing undesired new side effects
(like, bypassing KS_AUTH_FALSE).


Subjected to a full set of server tests (passed).

Your patch has been applied to the master branch.

commit 75f9fb6f5b9bf57578086c3e42870bba4a914d7c
Author: Arne Schwabe
Date:   Tue Dec 7 18:01:54 2021 +0100

     Fix triggering assertion of ks->authenticated after tls_deauthenticate

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211207170211.3275837-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23340.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


