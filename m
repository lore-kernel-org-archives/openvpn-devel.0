From: fragmentux <fragmentux@...277...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
 <CAKuzo_gx7Y28dtT+85HtSkKMh_UMU_+ZmbPV7-CLtLSrRP6mag@...278...>
 <7c8cb31e-13be-d4d2-7833-5503d1b385c8@...1147...>
 <02c60a84-e208-d4a4-491f-d18a2dab2934@...277...>
Message-ID: <6d800e7a-1e75-dfbc-6cd0-f9ee948a8a4b@...277...>
Date: Mon, 26 Mar 2018 22:36:12 +0100
MIME-Version: 1.0
In-Reply-To: <02c60a84-e208-d4a4-491f-d18a2dab2934@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
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
To: openvpn-devel@lists.sourceforge.net



On 26/03/18 22:21, fragmentux wrote:
> 
> 
> On 22/03/18 19:33, Jan Just Keijser wrote:
>> Hi Selva,
>>
>> On 22/03/18 18:12, Selva Nair wrote:
>>> On Thu, Mar 22, 2018 at 12:16 PM, Jan Just Keijser 
>>> <janjust@...1147...> wrote:
>>>> Hi Eric, all,
>>>>
>>>> On 22/03/18 04:25, Eric Thorpe wrote:
>>>>
>>>> Hi All,
>>>>
>>>> One of the Viscosity developers here. The TAP driver used by 
>>>> Viscosity is
>>>> based on the OpenVPN TAP-Windows driver. We're surprised to hear of any
>>>> performance differences, as the changes we've made are very minimal.
>>>>
>>>> Besides a name and version number change, the only other 
>>>> modification is a
>>>> change to the reported network adapter speed, which has Windows 
>>>> report the
>>>> driver as 1000 Mbit instead of 100 Mbit.
>>>>
>>>> This change was made not because of any actual performance gains, but
>>>> because of user reports that certain firewall or AV software tries 
>>>> to QoS
>>>> the adapter based on its reported adapter speed, which is of course a
>>>> problem if the VPN connection is capable of more than 100 Mbit.
>>>>
>>>> Please find a patch file of the changes attached.
>>>>
>>>>
>>>> first of all, thanks for responding so quickly.
>>>> I've done some further testing with Viscosity 1.6.8 (openvpn 2.3.14 
>>>> based)
>>>> compared to OpenVPN 2.4.5 and I am seeing a performance difference in a
>>>> gigabit test setup.  Strangely enough, it turns out that it's the 
>>>> *absence
>>>> of* AES256-GCM that makes my Viscosity client faster.
>>>> My test setup is as follows:
>>>>
>>>> - server: CentOS 7, openvpn 2.4.4, gigabit ethernet
>>>> - client: Win7 Pro, gigabit ethernet:
>>>>
>>>> Speeds (using "iperf -s" and "iperf -c 10.200.0.1 -r -l 4M -t 30"):
>>>>
>>>> viscosity:
>>>> 380 Mbps +/- 10 Mbps to server
>>>> 100 Mbps +/- 5 Mpbs from server
>>>>
>>>> Openvpn 2.4.5  --ncp-disable --cipher aes-256-cbc --auth sha256
>>>> 377 Mbps +/- 10 Mbps to server
>>>>    99 Mbps +/- 5 Mpbs from server
>>>>
>>>> Openvpn 2.4.5 (aes256-gcm)
>>>>   240 Mbps +/- 8 Mbps to server
>>>>    55 Mbps +/- 5 Mpbs from server
>>>>
>>>> So strangely enough it seems that AES-256-GCM is **slower** for Windows
>>>> clients. Note that in this setup the server config never changed.
>>> I haven't tested openvpn itself but have noticed in openssl speed
>>> tests that AES-256-CBC is significantly faster than AES-256-GCM on
>>> Windows (opposite to Linux). That was with openssl 1.0.x, probably
>>> 1.1.0 is similar (2.4.5 Windows release is built with 1.1.0).
>>>
>>> However, the raw cipher speeds are much larger than these throughputs
>>> so its surprising that the change of cipher alone makes such a
>>> difference.
>>>
>>> Why is the throughput so asymmetric?
>>>
>>>
>> thanks for the confirmation; as for the assymmetry: that can be due to 
>> many factors, including hardware differences (there is asymmetry on 
>> Linux as well). It could also be due to the way the tap driver works, 
>> but I have never been able to get my finger on that , and I don't use 
>> Windows often enough to bother.
>>
> 
> 
> Thought I would have a look at this and I do not find this asymmetry ..
> 
> 
> vpn & iperf server = Linux debian 8
> iperf version 2.0.5 (08 Jul 2010) pthreads
> 
> Mon Mar 26 12:39:03 2018 us=287116 OpenVPN 2.5_git+ipv6pf 
> [git:master/1111902c1f1c71ac+] x86_64-unknown-linux-gnu [SSL (OpenSSL)] 
> [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Jan  1 2018
> Mon Mar 26 12:39:03 2018 us=287135 library versions: OpenSSL 1.0.1t  3 
> May 2016, LZO 2.08
> 
> 
> vpn & iperf client (1) = Windows 10
> iperf version 2.0.10 (11 Aug 2017) pthreads
> 
> Mon Mar 26 21:25:46 2018 us=107859 OpenVPN 2.4.5 
> [git:2.4/161afbebdc2b7e24+] x86_64-w64-mingw32 [SSL (OpenSSL)] [LZO] 
> [LZ4] [PKCS11] [AEAD] built on Mar  1 2018
> 
> Mon Mar 26 21:25:46 2018 us=107859 Windows version 6.2 (Windows 8 or 
> greater) 64bit
> 
> Mon Mar 26 21:25:46 2018 us=107859 library versions: OpenSSL 1.1.0g  2 
> Nov 2017, LZO 2.10
> 
> 
> vpn & iperf client (2) = Linux Arch
> iperf version 2.0.10 (11 Aug 2017) pthreads
> 
> Mon Mar 26 21:36:17 2018 us=258243 OpenVPN 2.4.4 
> x86_64-unknown-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] 
> [MH/PKTINFO] [AEAD] built on Sep 26 2017
> Mon Mar 26 21:36:17 2018 us=258256 library versions: OpenSSL 1.1.0g  2 
> Nov 2017, LZO 2.10
> 
> 
> 
> 
> *** Output from server iperf:
> 
> 
> client: iperf -c 10.56.101.238 -r -l 4M -t 30
> 
> * Linux server (vpn and iperf) -- AES-256-CBC **
> 
> iperf -s
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 85.3 KByte (default)
> ------------------------------------------------------------
> 
> 
> * Windows client (vpn and iperf)
> 
> [  4] local 10.56.101.238 port 5001 connected with 10.56.101.110 port 51370
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-30.1 sec   480 MBytes   134 Mbits/sec
> ------------------------------------------------------------
> Client connecting to 10.56.101.110, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested  867 MByte)
> ------------------------------------------------------------
> [  4] local 10.56.101.238 port 48867 connected with 10.56.101.110 port 5001
> [  4]  0.0-30.3 sec   568 MBytes   157 Mbits/sec
> 
> 
> iperf -s
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 85.3 KByte (default)
> ------------------------------------------------------------
> 
> 
> * Linux client (vpn and iperf)
> 
> [  4] local 10.56.101.238 port 5001 connected with 10.56.101.226 port 40284
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-30.2 sec   708 MBytes   197 Mbits/sec
> ------------------------------------------------------------
> Client connecting to 10.56.101.226, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested  867 MByte)
> ------------------------------------------------------------
> [  4] local 10.56.101.238 port 36629 connected with 10.56.101.226 port 5001
> [  4]  0.0-30.3 sec   728 MBytes   201 Mbits/sec
> 
> 
> 
> 
> 
> * Linux server (vpn and iperf) -- AES-256-GCM **
> 
> iperf -s
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 85.3 KByte (default)
> ------------------------------------------------------------
> 
> 
> * Windows client (vpn and iperf)
> 
> [  4] local 10.56.101.238 port 5001 connected with 10.56.101.110 port 51345
> [ ID] Interval       Transfer     Bandwidth
> [  4]  0.0-30.2 sec   528 MBytes   147 Mbits/sec
> ------------------------------------------------------------
> Client connecting to 10.56.101.110, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested  867 MByte)
> ------------------------------------------------------------
> [  4] local 10.56.101.238 port 48864 connected with 10.56.101.110 port 5001
> [  4]  0.0-30.5 sec   548 MBytes   151 Mbits/sec
> 
> 
> * Linux client (vpn and iperf)
> 
> [  5] local 10.56.101.238 port 5001 connected with 10.56.101.226 port 40280
> [  5]  0.0-30.2 sec   812 MBytes   226 Mbits/sec
> ------------------------------------------------------------
> Client connecting to 10.56.101.226, TCP port 5001
> TCP window size:  416 KByte (WARNING: requested  867 MByte)
> ------------------------------------------------------------
> [  5] local 10.56.101.238 port 36626 connected with 10.56.101.226 port 5001
> [  5]  0.0-30.3 sec   844 MBytes   234 Mbits/sec
> 
> 
> 
> For clarity, my network is a little unusual.
> 
> The Windows vpn/iperf client is real hardware running Hyper-V
> The debian and Arch Linux are Hyper-V clients on the Win10 host above.
> 
> eth0 IPs for these machines:
> Win10 : 10.10.201.110/24 (Gb ethernet net binding to Hyper-V Switch)
> Deb8  : 10.10.201.238/24 (Hyper-V Switch above)
> Arch  : 10.10.201.226/24 (Hyper-V Switch above)
> 
> I don't know to what extent that will effect the results.
> 
> Note for JJK, you asked if maybe you had done something wrong .. well ..
> 
> When I first ran the tests I did find a huge asymmetry but I found the
> cause, in my case.  Initially the Win10 machine was in subnet 
> 10.10.101.0/24 not .201.0/24 (that is a little quirk I had setup to test
> routing (and some other odds and ends), the router supports multiple IPs
> per interface, so i was tempted away from the true path but I restored
> all machines to the .201.0/24 subnet and found my asymmetry had gone.
> Aping your favourite sig. "HTH" somehow :-)
> 

Just for clarity, the vpn server had a direct route for the client, due
to how I had it setup, where as the client routed via the gateway.
So I removed that issue.

cheers



