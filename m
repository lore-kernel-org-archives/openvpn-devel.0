Message-ID: <5b1afbc9-e148-7c71-afd9-242ead044573@...1227...>
Date: Tue, 14 Feb 2023 12:26:09 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230210133159.1336-1-lstipakov@...277...>
 <a080d07f-c772-4dc4-de40-1807d2f74a6a@...2181...>
 <CAKuzo_hkFXh=m3VYvxKCzGePzMau92Af8cBmUy23vd8XcrBpmQ@...278...>
 <9bcf4906-6212-a298-1c14-f2c215fb6492@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <9bcf4906-6212-a298-1c14-f2c215fb6492@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Improve format specifier for socket
 handle in Windows
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
To: Antonio Quartulli <a@...2181...>, Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Am 10.02.23 um 23:07 schrieb Antonio Quartulli:
> Hi,
> 
> On 10/02/2023 20:54, Selva Nair wrote:
>>
>>     I also discussed this with Lev and, despite this being different from
>>     what we do in the *nix world (where decimal representations make 
>> sense
>>     for file descriptors), it seems to be the right hting to do on 
>> Windows
>>     when using HANDLEs (shrug).
>>
>>
>> Windows kernel handles are very much "like" fds though the handle 
>> table also covers processes, threads,  semaphores etc. They are not 
>> pointers, are generally smallish numbers or ~0 (== -1). But not as 
>> small as fds in the Unix/Linux world --- mainly because several 
>> objects share the name space and they have to be multiples of 4 for 
>> some arcane reason.
>>
>> The problem here was not printing as "decimal" but as "unsigned 
>> decimal". Use of the latter would have caused the same issue on Linux 
>> too.
>>
>> Using hex is a compromise here as handles are defined as "unsigned 
>> ints" of the same size as pointers. So PRIdPTR somehow looks improper 
>> though I would have chosen that.
> 
> Given your explanation then it sounds like we should truly use PRIdPTR.
> Wouldn't you agree Lev?

Not really. The type is still an unsigned type and while -1 is used to 
denote an invalid HANDLE, the type itself is unsigned, so using a signed 
printf format specifier like PRIdPTR will probably give us a warning 
about using about signed vs unsigned.

Arne


