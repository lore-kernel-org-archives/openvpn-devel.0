Message-ID: <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
Date: Fri, 10 Nov 2023 12:25:22 +0400
MIME-Version: 1.0
Content-Language: en-US, ru-RU
From: Dmitry Melekhov <dm@...1823...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
In-Reply-To: <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
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


btw, what I missed, openvpn dies:

openvpn[11346]: segfault at 0 ip 000055e33503f5f3 sp 00007fff33642390 
error 4 in openvpn[55e334fc8000+8f000]

but only  multipoint udp .



10.11.2023 11:35, Dmitry Melekhov пишет:
> 10.11.2023 11:23, Gert Doering пишет:
>> Hi,
>>
>> On Fri, Nov 10, 2023 at 11:19:58AM +0400, Dmitry Melekhov wrote:
>>> OK, now I know what is broken.
>>>
>>> I have so called multihomed server,  and multihomed udp does not work in
>>> 2.6.7.
>>>
>>> On server with only one external interface everything works OK.
>> Are you using --multihome in your config?  If not, please add this - UDP
>> on a server with multiple IP addresses of the same family (v4 or v6) can
>> not work reliably without --multihome.
>
> yes, sure.
>
> as I said 2.6.6 works OK , and all previous versions since multihomed 
> support for udp was introduced.
>
>> If it does not work with --multihome, please send logs.
>
>
> I see nothing strange in logs, server just lost connection, client 
> too, then they reconnects.
>
>> (There is one multihome-related code change in 2.6.6 -> 2.6.7, but that
>> should only ever trigger if you use DCO)
>
>
> I don't use dco, but multihomed udp does not work.
>
>
>> gert
>>
>>
>


