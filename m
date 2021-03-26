References: <20210325174449.26948-1-arne@...1227...>
 <fa1a440d-c9a1-0269-d644-11c630ae4061@...2181...>
 <54cecb4a-5135-f073-39b1-7a143f8d1e30@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4445195b-3133-e79c-6715-d1f746025d2d@...2181...>
Date: Fri, 26 Mar 2021 14:30:35 +0100
MIME-Version: 1.0
In-Reply-To: <54cecb4a-5135-f073-39b1-7a143f8d1e30@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Always disable SSL renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 12:03, Arne Schwabe wrote:
> Am 26.03.21 um 00:15 schrieb Antonio Quartulli:
>> Hi,
>>
>> On 25/03/2021 18:44, Arne Schwabe wrote:
>>> These have been troublesome in the past and also today's CVE-2021-3449
>>> DOS is only exploitable if renegotiation is enabled.
>>>
>>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>
>> What is the practical effect of this change?
>> With the current code (before this patch) when would OpenSSL/mbedTLS
>> start a renegotiation on its own?
>>
> 
> 
> Documentation from OpenSSL:
> 
> SSL_OP_NO_RENEGOTIATION
> Disable all renegotiation in TLSv1.2 and earlier. Do not send
> HelloRequest messages, and ignore renegotiation requests via ClientHello.
> 
> From mbed TLS:
> 
> Enable / Disable renegotiation support for connection when initiated by
> peer (Default: MBEDTLS_SSL_RENEGOTIATION_DISABLED)
> 
> Warning
> It is recommended to always disable renegotation unless you know you
> need it and you know what you're doing. In the past, there have been
> several issues associated with renegotiation or a poor understanding of
> its properties.
> Note
> Server-side, enabling renegotiation also makes the server susceptible to
> a resource DoS by a malicious client.
> 
> 
> So for mbed TLS it was off by default anyway, this patch just doesn't
> trust the default for mbed TLS. Renegotiation is also dropped from TLS
> 1.3. Furthermore in TLS 1.2 you would use it to restart a session with
> diffferent parameter (now with client certs). So the is no real use case
> in OpenVPN to have it enabled.
> 

Thanks a lot! This was definitely eye-opening, especially for somebody
that does not eat oat and SSL for breakfast :-)

It'd be nice though to have a little summary of this in the commit
message (no need to copy/paste verbatim text from openssl/mbedtls though).

I have a couple minor comments for the patch...incoming soon!


Cheers,



-- 
Antonio Quartulli

