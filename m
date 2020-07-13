References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
 <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
 <3f6159de-c513-78d5-194c-989a8611c291@...1823...>
 <20200713061023.GK1431@...1296...> <20200713063303.GM1431@...1296...>
 <20200713065828.GN1431@...1296...>
From: Dmitry Melekhov <dm@...1823...>
Message-ID: <0fd510b1-2d22-c860-79b2-e3ea01609c77@...1823...>
Date: Mon, 13 Jul 2020 11:12:30 +0400
MIME-Version: 1.0
In-Reply-To: <20200713065828.GN1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] git master crashes on connect of 2.3 client
 with --enable-small
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

13.07.2020 10:58, Gert Doering пишет:
> Hi,
>
> On Mon, Jul 13, 2020 at 08:33:03AM +0200, Gert Doering wrote:
>> On Mon, Jul 13, 2020 at 08:10:23AM +0200, Gert Doering wrote:
>>> Ouch.  This is not good.  My gut feeling is "2.3 with --enable-small =
>>> no OCC *and* no NCP = the server runs across a NULL pointer here".
>> Bäm.  Fully reproduceable here
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>> (gdb) where
>> #0  0x00007ffff7af51be in ?? () from /lib64/libc.so.6
>> #1  0x00005555555d4a7b in ncp_get_best_cipher (server_list=<optimized out>,
>>      server_cipher=0x5555555f28da "BF-CBC",
>>      peer_info=peer_info@...1851...=0x5555556781c0 "IV_VER=2.3.18\nIV_PLAT=freebsd\nIV_PROTO=2\n", remote_cipher=0x0, gc=gc@...1851...=0x55555565e070) at ssl_ncp.c:231
> ... and this is why (added a msg() call):
>
> 2020-07-13 08:36:59 us=802772 ncp_get_best_cipher(), peer_ncp_list=, tmp_ciphers=AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC:AES-256-CBC, remote_cipher=(null), server_cipher=BF-CBC
>
> if "remote_cipher" is NULL (= no OCC) we pass that to "strcmp()", and that
> does not want it.
>
>
> Returning NULL from ncp_get_best_cipher() if there is nothing the client
> has to offer works fine, though it triggers this warning
>
> 2020-07-13 08:43:01 us=483904 cron2-freebsd-tc-amd64-23/194.97.140.21:30927 PUSH: No common cipher between server and client.Expect this connection not to work. Server ncp-ciphers: 'AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC:AES-256-CBC', client supported ciphers ''
>
>
> which we might want to reword for this case ("No information about cipher
> support received from client, cannot ensure correct operation" or so).
>
> Patch appended.
>
> Comments?
>
> gert

I just applied patch, now server works correctly with 2.3.18 client 
compiled with enable-small

and with 2.5git with enable-small and ncp-disable in config.

I.e. everything works as expected.


Thank you!



