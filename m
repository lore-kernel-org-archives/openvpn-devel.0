Date: Wed, 14 Jul 2021 15:04:14 +0200 (CEST)
Message-Id: <202107141304.16ED4ED0023429@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210705133414.3102815-1-arne@...1227...>
References: <20210705133414.3102815-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce S_GENERATED_KEYS
 state and generate keys only when authenticated
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

Adding my ACK on v3 to Antonio's test report on v3 and ACK on v2.

v3 is really exactly identical to the v2 patch, except for one extra
"is this pointer non-NULL?" check in do_up() - where v2 crashed.

Stared a bit at the code (again), subjected to t_client and server
torture chamber - and this time, everything succeeded, even the 
--secret tests.


Fixed whitespace (as instructed for v2), added description for 
S_GENERATED_KEYs ("The"), and clarified description for S_ACTIVE
(as discussed on IRC).  Added a "move" to "ks->state from S_ACTIVE" :-)


My test rig exhibited something new regarding timing with deferred
auth (20s radius delay).  "Master without this" has the timings like
this:

2021-07-14 13:59:27 PLUGIN AUTH-PAM: BACKGROUND: fbsd-tc-master: deferred auth: PAM succeeded
2021-07-14 13:59:28 PUSH: Received control message: 'PUSH_REQUEST'
2021-07-14 13:59:28 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,...

while "master with this patch" adds extra 5s delay here *if the client
reconnects often enough* (connecting 3 times from the same source port):

2021-07-14 14:03:54 PLUGIN AUTH-PAM: BACKGROUND: fbsd-tc-master: deferred auth: PAM succeeded
2021-07-14 14:03:56 PUSH: Received control message: 'PUSH_REQUEST'
2021-07-14 14:04:01 Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
2021-07-14 14:04:01 Incoming Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
2021-07-14 14:04:01 PUSH: Received control message: 'PUSH_REQUEST'
2021-07-14 14:04:01 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,...

this looks like the "let's avoid too many disk accesses" cache is not
being reset to 0 when a new connection from the same user comes in, or
something along that lines.  I know how to reproduce it, so I can go 
and debug more now :-) - it does NOT happen if the source port changes
(--nobind).

Since this is a special case of a special case, it should not hold up
this patch as such.  So, not considering this a show stopper.


This patch introduces new ASSERT()s on ks->authenticated, which we
checked very throughly.  Both can only be reached if the ks->state is
S_GENERATED_KEY, which in the normal path is only ever set if 
ks->authenticated is KS_AUTH_TRUE.  There is a special hack path
via tls_session_update_crypto_params(), which in p2mp mode is only
reached after client connect, which depends on CAS_PENDING, which
depends on TLS_AUTHENTICATION_SUCCEEDED.  In p2p + TLS, this might
be triggerable, but "coming soon" patches will clean up that path.


Your patch has been applied to the master branch.

commit 34b42549c980b19730a0beb03096d2dd915865c0
Author: Arne Schwabe
Date:   Mon Jul 5 15:34:14 2021 +0200

     Introduce S_GENERATED_KEYS state and generate keys only when authenticated

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210705133414.3102815-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22617.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


