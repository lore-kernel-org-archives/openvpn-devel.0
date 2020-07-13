References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
From: Dmitry Melekhov <dm@...1823...>
Message-ID: <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
Date: Mon, 13 Jul 2020 09:36:45 +0400
MIME-Version: 1.0
In-Reply-To: <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

12.07.2020 04:05, Arne Schwabe пишет:
> Am 23.06.20 um 11:12 schrieb Dmitry Melekhov:
>> 23.06.2020 13:02, Gert Doering пишет:
>>>
>>> That patch is from Steffan, and review has been sitting in my lap for
>>> way too long.  Need to see if it still applies.
>>>
>> Unfortunately it is not compatible with 2.4.9, because of introduced
>> change...
> Can you test with current openvpn master if that works for you? That has
> now allows you set the --cipher in ccd/connect-client scripts.
>
> Arne
>
Hello!

Compiled master from git, installed on server copy with Ubuntu 18.04.

Compiled  the same master with enable-small on my Ubuntu 20.04 desktop.

Added ncp-disable to config.

If cipher is different from default on client and there is no cipher in 
ccd for client - connection fails.

If I add specific cipher to client, i.e. ciphers match- everything is fine.


So, looks like it works, but unfortunately, there is problem:


Then I compiled openvpn-2.3.18 on Centos 6.

It connects if it is compiled by just  using configure.

But if I compile 2.3.18 with enable-small, then 2.5 server dies, always, 
even if there is no cipher in ccd and ciphers match.

On client side:

./openvpn belkam.ovpn
Mon Jul 13 09:33:17 2020 OpenVPN 2.3.18 x86_64-unknown-linux-gnu [SSL 
(OpenSSL)] [LZO] [EPOLL] [MH] [IPv6] built on Jul 13 2020
Mon Jul 13 09:33:17 2020 library versions: OpenSSL 1.0.1e-fips 11 Feb 
2013, LZO 2.03
Enter Auth Username:dm
Enter Auth Password:
Mon Jul 13 09:33:20 2020 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Mon Jul 13 09:33:20 2020 WARNING: file '/home/dm/openvpn/dm.key' is 
group or others accessible
Mon Jul 13 09:33:20 2020 Socket Buffers: R=[87380->87380] S=[16384->16384]
Mon Jul 13 09:33:20 2020 Attempting to establish TCP connection with 
[AF_INET]192.168.222.2:1194 [nonblock]
Mon Jul 13 09:33:21 2020 TCP connection established with 
[AF_INET]192.168.222.2:1194
Mon Jul 13 09:33:21 2020 TCPv4_CLIENT link local: [undef]
Mon Jul 13 09:33:21 2020 TCPv4_CLIENT link remote: 
[AF_INET]192.168.222.2:1194
Mon Jul 13 09:33:21 2020 TLS: Initial packet from 
[AF_INET]192.168.222.2:1194, sid=7c5295f5 d243c13b
Mon Jul 13 09:33:21 2020 WARNING: this configuration may cache passwords 
in memory -- use the auth-nocache option to prevent this
Mon Jul 13 09:33:21 2020 VERIFY OK: depth=1, C=RU, ST=Udm, L=Izhevsk, 
O=Belkam, OU=UIT, CN=vpn.belkam.com, emailAddress=support@...1823...
Mon Jul 13 09:33:21 2020 VERIFY OK: depth=0, C=RU, ST=Udm, L=Izhevsk, 
O=Belkam, OU=UIT, CN=ovpn1, emailAddress=support@...1823...
Mon Jul 13 09:33:22 2020 Data Channel Encrypt: Cipher 'AES-256-CBC' 
initialized with 256 bit key
Mon Jul 13 09:33:22 2020 Data Channel Encrypt: Using 160 bit message 
hash 'SHA1' for HMAC authentication
Mon Jul 13 09:33:22 2020 Data Channel Decrypt: Cipher 'AES-256-CBC' 
initialized with 256 bit key
Mon Jul 13 09:33:22 2020 Data Channel Decrypt: Using 160 bit message 
hash 'SHA1' for HMAC authentication
Mon Jul 13 09:33:22 2020 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 
ECDHE-RSA-AES256-GCM-SHA384, 1024 bit RSA
Mon Jul 13 09:33:22 2020 [ovpn1] Peer Connection Initiated with 
[AF_INET]192.168.222.2:1194
Mon Jul 13 09:33:22 2020 Connection reset, restarting [0]
Mon Jul 13 09:33:22 2020 SIGUSR1[soft,connection-reset] received, 
process restarting
Mon Jul 13 09:33:22 2020 Restart pause, 5 second(s)

On server side:

Jul 13 09:33:22 ovpn1 systemd[1]: openvpn@...2567...: Main process 
exited, code=killed, status=11/SEGV
Jul 13 09:33:22 ovpn1 systemd[1]: openvpn@...2567...: Killing 
process 9231 (openvpn) with signal SIGKILL.
Jul 13 09:33:22 ovpn1 systemd[1]: openvpn@...2567...: Failed with 
result 'signal'.


Servers just dies...

Thank you!



