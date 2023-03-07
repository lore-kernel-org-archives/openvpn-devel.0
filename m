Date: Tue, 7 Mar 2023 19:13:36 +0100 (CET)
Message-Id: <202303071813.327IDaG2049702@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230307150233.3551436-1-arne@...1227...>
References: <20230307150233.3551436-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Dynamic tls-crypt for secure
 soft_reset/session renegotiation
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

The diff between v7 and v8 is minimal (printing protocol-options and
initializing key2.n=2 in tls_crypt_v2_init_client_key()), so taking
Heiko's ACK on v7.

I have not really looked hard at the code, relying on Heiko's tests
and compatibility work with OpenVPN 3.  Basic stare-at-code for stuff
like memory sanity etc. looks good.  Also, it has a unit test :-)

What I have done is subject this to the client/server torture testbed,
with a master+v8 client and master+v8 server (= using dynamic tls-crypt,
and not crashing) and both sides also talking to 2.3/2.4/2.5 peers, with
tls-auth, tls-crypt, tls-crypt-v2 (where supported) - since this all
works now, I'm not worried about breaking compatibility.

In addition, I've tried the auth-token renegotiation / reconnect setup
that excercises renegotiations heavily, and that also succeeds
(reneg-sec 90, token expiry at 300, so quite a bit of successful/failing
renegotiations, having to fall back to reconnect)


In Changes.rst I have adjusted "2.6.0+" to "2.6.1+" (master) and have
moved this to a new "changes in 2.6.1" section (release/2.6).

Your patch has been applied to the master and release/2.6 branch.

commit 6a05768a71ede7a8654fc6f3104f7449509efee0 (master)
commit 202a934fc32673ef865b5cbcb23ad6057ceb2e0b (release/2.6)
Author: Arne Schwabe
Date:   Tue Mar 7 16:02:33 2023 +0100

     Dynamic tls-crypt for secure soft_reset/session renegotiation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20230307150233.3551436-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26341.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


