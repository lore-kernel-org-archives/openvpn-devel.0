References: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
	<20161006121736.GB78279@...1296...>
	<50515770-ae2b-ee70-9ada-452f69cce800@...1227...>
From: debbie10t <debbie10t@...277...>
Message-ID: <a24673c2-2aca-7bcb-6826-23335bf5a557@...277...>
Date: Thu, 6 Oct 2016 14:10:51 +0100
MIME-Version: 1.0
In-Reply-To: <50515770-ae2b-ee70-9ada-452f69cce800@...1227...>
Subject: Re: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
 t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 06/10/16 13:25, Arne Schwabe wrote:
>
>
> Am 06.10.16 um 14:17 schrieb Gert Doering:
>> Hi,
>>
>> On Thu, Oct 06, 2016 at 01:02:57PM +0100, debbie10t wrote:
>>> -R
>>> Instead of using all-zeros as the packet data, generate random bytes.
>>> Use to defeat, e.g., link data compression
>> -R is unlikely to have an effect here, as test 6 is run without
>> compression anyway (to the contrary, it would *fail* your tests that
>> succeed today due to compression :-) )
>>
>>
> You just giving a good point to add -R anyway!
>
> Arne
>

Turns out -R is not currently supported by CentOS7:
$ fping -v
fping: Version 3.10
fping: comments to david@...2173...

$ fping -R -b 3000 -c 10 -p 250 10.194.6.1 10.194.0.1
fping: invalid option -- 'R'

Arch-linux:
$ fping -v
fping: Version 3.13

So I guess it is not worth over complicating t_client for that.


===

However, -i appears to be commonly supported and this is the effect for me:

---

[root@...2174... t_client-arch-hyv-live-64-20161004-210205]# fping 
-b 3000 -c 10 -p 250 10.194.6.1 10.194.0.1
10.194.6.1 : [0], 3028 bytes, 551 ms (551 avg, 66% loss)

10.194.6.1 : xmt/rcv/%loss = 10/1/90%, min/avg/max = 551/551/551
10.194.0.1 : xmt/rcv/%loss = 10/0/100%

---

[root@...2174... t_client-arch-hyv-live-64-20161004-210205]# fping 
-i 1000 -b 3000 -c 10 -p 250 10.194.6.1 10.194.0.1
10.194.6.1 : [0], 3028 bytes, 550 ms (550 avg, 0% loss)
10.194.0.1 : [0], 3028 bytes, 552 ms (552 avg, 0% loss)
10.194.6.1 : [1], 3028 bytes, 550 ms (550 avg, 0% loss)
10.194.0.1 : [1], 3028 bytes, 552 ms (552 avg, 0% loss)
10.194.6.1 : [2], 3028 bytes, 549 ms (550 avg, 0% loss)
10.194.0.1 : [2], 3028 bytes, 552 ms (552 avg, 0% loss)
10.194.6.1 : [3], 3028 bytes, 549 ms (550 avg, 0% loss)
10.194.0.1 : [3], 3028 bytes, 551 ms (552 avg, 0% loss)
10.194.6.1 : [4], 3028 bytes, 553 ms (550 avg, 0% loss)
10.194.0.1 : [4], 3028 bytes, 573 ms (556 avg, 0% loss)
10.194.6.1 : [5], 3028 bytes, 552 ms (551 avg, 0% loss)
10.194.0.1 : [5], 3028 bytes, 550 ms (555 avg, 0% loss)
10.194.6.1 : [6], 3028 bytes, 552 ms (551 avg, 0% loss)
10.194.0.1 : [6], 3028 bytes, 558 ms (555 avg, 0% loss)
10.194.6.1 : [7], 3028 bytes, 551 ms (551 avg, 0% loss)
10.194.0.1 : [7], 3028 bytes, 548 ms (554 avg, 0% loss)
10.194.6.1 : [8], 3028 bytes, 555 ms (551 avg, 0% loss)
10.194.0.1 : [8], 3028 bytes, 557 ms (555 avg, 0% loss)
10.194.6.1 : [9], 3028 bytes, 563 ms (553 avg, 0% loss)
10.194.0.1 : [9], 3028 bytes, 570 ms (556 avg, 0% loss)

10.194.6.1 : xmt/rcv/%loss = 10/10/0%, min/avg/max = 549/553/563
10.194.0.1 : xmt/rcv/%loss = 10/10/0%, min/avg/max = 548/556/573

---

So, if you want the fping's to work adding configurable "-i $interval" 
to t_client.sh.in/t_client.rc looks like a simple enough solution.

Thanks

