References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <4da8bb9a-7118-e0ab-ba7d-bc813e33d7c4@...515...>
Date: Fri, 5 Jan 2018 08:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
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
To: Tom Kunz <tkunz@...2030...>, "Greg Sloop <gregs@...1934...>" <gregs@...1934...>
Cc: openvpn-devel@lists.sourceforge.net

This does not answer your question, either, but there are more details
on OpenVPN performance optimization here:

<https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>

Increasing the MTU helps as it reduces the number of user<->kernel-space
switches.

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

Il 05/01/2018 01:52, Tom Kunz ha scritto:
> That would explain it if it always worked that way.
> But I can get 400%+ wire speed from A to B with compressible data, and
> 102% with incompressible data.  If I do the same test from B to A or A
> to B, I get those results.  If I hop off of that to C, speed goes from
>>1Gbps to sub-200Mbps.  In either case, the data has left the kernel
> space to arrive at "nc", so just simply saying "it's kernel vs user"
> doesn't answer it.
> 
> 
> On 01/04/2018 06:37 PM, Greg Sloop <gregs@...1934...> wrote:
>> I'm sure someone else, or a Google search will get you a more detailed
>> run-down - but the gist of the "problem" is this;
>>
>> OpenVPN is run in user-space, not kernel space. IPSec  runs in kernel
>> space, and the difference is vastly diminished throughput.
>>
>> HTH
>>
>> -Greg
>>
>> On Jan 4, 2018 3:23 PM, "Tom Kunz" <tkunz@...2030...
>> <mailto:tkunz@...2030...>> wrote:
>>
>>     Hi,
>>
>>     I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as
>>     transport, and I have found something that I think might be a
>>     performance issue.  I have 3 linux boxes, A, B, and C.  All interfaces
>>     are 1Gbps.  Each has an interface to the next one downstream:
>>
>>     A - eth0=10.10.10.10/24 <http://10.10.10.10/24> and
>>     eth1=172.16.0.10/24 <http://172.16.0.10/24>
>>
>>     B - eth0=172.16.0.11/24 <http://172.16.0.11/24> and
>>     eth1=172.30.0.11/24 <http://172.30.0.11/24>
>>
>>     C - eth0=172.30.0.10/24 <http://172.30.0.10/24> and
>>     eth1=192.168.168.10/24 <http://192.168.168.10/24>
>>
>>     Packets route as usual through this with no encryption, and throughput
>>     from A to C is at wire speed.  With IPSec between A&B, from
>>     172.16.0.10-172.16.0.11, I can still get wire speed from A to C. 
>>     Then I
>>     turn off IPSec, and I setup A as the server and B as the client, with
>>     A's config being:
>>
>>     =====
>>
>>     dev tun
>>
>>     topology subnet
>>     server 172.17.0.0 255.255.255.0
>>     port 1194
>>     proto udp
>>     dh /etc/openvpn/keys/dh2048.pem
>>     ca /etc/openvpn/keys/ca.crt
>>     cert /etc/openvpn/keys/server.crt
>>     key /etc/openvpn/keys/server.key
>>     verb 3
>>     keepalive 10 45
>>     cipher aes-256-cbc
>>     comp-lzo
>>
>>     tun-mtu 50000
>>
>>     mssfix 0
>>
>>     fragment 0
>>
>>     client-config-dir ccd
>>
>>     push "route 10.10.10.0 255.255.255.0"
>>
>>     =====
>>
>>     and the client B config file is
>>
>>     =====
>>
>>     verb 3
>>     client
>>     cipher AES-256-CBC
>>     comp-lzo
>>     tun-mtu 50000
>>     mssfix 0
>>     fragment 0
>>     remote 172.16.0.10  1194
>>
>>     dev tun
>>     redirect-private local
>>     tls-client
>>
>>     ca /etc/openvpn/keys/ca.crt
>>     cert /etc/openvpn/keys/client1.crt
>>     key /etc/openvpn/keys/client1.key
>>
>>     =====
>>
>>     and I setup static routes on each side so that traffic is going
>>     through
>>     the tunnel from A to C and vice versa.
>>
>>     I can pass traffic over this link, however when I do tests for
>>     speed, I
>>     am only getting about 200Mbps instead of 1Gbps.
>>
>>     The funny thing is, I know that each of these machines can easily do
>>     1Gbps.  If I do my performance test from A to B, over the above ovpn
>>     configs, I can get just over 1Gbps because of the MTU overhead being
>>     removed. But as soon as I have it make the leap downstream once
>>     more, I
>>     lose 80+% of the speed.  And again, both non-encrypted traffic and
>>     IPSec
>>     do the exact same test at wire speed or just slightly under wire
>>     speed.
>>
>>     The way I do a speed test is on A:
>>
>>     # nc -l -p 5555 > /dev/null
>>
>>     and over on C:
>>
>>     # dd if=/dev/urandom of=blob.random.1G bs=10M count=100
>>
>>     # time cat blob.random.1G | nc 10.10.10.10 5555
>>
>>     tcpdumps over each interface confirm traffic is flowing in the
>>     expected
>>     fashion.
>>
>>     Over unencrypted or IPSec, I am looking at about 4s to move 1G of data
>>     from one end to the other, and with ovpn, 15-22s.  The machines
>>     involved
>>     are 2 Dell R720's with 8+G ram and a homebrew machine with several
>>     Xeons
>>     and 32G RAM.  Network cards involved are a mix of BCM Tigon3 "tg3"
>>     driver and IGB driver gigabit NICs.
>>
>>     Anyone have any suggestions or thoughts as to why the big perf
>>     decrease
>>     and what might be done to improve it?
>>
>>     Thanks, 
>>
>>     Tom
>>
>>
>>
>>
>>     ------------------------------------------------------------------------------
>>     Check out the vibrant tech community on one of the world's most
>>     engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>     _______________________________________________
>>     Openvpn-devel mailing list
>>     Openvpn-devel@lists.sourceforge.net
>>     <mailto:Openvpn-devel@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
>>
> 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


