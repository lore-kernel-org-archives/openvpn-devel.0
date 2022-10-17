Date: Mon, 17 Oct 2022 18:47:10 +0200 (CEST)
Message-Id: <202210171647.29HGlARG024904@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221017095145.2580186-1-arne@...1227...>
References: <20221017095145.2580186-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow Authtoken lifetime to be
 short than renegotiation time
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

The feature itself is really in the "we are a swiss army knife and can
do everything" side of things.  It does not introduce a new option and
no new #ifdef, and the actual code change is not very intrusive.

I should point out that there is potential for conflict with the
ongoing discussion on username locking - this patch ensures that
the username is locked

+    if (!multi->locked_username)
+    {
+        msg(D_SHOW_KEYS, "username not locked, skipping auth-token renewal.");
+        return;
+    }

.. so with my open patch ("do not lock empty username") this will lead
to "renewed tokens are only available after first renegotiation", which
is certainly not what we want.  But Arne did not like that patch anyway,
so we need a better fix there.


I have submitted the result to my "server side hard core testing" setup,
which does have an --auth-gen-token instance.  Without extra options,
this does what it did before - new tokens get pushed at renegotiation
time, and reconnecting with a valid token bypasses (deliberately slow)
auth_pam auth.

With the new option (renewal-time set to 60) I see incoming unsolicited 
PUSH_REPLY messages:

    2022-10-17 18:29:41 Initialization Sequence Completed
    2022-10-17 18:30:50 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
    2022-10-17 18:31:54 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
    2022-10-17 18:32:48 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
    2022-10-17 18:33:43 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'

(interesting enough, the server claims to have sent these at 18:30:40,
18:31:40, 18:32:40, 18:33:40... - discussed this with Arne: PUSH_REPLY
messages are queued only, but tls_process() isn't scheduled, so the
dangling message are send when check_tls() is called, every 10-ish
seconds.  For normal renewal intervals this shouldn't matter, I just
found it interesting)

I also have reneg-sec set to 150 on the client, so there's "intermixed"
reneg/PUSH_REPLY - but this is fine, we just renew "a bit more often" 
in this case.


Normal token expiry (600 seconds in my testbed) works as before.  "Client
offline for too long" expiry is not so easy to test, so I killed the
server instead, waited, restarted :-) - when restarting the server
quickly, the stored token on the client works perfectly.  When waiting
for 120 seconds before restarting, we get a clear indication:

2022-10-17 18:42:19 us=660299 194.97.140.21:58930 Timestamp (1666024749) of auth-token is out of the renewal window
2022-10-17 18:42:19 us=660325 194.97.140.21:58930 --auth-gen-token: auth-token from client expired

.. and the client falls back to auth-user-pass, as it should.

I have only tested with a "master" client, but my understanding of the
PUSH_REPLY handler is "every version of OpenVPN since ever" handles
unsolicited PUSH_REPLY just fine.  So testing this with 2.3, 2.4, 2.5
was too much for my lazy self.


Your patch has been applied to the master branch.

commit 9a5161704173e31f2510d3f5c29361f76e275d0f
Author: Arne Schwabe
Date:   Mon Oct 17 11:51:45 2022 +0200

     Allow Authtoken lifetime to be short than renegotiation time

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221017095145.2580186-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25407.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


