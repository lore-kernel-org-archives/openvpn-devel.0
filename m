Date: Sun, 6 Nov 2022 09:58:22 +0100 (CET)
Message-Id: <202211060858.2A68wMRM003011@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221104125655.656150-2-arne@...1227...>
References: <20221104125655.656150-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow setting control channel
 packet size with max-packet-size
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

Stared-at-code, discussed with Arne on IRC.  There's a few things one
could have done differently (like, using constrain_int() inside
tls_init_control_channel_frame_parameters()), but this is all minor.

Tested regular t_client and server side tests (which are not excercising
the new option) - all good.

Tested with the new option, to see what I could break (no tls-auth or
tls-crypt in use for this test)

 - not specified -> maximum TLS packet size is 1250 byte (1264 eth len)

 - --max-packet-size 100
   -> tells me: "Note: max-packet-size value outside of allowed control
       channel packet size (154 to 2048), will use 154 instead." and
   maximum TLS packet size observed is 154 byte, with a single packet
   of 169 byte

 - --max-packet-size 500
   -> most packets are 488 bytes, one is 500 bytes

 - --max-packet-size 3000
   -> it complains to me, "will use 2048 instead".  I observe outside-
   fragmented packets, with an inner UDP length of 2020, and a total
   combined length of both fragments of 2056 bytes (second IP header
   adds more bytes outside OpenVPN Control).

   This test case actually fails to establish a TLS session(!) - the
   server I connect to has the same code, but no --max-packet option
   in its config, so it does not want to see these packets:

   Nov  6 09:41:39 gentoo tun-udp-p2mp-topology-subnet[15790]: 194.97.140.21:40355 Incoming control channel packet too big, dropping.

   ... this is not surprising, tbh, as we allocate "1500+100" by default
   (so --max-packet-size 1600 *does* work, two ip fragments, being
   properly reassembled and handled by the server)


 - results are consistent for IPv4 and IPv6 (= UDP payload is smaller
   on --proto udp6, total packet size is the same)

 - mssfix also seems to do what it says on the lid

   09:10:42.860856 IP 10.194.0.1.774 > 10.194.3.9.37123: Flags [S.], seq 2812517040, ack 1148395195, win 65535, options [mss 32,nop,wscale 6,sackOK,TS val 574950381 ecr 3397293635], length 0

   (for a --max-packet-size 154 session)

 - if I poke the bear with --max-packet-size 100, *TLS* MTU will be 
   ugprade to 154 (as the warning says), but --mssfix will be broken,
   as it installs the "not constrained_int()" value to ce.mssfix

   +        int maxmtu = positive_atoi(p[1]);
   +        options->ce.tls_mtu = constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CH
   ...
   +        options->ce.mssfix = maxmtu;

   (this will result in a mssfix value <= 0, so "no mssfix activity")

 - --maxpacket-size 113 over udp6 will result in

   09:14:47.172084 IP 10.194.0.1.774 > 10.194.3.9.50937: Flags [S.], seq 3614955968, ack 1939523050, win 65535, options [mss 0,nop,wscale 6,sackOK,TS val 371801058 ecr 3794849425], length 0

   ... which the sending stack seems to treat with "no idea what the other
   end wants, I ignore this".  114 leads to "mss 1", which also is not
   handled by the other end as "only 1 byte segments", but I see 204 bytes
   - so FreeBSD seems to set that as minimum MSS.

   I think a followup patch should maybe use "ce.tls_mtu" (constrained)
   and not the raw argument here.  Less confusion.

 - for --max-packet-size 500 ("reasonable values"), implccit mssfix mtu
   works as expected.

 - --max-packet-size 145 + tls-auth --> works

 - --max-packet-size 145 + tls-crypt --> works, though only 138 bytes

 - --max-packet-size 145 + tls-crypt-v2 --> works, though only 138 bytes

   the last 3 have been added to the "server test / master t_client.rc"
   testbed.



I have added the oxford comma, as requested, and also a "--" before
"max-packet-size" in that line.  The other two wording fixes are not
needed as that comment got completely rewritten.  Found another typo
("udp , ipv6").

Also, I have updated the man page to show "154" as the correct minimum
in v6, it was still talking about 512 (why are we limiting the maximum
to 2048, btw?).

Your patch has been applied to the master branch.

commit 5f6ea5975927627680c21c10670ccb8503f18249
Author: Arne Schwabe
Date:   Fri Nov 4 13:56:55 2022 +0100

     Allow setting control channel packet size with max-packet-size

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20221104125655.656150-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25477.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


