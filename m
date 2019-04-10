References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
 <e6c17503-b1b4-7bba-e03e-3a8c8b6565e6@...1227...>
From: Michal Soltys <soltys@...2503...>
Message-ID: <299950cf-ab6b-527c-ae95-d035457077d2@...2503...>
Date: Wed, 10 Apr 2019 15:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <e6c17503-b1b4-7bba-e03e-3a8c8b6565e6@...1227...>
Content-Language: en-US-large
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 4/10/19 10:24 AM, Arne Schwabe wrote:
> Am 09.04.19 um 16:34 schrieb Michal Soltys:
>> The man page states that when using --capath, the user is required to
>> provide CRLs for CAs. This is not true and providing CRLs is optional -
>> both in case of --capath as well as --crl-verify options. When relevant
>> CRL is not found OpenVPN simply logs the warning in the logs while
>> allowing the connection, e.g.:
>>
> 
> On my server the connection used to fail without CRLs. I just retested
> this and with OpenSSL 1.1.1 there is not even a warning, so I am really
> confused now.
> 
> Arne

Hmm, I do have warnings (with 1.1.1 and 1.1.0), at least at --verb 3:

Wed Apr 10 15:42:44 2019 OpenVPN 2.4.7 [git:makepkg/2b8aec62d5db2c17+] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Feb 19 2019
Wed Apr 10 15:42:44 2019 library versions: OpenSSL 1.1.1b  26 Feb 2019, LZO 2.10
Wed Apr 10 15:42:44 2019 Diffie-Hellman initialized with 1024 bit key
Wed Apr 10 15:42:44 2019 WARNING: experimental option --capath /home/nozo/openvpn-test/certs
Wed Apr 10 15:42:44 2019 ECDH curve prime256v1 added
Wed Apr 10 15:42:44 2019 TUN/TAP device tunovn opened
Wed Apr 10 15:42:44 2019 TUN/TAP TX queue length set to 100
Wed Apr 10 15:42:44 2019 /usr/bin/ip link set dev tunovn up mtu 1500
Wed Apr 10 15:42:44 2019 /usr/bin/ip addr add dev tunovn 10.15.30.1/24 broadcast 10.15.30.255
Wed Apr 10 15:42:44 2019 Socket Buffers: R=[212992->212992] S=[212992->212992]
Wed Apr 10 15:42:44 2019 UDPv4 link local (bound): [AF_INET][undef]:1194
Wed Apr 10 15:42:44 2019 UDPv4 link remote: [AF_UNSPEC]
Wed Apr 10 15:42:44 2019 MULTI: multi_init called, r=256 v=256
Wed Apr 10 15:42:44 2019 IFCONFIG POOL: base=10.15.30.2 size=252, ipv6=0
Wed Apr 10 15:42:44 2019 Initialization Sequence Completed
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 TLS: Initial packet from [AF_INET]192.168.77.99:54604, sid=67ca0e76 da568cb7
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY WARNING: depth=0, unable to get certificate CRL: C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=Touki, CN=msl
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY WARNING: depth=1, unable to get certificate CRL: C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=IT, CN=TouK Intermediate X1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY WARNING: depth=2, unable to get certificate CRL: C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=IT, CN=TouK Root X1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY OK: depth=2, C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=IT, CN=TouK Root X1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY OK: depth=1, C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=IT, CN=TouK Intermediate X1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 VERIFY OK: depth=0, C=PL, ST=Mazowieckie, L=Warszawa, O=TouK sp. z o.o. s.k.a., OU=Touki, CN=msl
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_VER=2.4.7
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_PLAT=linux
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_PROTO=2
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_NCP=2
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_LZ4=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_LZ4v2=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_LZO=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_COMP_STUB=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_COMP_STUBv2=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 peer info: IV_TCPNL=1
Wed Apr 10 15:42:48 2019 192.168.77.99:54604 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 256 bit EC, curve: prime256v1


