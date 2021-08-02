Date: Mon, 2 Aug 2021 12:33:33 +0200 (CEST)
Message-Id: <202108021033.172AXXr5070813@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210728123050.564595-1-arne@...1227...>
References: <20210728123050.564595-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support NCP in pure P2P VPN
 setups
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

I have stared at the code a bit, and it generally looks good (indent
fixed as instructed).

One observation:

 - in options_postprocess_cipher(), we now set "o->enable_ncp_fallback 
   = true", but *only* if a "cipher foo" is set in the config.  If not, we 
   set the cipher to o->ciphername = "BF-CBC", but disallow ncp-fallback
   - not sure if this is part of the crusade against BF-CBC "as default",
   but it looks a bit weird (we *set* BF-CBC as default, but do not want 
   to use it).


Testing this in the server side testbed yielded interesting problems
for the two p2p test cases, when connecting from a "pre P2P NCP" client
(master, but a few months old):

** "9" is "--client" to "--tls-server" **

With a "plain" config (no data-ciphers or data-cipher-fallback) the
connection works fine, both ends negotiate AES-256-GCM (= NCP works)

   P2P mode NCP negotiation result: TLS_export=0, DATA_v2=0, peer-id 0, cipher=AES-256-GCM
   Data Channel: using negotiated cipher 'AES-256-GCM'
   Data Channel MTU parms [ L:1468 D:1450 EF:-64 EB:392 ET:32 EL:3 AF:14/8 ]
   Outgoing Data Channel: Cipher 'AES-256-GCM' initialized with 256 bit key
   SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,route 10.204.0.0 255.255.0.0 10.204.9.1,route-ipv6 fd00:abcd:204::/48,cipher AES-256-GCM' (status=1)

.. but then:

   TCP/UDP packet too large on write to [AF_INET6]::ffff:194.97.140.21:36144 (tried=1504,max=1468)

so the frame calculation is wrong, and pinging with large packets fails.

If I force the server to "no AES" (data-ciphers BF-CBC), it works:

   P2P mode NCP negotiation result: TLS_export=0, DATA_v2=0, peer-id 0, cipher=BF-CBC
   Outgoing Data Channel: Cipher 'BF-CBC' initialized with 128 bit key
   SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,route 10.204.0.0 255.255.0.0 10.204.9.1,route-ipv6 fd00:abcd:204::/48,cipher BF-CBC' (status=1)

Notably it's not telling me anything about "using negotiated cipher",
and also nothing about the MTU params.


** "9a" is "--tls-client" (no -pull) to "--tls-server" **

Using the config "without --data-ciphers or --data-cipher-fallback",
incoming connections fail:

    P2P mode NCP negotiation result: TLS_export=0, DATA_v2=0, peer-id 0, cipher=(not negotiated, fallback-cipher: none)
    TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:36664 (received key id: 0, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_TRUE id=0 sid=9daa0f59 9d7bf877] [key#1 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000]
    ERROR: failed to negotiate cipher with peer and --data-ciphers-fallback not enabled. No usable data channel cipher
    ERROR: Failed to apply P2P negotiated protocol options
    TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:36664 (received key id: 0, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_TRUE id=0 sid=9daa0f59 9d7bf877] [key#1 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000])

but the server does not actively terminate the connection - so we'll
see "TLS Error" errors scroll through, masking the actual error.

Adding "data-ciphers-fallback BF-CBC" makes this test instance well-behaved
(though there still is *one* TLS error):

    P2P mode NCP negotiation result: TLS_export=0, DATA_v2=0, peer-id 0, cipher=(not negotiated, fallback-cipher: none)
    TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:47925 (received key id: 0, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_TRUE id=0 sid=bfa5ccf1 c5c5e901] [key#1 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000])
    Outgoing Data Channel: Cipher 'BF-CBC' initialized with 128 bit key

("Fallback-cipher: none" looks a bit bogus, though... this might be
related to BF-CBC not being initialized early, or something)


The first case definitely needs fixing (I have more failing "frame" test
cases...), the second case could need some polishing - abort the session,
so it's clear "*this* is the error".


Connecting to the same instances from a client with P2P NCP yielded
different results (unsurprisingly) :-)

** "9" is "--client" to "--tls-server" **

If the server is configured to "data-ciphers BF-CBC", this works.  If
AES is added to the cipher list, the client's IV_CIPHER= wins, and they
negotiate AES-256-GCM...

   peer info: IV_CIPHERS=AES-256-GCM:AES-128-GCM
   peer info: IV_PROTO=30
   P2P mode NCP negotiation result: TLS_export=0, DATA_v2=0, peer-id 0, cipher=AES-256-GCM
   Data Channel: using negotiated cipher 'AES-256-GCM'
   Data Channel MTU parms [ L:1504 D:1450 EF:-28 EB:398 ET:32 EL:3 ]

.. and it fails:

   TCP/UDP packet too large on write to [AF_INET6]2001:608:4::ce:c0f:51605 (tried=1536,max=1504)

forcing the client to "--data-ciphers BF-CBC" makes them "negotiate"
BF-CBC, sidestepping the frame problem.

(I assume that having "--cipher AES-256-GCM" in both client and server
configs upfront would also solve this, but "having to add a cipher on
both sides to make NCP work" sounds like the wrong way forward)


** "9a" is "--tls-client" (no -pull) to "--tls-server" **

Given the changes to the server.conf ("data-ciphers BF-CBC") to work
around the "frame" problem, this now fails with

    peer info: IV_CIPHERS=BF-CBC
    peer info: IV_PROTO=42
    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 16371030, cipher=(not negotiated, fallback-cipher: none)
    ERROR: failed to negotiate cipher with peer and --data-ciphers-fallback not enabled. No usable data channel cipher
    ERROR: Failed to apply P2P negotiated protocol options

(but the client is not aborting!) - extending --data-ciphers makes it 
connect fine:

    peer info: IV_CIPHERS=BF-CBC:AES-256-GCM:AES-128-GCM
    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 14972877, cipher=AES-256-GCM

.. but then we are back into the "frame problem" land...

    TCP/UDP packet too large on write to [AF_INET6]2001:608:0:814::f000:11:51204 (tried=1539,max=1471)

So the only way to make this work is to restrict the client to BF-CBC,
as with the --client test case.


Your patch has been applied to the master branch.

commit 8c72d7981c32c43d1c7967a312bb439e13fc5b40
Author: Arne Schwabe
Date:   Wed Jul 28 14:30:50 2021 +0200

     Support NCP in pure P2P VPN setups

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210728123050.564595-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22671.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


