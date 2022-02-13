Date: Sun, 13 Feb 2022 10:24:12 +0100 (CET)
Message-Id: <202202130924.21D9OCRM040547@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220212003331.3483107-1-arne@...1227...>
References: <20220212003331.3483107-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add mtu paramter to --fragment
 and change fragment calculation
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


Looked at the code, compared v4.  v5 now guards "lsi" against being NULL
on lsi->lsa and lsi->proto access in get_ip_encap_overhead(), and also
removes the "frame_calculate_mssfix()" call in init_instance() before
socket initialization, plus an extra comment about --static.  So the
change v4->v5 looks very reasonable and also fixes the issue :-)

Ran full set of t_client and t_server tests, all tests passed, including 
the --fragment instance.  Good :-)


Also, ran manual --fragment tests with varying values.

Testing is hard, as OpenVPN will not split the packet at "fragment size +
small remainder" but "in the middle" (to get somewhat similar-sized smaller
packets).  So one needs to test varying sizes to get to the point
"ping $size +1 will need one more fragment".

Test case: 
  AES-256-GCM, over IPv6, --fragment 500 mtu, pinging IPv4 through the tunnel

ping -s 819
  13:21:23.241119 ethertype IPv6 (0x86dd), length 514: 2001:608:4::ce:c0f.49924 > 2607:fc50:1001:5200::4.51198: UDP, length 452
  13:21:23.241141 ethertype IPv6 (0x86dd), length 514: 2001:608:4::ce:c0f.49924 > 2607:fc50:1001:5200::4.51198: UDP, length 452
 
  (514 is including ethernet headers) -> "full '500 mtu' frames"

ping -s 820
  13:21:59.288511 ethertype IPv6 (0x86dd), length 374: 2001:608:4::ce:c0f.49924 > 2607:fc50:1001:5200::4.51198: UDP, length 312
  13:21:59.288533 ethertype IPv6 (0x86dd), length 374: 2001:608:4::ce:c0f.49924 > 2607:fc50:1001:5200::4.51198: UDP, length 312
  13:21:59.288550 ethertype IPv6 (0x86dd), length 371: 2001:608:4::ce:c0f.49924 > 2607:fc50:1001:5200::4.51198: UDP, length 309

  -> too big -> split in 3


IPv4 over IPv4 needs +40 byte for the "2 frag limit" (20 byte per header)

ping -s 859
  13:23:40.887343 ethertype IPv4 (0x0800), length 514: 193.149.48.178.12321 > 199.102.77.82.51198: UDP, length 472
  13:23:40.887364 ethertype IPv4 (0x0800), length 514: 193.149.48.178.12321 > 199.102.77.82.51198: UDP, length 472

ping -s 860
  13:24:23.221704 ethertype IPv4 (0x0800), length 370: 193.149.48.178.12321 > 199.102.77.82.51198: UDP, length 328
  13:24:23.221724 ethertype IPv4 (0x0800), length 370: 193.149.48.178.12321 > 199.102.77.82.51198: UDP, length 328
  13:24:23.221739 ethertype IPv4 (0x0800), length 359: 193.149.48.178.12321 > 199.102.77.82.51198: UDP, length 317

  -> calculation works, "500 mtu" is never exceeded.

I also tested "--fragment 500" without "mtu", and that also looks good:

ping -s 915
  13:55:42.542898 ethertype IPv4 (0x0800), length 542: 193.149.48.178.20948 > 199.102.77.82.51198: UDP, length 500
  13:55:42.542918 ethertype IPv4 (0x0800), length 486: 193.149.48.178.20948 > 199.102.77.82.51198: UDP, length 444

ping -s 916
  13:56:18.962233 ethertype IPv4 (0x0800), length 386: 193.149.48.178.20948 > 199.102.77.82.51198: UDP, length 344
  13:56:18.962254 ethertype IPv4 (0x0800), length 386: 193.149.48.178.20948 > 199.102.77.82.51198: UDP, length 344
  13:56:18.962270 ethertype IPv4 (0x0800), length 383: 193.149.48.178.20948 > 199.102.77.82.51198: UDP, length 341


I tried to test PMTU discovery, but I'm not sure I know how to do that
(or our code is broken)

The naive assumption "run OpenVPN with --fragment 1000 --mtu-disc yes", 
"run ping -s 951 $target" and "install a route with 'mtu 800'" leads to 
packets being eaten

   write UDPv4: Message too long (fd=3,code=90)

.. but packet size was not reduced.  So I assumed "it must be an incoming
ICMP", and set up the reduced-route MTU on the next hop router - again:

   write UDPv4: Message too long (fd=3,code=90)

.. so the ICMP message arrived on Linux, and Linux cached this:

ip route get 199.102.77.82
  199.102.77.82 via 193.149.48.190 dev eno1 src 193.149.48.174 uid 202 
      cache expires 475sec mtu 800 


Running OpenVPN with "--mtu-disc maybe" (wat?) leads to "OpenVPN produces
1000+ byte packets, and Linux fragments to 800"

10:08:53.304953 ethertype IPv4 (0x0800), length 810: 193.149.48.174.51279 > 199.102.77.82.51198: UDP, length 1000
10:08:53.304961 ethertype IPv4 (0x0800), length 266: 193.149.48.174 > 199.102.77.82: ip-proto-17

Which is the same thing than "--mtu-disc no".  So it seems MTU-Discovery
is just not working in our current code (does not work with older versions
either).  This needs revisiting, but wasn't broken by *this* patch.


For reference, this was 14/21 in v1+v2 of the patch series (Frank Lichtenheld
commented about .rst syntax), 09/14 in v3 of the patch series (which
got a NAK from me because it breaks 'ifconfig' MTU settings) and 03/08 in
v4 (NAK because UDP server crashed).  The patch itself mostly is the same 
as 09/14, but due 01/08 being applied first, ifconfig is no longer broken.


Some more thoughts:

 - should we make '--fragment' be pushable with the new code?  As the
   frame_calculate_dynamic() stuff is truly dynamic now, it might
   actually work...

 - this patch removes one check on reception (tls_pre_decrypt_lite())

     if (buf->len > EXPANDED_SIZE_DYNAMIC(&tas->frame))
     {
         dmsg(D_TLS_STATE_ERRORS,
             "TLS State Error: Large packet (size %d) received from %s -- a packet no larger than %d bytes was expected",

   We need to check if this is still safe against a malicious peer sending
   arbitrary huge packets (like, one side having set a --tun-mtu 9000).

   I did a bit of testing, and the results are... interesting.  Server 
   side with tun-mtu 1500, client with tun-mtu 9000.

   Up to a certain ping size, I can see pings going in and out on the
   server tun (tcpdump) just fine (with fragmentation being different
   back and forth):

10:20:08.382092 IP 10.204.2.30 > 10.204.2.1: ICMP echo request, id 8606, seq 1, length 1708
10:20:08.382131 IP 10.204.2.1 > 10.204.2.30: ICMP echo reply, id 8606, seq 1, length 1480
10:20:08.382137 IP 10.204.2.1 > 10.204.2.30: ip-proto-1

   over a certain size, network->tun ends up in OpenVPN refusing to put
   the packet into the tun interface

Feb 13 10:20:11 gentoo tun-udp-p2mp[20590]: cron2-gentoo-i386/193.149.48.178:39702 tun packet too large on write (tried=1828,max=1736)

  (but no crash, this is good)

  Now, increasing the packets to really huge sizes, we hit a buffer cap
  somewhere in the decrypt path

Feb 13 10:21:21 gentoo tun-udp-p2mp[20590]: cron2-gentoo-i386/193.149.48.178:39702 AEAD Decrypt error: cipher final failed

  (still no crash, this is good)

  So this *looks* as if OpenVPN is handling the szenario correctly, but
  I'd appreciate if someone knowledgeable would look into this as well.


commit 0d969976a338471869957d78867329b74ecf8bea
Author: Arne Schwabe
Date:   Sat Feb 12 01:33:31 2022 +0100

     Add mtu paramter to --fragment and change fragment calculation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220212003331.3483107-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23764.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


