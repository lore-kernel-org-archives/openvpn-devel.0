Message-ID: <cbde8749-f884-234b-18f9-6c86cbc065ac@...1227...>
Date: Fri, 29 Sep 2023 13:44:46 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <f80646d4-0fc3-4e5a-bc05-22b929452d00@...1800...>
 <CAKuzo_hqwfqgSb57fwCEx6C+HBVawt-ECZuNkacVBb4y-CYwcw@...278...>
 <850037b2-36d0-4240-8c73-04dab1a90777@...1800...>
 <68a68aa4-0c57-655c-e0c9-ff9f1e0bf040@...1227...>
 <CAKuzo_iUEcp0Au0vHTfr4fwozDccxgRXCmV+C2eWc=W4ciTxog@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_iUEcp0Au0vHTfr4fwozDccxgRXCmV+C2eWc=W4ciTxog@...278...>
Subject: Re: [Openvpn-devel] pkcs11 config changes from 2.5.4 to 2.6.6 ?
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
To: Selva Nair <selva.nair@...277...>
Cc: mike tancsa <mike@...1800...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 29.09.23 um 03:25 schrieb Selva Nair:
> 
> 
> On Thu, Sep 28, 2023 at 8:55 PM Arne Schwabe <arne@...1227... 
> <mailto:arne@...1227...>> wrote:
> 
> 
>     Am 29.09.2023 um 01:08 schrieb mike tancsa:
>>
>>     Hi Selva,
>>
>>         Thank you for looking!
>>
>>
>>>     My guess is that something in the certificate or private key is
>>>     not to
>>>     OpenSSL 3.1's liking and it rejects it. Is there any way for you
>>>     to check the
>>>     contents of the token independently using a tool linked against
>>>     OpenSSL 3.1 ?
>>>
>>     What am I looking for in that case ?  Taking a look at the cert
>>     just with openssl 3.0 on FreeBSD releng14 it seems ok with it.
>>     Same with the Windows version 3.1.x that comes with OpenVPN. Is it
>>     possible it doesnt like the sha1RSA sig ?
>>
>>
>     OpenSSL 3.0 has security 1 by default (OpenSSL 3.1 has 2 by
>     default)  and that does not allow SHA1 signatures anymore. See
>     https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html <https://www.openssl.org/docs/man3.1/man3/SSL_CTX_set_security_level.html>
> 
> 
> Good point. But, unless the config has "tls-cert-profile foo", we still 
> default to legacy and call SSL_CTX_set_security_level(ctx, 1), isn't it? 
> Wouldn't that allow SHA1 with 3.1.x ?

For SHA1 you need security 0 aka tls-cert-profile insecure.

But we might update OpenVPN to longer fiddle with the default security 
level in OpenSSL 3+ to avoid downgrading security from 2 to 1 on OpenSSL 3.1

Arne

