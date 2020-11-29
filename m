Date: Sun, 29 Nov 2020 12:27:34 +0100 (CET)
Message-Id: <202011291127.0ATBRYAP029340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-7-arne@...1227...>
References: <20201023120259.29783-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make any auth failure
 tls_authentication_status return auth failed
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

Stared at the code for a bit, and it looks simple and straightforward
enough.  With 1/8...7/8 reviewed, I think I even understand what it
does :-)

The bit about "ks->authenticated == KS_AUTH_FALSE" becomes clear when
you look ks_auth_state - FALSE is 0, everything else is > FALSE, so
the "else" is basically the same condition as before.


Testing (only script backend + pam auth + token):

This improves the "token expired on renegotiation" even further,
though it still shows some interesting timing aspects.

Case 1: auth-gen-token 600, sync plugin auth-pam

2020-11-29 10:30:16 us=100840 --auth-token-gen: auth-token from client expired
2020-11-29 10:30:16 us=100868 TLS: Username/auth-token authentication failed for username 'fbsd-tc-master'
2020-11-29 10:30:16 us=101534 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
2020-11-29 10:30:32 us=478267 Delayed exit in 5 seconds
2020-11-29 10:30:32 us=478374 SENT CONTROL [cron2-freebsd-tc-amd64]: 'AUTH_FAILED,SESSION: token expired' (status=1)

I wonder what it is doing here, between 10:30:16 and 10:30:32?  Expiring
the active key?

On the client side, we see renegotiation, TLS handshake, then a pause
(in which the connection still works fine(!)), then AUTH FAIL, and then
reconnect with user/password credentials:

2020-11-29 10:30:16 TLS: soft reset sec=151/151 bytes=89537/-1 pkts=705/0
2020-11-29 10:30:16 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
2020-11-29 10:30:32 AUTH: Received control message: AUTH_FAILED,SESSION: token expired

2020-11-29 10:30:32 Restart pause, 5 second(s)
..
2020-11-29 10:30:37 TLS: Initial packet from ...
..
2020-11-29 10:30:37 PUSH: Received control message: 'PUSH_REPLY,...,xauth-tokenSESS_ID,...
..
2020-11-29 10:30:38 Initialization Sequence Completed


The server confirms:

2020-11-29 10:30:37 us=551426 TLS: Username/Password authentication succeeded for username 'fbsd-tc-master' 


So - this is definitely very nice.



Test case 2: auth-gen-token 600, deferred plugin auth-pam with 16s delay

- initial connect takes 18s (which is expected)
- initial TLS-reconnect with token takes 0.002s (which is very nice :) )
- TLS reconnect after 10 minute, with expired token...

2020-11-29 10:50:05 us=911127 --auth-token-gen: auth-token from client expired
2020-11-29 10:50:05 us=911147 TLS: Username/auth-token authentication failed for username 'fbsd-tc-master'
2020-11-29 10:50:05 us=912088 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
2020-11-29 10:50:21 us=533468 Delayed exit in 5 seconds
2020-11-29 10:50:21 us=533597 SENT CONTROL [cron2-freebsd-tc-amd64]: 'AUTH_FAILED,SESSION: token expired' (status=1)

.. does the right thing now!

The client understands, and reconnects with password:

2020-11-29 10:50:26 us=601574 Re-using SSL/TLS context
2020-11-29 10:50:26 us=614341 PLUGIN AUTH-PAM: do deferred auth '/tmp/openvpn_acf_3131079bbfa3c5c756b7e374b8328dfc.tmp'
2020-11-29 10:50:26 us=627822 TLS: Username/Password authentication deferred for username 'fbsd-tc-master' 
2020-11-29 10:50:41 us=641229 PLUGIN AUTH-PAM: BACKGROUND: fbsd-tc-master: deferred auth: PAM succeeded
2020-11-29 10:50:42 us=814877 SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,...,auth-tokenSESS_ID,...,key-derivation tls-ekm' (status=1)


And things are back to "it pings".  Of course the "no-ping" time is longer in 
this case, due to client reconnect (5s) *plus* 16s AUTH-PAM backgrounding, 
but this is exactly what is to be expected.

(This is the case where OpenVPN would previously get totally confused and 
never tell the client "hey, you're dead, reconnect!" - so, bug fixed, great 
stuff)


Your patch has been applied to the master branch (because it needs all
the prerequisite refactoring patches).  Now, how to get the bugfix part
into 2.5.1?

commit 88dc4276485bf2a4cecae3cff55d2e146dcd31ca
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:59 2020 +0200

     Make any auth failure tls_authentication_status return auth failed

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21223.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


