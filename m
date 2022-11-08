Date: Tue, 8 Nov 2022 17:58:38 +0100 (CET)
Message-Id: <202211081658.2A8Gwc8F066351@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221108151407.1132097-1-arne@...1227...>
References: <20221108151407.1132097-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add packet type in
 accept/reject messages for HMAC packet
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

This is a useful addition.  It works...

2022-11-08 17:39:46 us=399783 Connection Attempt Valid packet (P_CONTROL_V1) with HMAC challenge from peer ([AF_INET6]::ffff:194.97.140.21:61081), accepting new connection.

.. and uncovered a new bug...

2022-11-08 17:39:46 us=439044 194.97.140.21:61081 peer info: IV_NCP=2
2022-11-08 17:39:46 us=439083 194.97.140.21:61081 peer info: IV_CIPHERS=AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305
..
2022-11-08 17:39:46 us=448391 cron2-freebsd-tc-amd64/194.97.140.21:61081 Data Channel: using negotiated cipher 'AES-256-GCM'
2022-11-08 17:39:46 us=448421 cron2-freebsd-tc-amd64/194.97.140.21:61081 Data Channel MTU parms [ mss_fix:1379 max_frag:0 tun_mtu:1500 headroom:136 payload:1736 tailroom:557 ET:0 ]
2022-11-08 17:39:46 us=448505 cron2-freebsd-tc-amd64/194.97.140.21:61081 Master Encrypt (cipher): 1fdef04a 9fc2d2e9 d01abb10 5bf10459 19f4ecd8 ec471652 f15dd536 0d7adf87
2022-11-08 17:39:46 us=448544 cron2-freebsd-tc-amd64/194.97.140.21:61081 Message hash algorithm 'none' not found
2022-11-08 17:39:46 us=448590 cron2-freebsd-tc-amd64/194.97.140.21:61081 Exiting due to fatal error

.. and then the server exits.

With --verb 4 it does not...  (but the message in *this* patch needs "verb 7"
to see) - this is not caused by the patch here, but sneaked in earlier.

GDB says this is the call chain where it happens...

#0  md_get (digest=0x5555555e1064 "none") at crypto_mbedtls.c:774
#1  0x0000555555568d39 in md_kt_size (mdname=<optimized out>) at crypto_mbedtls.c:812
#2  0x0000555555564b69 in key2_print (k=k@...1851...=0x7fffffffbf10, kt=0x555555638798, prefix0=prefix0@...1851...=0x5555556025ed "Master Encrypt", 
    prefix1=prefix1@...1851...=0x5555556025de "Master Decrypt") at crypto.c:1013
#3  0x00005555555cb157 in generate_key_expansion (ks=ks@...1851...=0x555555638d10, session=session@...1851...=0x555555638b78, multi=<optimized out>) at ssl.c:1645
#4  0x00005555555cc010 in tls_session_generate_data_channel_keys (multi=<optimized out>, session=0x555555638b78) at ssl.c:1705
#5  0x00005555555cc232 in tls_session_update_crypto_params_do_work (multi=<optimized out>, session=<optimized out>, options=options@...1851...=0x555555637690, 
    frame=frame@...1851...=0x555555638288, frame_fragment=<optimized out>, lsi=<optimized out>) at ssl.c:1769
#6  0x00005555555cc330 in tls_session_update_crypto_params_do_work (lsi=<optimized out>, frame_fragment=<optimized out>, frame=0x555555638288, options=0x555555637690, 
    session=<optimized out>, multi=<optimized out>) at ssl.c:1789
#7  0x0000555555591bb7 in multi_client_generate_tls_keys (c=0x555555637690) at multi.c:2322
#8  multi_client_connect_late_setup (option_types_found=<optimized out>, mi=0x5555556374d0, m=0x7fffffffc250) at multi.c:2464
#9  multi_connection_established (mi=0x5555556374d0, m=0x7fffffffc250) at multi.c:2735

.. so it should be easy to pinpoint.  Not sure what the "right" fix
is, though.  Not my field.


Your patch has been applied to the master branch.

commit 4466c5dcb7a77d4a214e60afc6c7b41688d0ec04
Author: Arne Schwabe
Date:   Tue Nov 8 16:14:07 2022 +0100

     Add packet type in accept/reject messages for HMAC packet

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221108151407.1132097-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25489.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


