Message-ID: <cd225944-6a29-4ad1-a2e3-e8e17ce98394@...68...>
Date: Thu, 26 Dec 2024 23:06:47 +0100
MIME-Version: 1.0
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
 <86c60a4f-685e-4157-ad10-6de03bb2eef0@...68...>
 <Z21WewOcAbuPu71M@...1296...>
Content-Language: de-CH
From: corubba <corubba@...68...>
In-Reply-To: <Z21WewOcAbuPu71M@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] port-share: Add proxy protocol
 v2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 26.12.24 14:13, Gert Doering wrote:
> On Mon, Dec 16, 2024 at 01:22:51PM +0100, corubba via Openvpn-devel wrote:
>> In addition to the custom journal solution, also support the widely
>> used binary PROXY protocol version 2 to convey the original client
>> connection parameters to the proxy receiver. This makes the port-share
>> journal feature more accessable and easier to use, because one doesn't
>> need a custom integration.
>>
>> While this is a spec-compliant sender implementation of the PROXY
>> protocol, it does not implement it in full. Version 1 was left out
>> entirely, in favour of the superior and easier-to-implement version 2.
>> The implementation was also kept minimal with regards to what OpenVPN
>> supports/requires: Local commands, unix sockets, UDP and TLVs are not
>> implemented.
>
> Are there any reference URLs for the PROXY protocol?  If yes, I think it
> would be good to include a reference into one of the comments - the next
> person to read that code would then know which document this is based on.

I had included the link to the spec I used only in the cover letter, but
I agree putting it into the commit message is more sensible.

> Besides this, I'm not sure what to do with these
>
>> +            ASSERT(4 >=3D sizeof(src.addr.in4.sin_addr));
>> +            ASSERT(4 >=3D sizeof(dst.addr.in4.sin_addr));
>> +            memcpy(&header[16], &src.addr.in4.sin_addr, sizeof(src.addr=
.in4.sin_addr));
>> +            memcpy(&header[20], &dst.addr.in4.sin_addr, sizeof(dst.addr=
.in4.sin_addr));
>
> ... this is all obviously correct, but it feels heavy handed, and many
> lines of code...  (especially 2x sizeof on the same structure element)
>
> I think we can fairly safely assume that an in4.sin_addr will always be
> 4 bytes, an in4.sin_port will always be 2 bytes, and an IPv6 address will
> always be 16 bytes...  so I wonder if it wouln't be easier to just copy
> a well-known number of bytes (openvpn_sockaddr is also "always bigger
> than that", so no read overrun) here.
>
> I know that "magic numbers" in code are considered a bad pattern, but
> these things are really constant length, and the buffer layout *requires*
> "exactly 4" and "exactly 2" bytes...

I wasn't sure about that either, and in the end opted for the "better
safe than sorry" variant. If your better-informed opinion too is that
these are "practically constant", then I am happy to oblige.


Best regards
--
Corubba



