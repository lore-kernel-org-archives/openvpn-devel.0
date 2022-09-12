Date: Mon, 12 Sep 2022 14:09:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx8hkCs4tOK5+dBl@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
 <2DCBB302-1FB4-4EC0-8B4A-8D6EA075B0FD@...2661...>
 <YvVwcBtzGagtUgOA@...1296...>
 <8E0AADE4-350B-46A5-B4BD-5E97ADA642F4@...2661...>
 <YveWP9xh9XwsjwPY@...1296...> <Yve0gy+SuH+7unUj@...1296...>
 <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
MIME-Version: 1.0
In-Reply-To: <7CB2FF09-EE1D-427E-BBD1-4128EAE1ED4A@...2661...>
Subject: Re: [Openvpn-devel] big packet loss with FreeBSD DCO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Kristof Provost <kprovost@...2661...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

(copying back the list)

On Mon, Aug 15, 2022 at 03:42:38PM +0200, Kristof Provost wrote:
> Thanks. That works, and I also see the failure with fragmented packets.
> I still have no idea why though. Things look correct on the sending 
> side.
> 
> I did spend a little time finding the exact size where things break, and 
> that???s kind of interesting.
> `sudo ping -c 1 -s 1460 10.194.2.1` succeeds. One byte larger fails.
> 
> That???s very odd, because at 1460 payload bytes we???re already 
> fragmenting the OpenVPN UDP packet (and are still getting a reply), so 
> it looks like the fragmentation in the DCO code does actually work. 
> I???ve also tested larger packets locally, both to a FreeBSD and a Linux 
> server, and those setups also work.

Indeed, I can verify this - ping -s 1460 works, with outside fragmentation

13:49:51.927371 IP 194.97.140.5.11281 > 199.102.77.82.51194: UDP, bad length 1512 > 1472
13:49:51.927392 IP 194.97.140.5 > 199.102.77.82: ip-proto-17
13:49:52.051249 IP 199.102.77.82.51194 > 194.97.140.5.11281: UDP, bad length 1512 > 1472
13:49:52.051272 IP 199.102.77.82 > 194.97.140.5: ip-proto-17

... while ping -s 1461 does not, and as you say, no inside fragmentation

13:50:27.586117 IP 10.194.2.250 > 10.194.0.1: ICMP echo request, id 49007, seq 0, length 1469
13:50:28.617012 IP 10.194.2.250 > 10.194.0.1: ICMP echo request, id 49007, seq 1, length 1469

13:50:27.586383 IP 194.97.140.5.11281 > 199.102.77.82.51194: UDP, bad length 1528 > 1472
13:50:27.586410 IP 194.97.140.5 > 199.102.77.82: ip-proto-17
13:50:28.617296 IP 194.97.140.5.11281 > 199.102.77.82.51194: UDP, bad length 1528 > 1472
13:50:28.617316 IP 194.97.140.5 > 199.102.77.82: ip-proto-17


it *does* bump the outside packet length up by +16 bytes ("bad length 1512" -> 
"1528").  Smells cipher algorithm padding or so - but why 16?  And why pad
at all (AES-256-GCM used, so I think we should not pad)?

Side note: with --disable-dco, I see

13:54:01.612513 IP 194.97.140.5.15009 > 199.102.77.82.51194: UDP, bad length 1513 > 1472
13:54:01.612531 IP 194.97.140.5 > 199.102.77.82: ip-proto-17
13:54:01.736280 IP 199.102.77.82.51194 > 194.97.140.5.15009: UDP, bad length 1513 > 1472
13:54:01.736305 IP 199.102.77.82 > 194.97.140.5: ip-proto-17

so "1513".


Staring at the (outside) packets quite hard with wireshark seems to
find nothing wrong, except that the DCO packets are larger

DCO (ping -s 1461 inside):

    [2 IPv4 Fragments (1536 bytes): #1(1480), #2(56)]
        [Frame: 1, payload: 0-1479 (1480 bytes)]
        [Frame: 2, payload: 1480-1535 (56 bytes)]
        [Fragment count: 2]
        [Reassembled IPv4 length: 1536]
        [Reassembled IPv4 data: 3a2ec7fa060000004800000100000007f05d4cba392aa46a1fc360c7f6f2f9501627a9fd?]

User Datagram Protocol, Src Port: 14894, Dst Port: 51194
[..]
    Length: 1536
    UDP payload (1528 bytes)


--disable-dco

    [2 IPv4 Fragments (1521 bytes): #17(1480), #18(41)]
        [Frame: 17, payload: 0-1479 (1480 bytes)]
        [Frame: 18, payload: 1480-1520 (41 bytes)]
        [Fragment count: 2]
        [Reassembled IPv4 length: 1521]
        [Reassembled IPv4 data: c7fa3aa105f181a54800000000000013d5180c49e3b09a9cd7c61c07e1e5392d3e45f517?]
User Datagram Protocol, Src Port: 51194, Dst Port: 15009
[..]
    Length: 1521
    UDP payload (1513 bytes)
Data (1513 bytes)


There's a FreeBSD pf(4) in between the client and the server, and
that firewall finds the packets acceptable - so I think the outside
packets are good.


But THERE is an indication in the log:

Sep 12 08:01:59 phillip tun-udp-p2mp[52730]: freebsd-14-amd64/194.97.140.5:14894 tun packet too large on write (tried=1504,max=1500)

this is the "I have received a packet from the network, decrypted it, and
tried to send it onwards towards the tun interface, and it was too large".

So my guess is that "something" gets confused on the sending side DCO, and
corrupts the payload size (-> so '-s 1461' becomes '-s 1476' = 16 byte
increase instead of +1, resulting in 'ip packet size 1504' on the receiving
end).  The t_client server is running a slightly older master, which 
enforces the "mtu is 1500, so no bigger packets", newer openvpn are 
are somewhat more permissive on incoming baby giants.


So, observation suggests "it's happening inside the DCO module".  I'll
go instrument my kernel with printf()'s now... and will report if I find
anything useful.

gert
-- 
"If was one thing all people took for granted, was conviction that if you 
 feed honest figures into a computer, honest figures come out. Never doubted 
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistress

Gert Doering - Munich, Germany                             gert@...1296...

