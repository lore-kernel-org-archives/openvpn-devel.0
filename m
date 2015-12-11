Message-ID: <AF48117BC12D429393E4D93EFBA7E72E@...2089...>
From: <debbie10t@...277...>
Date: Fri, 11 Dec 2015 19:35:18 -0000
MIME-Version: 1.0
Subject: [Openvpn-devel] Opttion "client-nat" not recognised
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

today, I was working with an old config which uses --client-nat
I upgraded that particular client to git-master for testing and
discovered that git-master currently does not support --client-nat

This config works perfectly with older versions,
details follow:

GIT-master versions which --client-nat does *not* work:
- dated 2015Nov25 (My first test)
- dated 2015Aug02 (Another clone I had available)
- dated 2015Dec11 (make sure i was not going more nuts! than usual)

GIT-mater versions which --client-nat *does* work:
- dated 2015Jun12

Official version which --client-nat *does* work:
Linux-Mint: Ubuntu 14.04.1
- OpenVPN 2.3.2 x86_64-pc-linux-gnu <..> built on Dec  1 2014

If you prefer this reported on trac please let me know.

CLIENT LOG FILE WORKING:

Fri Dec 11 18:36:50 2015 us=948077 OpenVPN 2.3_git 12.June.2015 
[git:master/60fd44e501f20024+] x86_64-unknown-linux-gnu [SSL (OpenSSL)] 
[LZO] [LZ4] [EPOLL] [MH] [IPv
6] built on Dec 11 2015
Fri Dec 11 18:36:50 2015 us=948133 library versions: OpenSSL 1.0.1f 6 Jan 
2014, LZO 2.06

<..>

Fri Dec 11 18:36:54 2015 us=118430 PUSH: Received control message: 
'PUSH_REPLY,ifconfig-ipv6 2001:db8:0:123::101/64 
2001:db8:0:123::86,route-gateway 10.234.64.86,topology 
subnet,explicit-exit-notify 3,ping 10,ping-restart 30,tun-ipv6,client-nat 
snat   10.1.101.0 255.255.255.0 10.201.101.0 255.255.255.0,client-nat dnat 
10.201.101.0 255.255.255.0   10.1.101.0 255.255.255.0,setenv-safe 
client_dynamic 1,ifconfig 10.234.64.101 255.255.255.0,peer-id 0'
Fri Dec 11 18:36:54 2015 us=118553 Option 'explicit-exit-notify' in 
[PUSH-OPTIONS]:4 is ignored by previous <connection> blocks
Fri Dec 11 18:36:54 2015 us=118691 OPTIONS IMPORT: timers and/or timeouts 
modified
Fri Dec 11 18:36:54 2015 us=118726 OPTIONS IMPORT: explicit notify parm(s) 
modified
Fri Dec 11 18:36:54 2015 us=118764 OPTIONS IMPORT: --ifconfig/up options 
modified
Fri Dec 11 18:36:54 2015 us=118798 OPTIONS IMPORT: route options modified
Fri Dec 11 18:36:54 2015 us=118832 OPTIONS IMPORT: route-related options 
modified
Fri Dec 11 18:36:54 2015 us=118867 OPTIONS IMPORT: environment modified
Fri Dec 11 18:36:54 2015 us=118904 OPTIONS IMPORT: peer-id set
Fri Dec 11 18:36:54 2015 us=118938 OPTIONS IMPORT: adjusting link_mtu to 
1605
Fri Dec 11 18:36:54 2015 us=119710 TUN/TAP device tun23464 opened
Fri Dec 11 18:36:54 2015 us=119802 TUN/TAP TX queue length set to 100
Fri Dec 11 18:36:54 2015 us=119873 do_ifconfig, tt->ipv6=1, 
tt->did_ifconfig_ipv6_setup=1
Fri Dec 11 18:36:54 2015 us=119971 /sbin/ifconfig tun23464 10.234.64.101 
netmask 255.255.255.0 mtu 1500 broadcast 10.234.64.255
Fri Dec 11 18:36:54 2015 us=125237 /sbin/ifconfig tun23464 add 
2001:db8:0:123::101/64
Fri Dec 11 18:36:54 2015 us=134693 Initialization Sequence Completed



CLIENT LOG FILE *NOT* WORKING:

Fri Dec 11 19:08:10 2015 us=348536 OpenVPN 2.3_git 
[git:master/4baec3ee10b8d682] x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] 
[LZ4] [EPOLL] [MH] [IPv6] built on De
c 11 2015
Fri Dec 11 19:08:10 2015 us=348583 library versions: OpenSSL 1.0.1f 6 Jan 
2014, LZO 2.06

<..>

Fri Dec 11 19:08:12 2015 us=645088 PUSH: Received control message: 
'PUSH_REPLY,ifconfig-ipv6 2001:db8:0:123::101/64 
2001:db8:0:123::86,route-gateway 10.234.64.86,topology 
subnet,explicit-exit-notify 3,ping 10,ping-restart 30,tun-ipv6,client-nat 
snat   10.1.101.0 255.255.255.0 10.201.101.0 255.255.255.0,client-nat dnat 
10.201.101.0 255.255.255.0   10.1.101.0 255.255.255.0,setenv-safe 
client_dynamic 1,ifconfig 10.234.64.101 255.255.255.0,peer-id 0'
Fri Dec 11 19:08:12 2015 us=645213 Option 'explicit-exit-notify' in 
[PUSH-OPTIONS]:4 is ignored by previous <connection> blocks
Fri Dec 11 19:08:12 2015 us=645281 Options error: Unrecognized option or 
missing or extra parameter(s) in [PUSH-OPTIONS]:8: client-nat (2.3_git)
Fri Dec 11 19:08:12 2015 us=645328 Options error: Unrecognized option or 
missing or extra parameter(s) in [PUSH-OPTIONS]:9: client-nat (2.3_git)
Fri Dec 11 19:08:12 2015 us=645418 OPTIONS IMPORT: timers and/or timeouts 
modified
Fri Dec 11 19:08:12 2015 us=645445 OPTIONS IMPORT: explicit notify parm(s) 
modified
Fri Dec 11 19:08:12 2015 us=645470 OPTIONS IMPORT: --ifconfig/up options 
modified
Fri Dec 11 19:08:12 2015 us=645494 OPTIONS IMPORT: route-related options 
modified
Fri Dec 11 19:08:12 2015 us=645519 OPTIONS IMPORT: environment modified
Fri Dec 11 19:08:12 2015 us=645543 OPTIONS IMPORT: peer-id set
Fri Dec 11 19:08:12 2015 us=645568 OPTIONS IMPORT: adjusting link_mtu to 
1605
Fri Dec 11 19:08:12 2015 us=646219 TUN/TAP device tun23464 opened
Fri Dec 11 19:08:12 2015 us=646324 TUN/TAP TX queue length set to 100
Fri Dec 11 19:08:12 2015 us=646403 do_ifconfig, tt->ipv6=1, 
tt->did_ifconfig_ipv6_setup=1
Fri Dec 11 19:08:12 2015 us=646506 /sbin/ifconfig tun23464 10.234.64.101 
netmask 255.255.255.0 mtu 1500 broadcast 10.234.64.255
Fri Dec 11 19:08:12 2015 us=663984 /sbin/ifconfig tun23464 add 
2001:db8:0:123::101/64
Fri Dec 11 19:08:12 2015 us=669056 Initialization Sequence Completed


