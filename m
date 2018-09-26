From: Arne Schwabe <arne@...1227...>
References: <20180925124819.4005-1-arne@...1227...>
 <f5264ad9-f28c-cd7a-2b79-6a5536d0130e@...2080...>
 <75f44ec4-eb46-0bc4-a7ad-f1b87fd2b9b8@...1227...>
 <248d75ef-2c76-1c84-25b3-8748b0afc35f@...2181...>
Message-ID: <e895e232-eadc-ef25-132f-fbaf3ffff1ab@...1227...>
Date: Wed, 26 Sep 2018 13:56:41 +0200
MIME-Version: 1.0
In-Reply-To: <248d75ef-2c76-1c84-25b3-8748b0afc35f@...2181...>
Content-Language: de-DE
Subject: [Openvpn-devel] [PATCH] Add message explaining early TLS client
 hello failure
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
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 26.09.18 um 08:52 schrieb Antonio Quartulli:
> Hi,
> 
> On 26/09/18 06:19, Arne Schwabe wrote:
>> Am 25.09.18 um 16:31 schrieb David Sommerseth:
>>> On 25/09/18 14:48, Arne Schwabe wrote:
>>>> In my tests an OpenSSL 1.1.1 server does not accept TLS 1.0 only clients
>>>> anymore. Unfortunately, Debian 8 still has OpenVPN 2.3.4, which is
>>>> TLS 1.0 only without setting tls-version-min.
>>>>
>>>> We currently log only
>>>> OpenSSL: error:14209102:SSL routines:tls_early_post_process_client_hello:unsupported protocol
>>>> which indicates the right technical error but is not very helpful to a
>>>> person without deep knowledge in SSL/TLS and OpenVPN's TLS version
>>>> history.
>>>>
>>>> This commit adds a hopefully helpful message and also tells users how
>>>> to fix the old Debian 8 clients.
>>>> ---
>>>>  src/openvpn/crypto_openssl.c | 10 +++++++++-
>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>>>> index 9ec2048d..3360bb19 100644
>>>> --- a/src/openvpn/crypto_openssl.c
>>>> +++ b/src/openvpn/crypto_openssl.c
>>>> @@ -199,7 +199,15 @@ crypto_print_openssl_errors(const unsigned int flags)
>>>>                  "in common with the client. Your --tls-cipher setting might be "
>>>>                  "too restrictive.");
>>>>          }
>>>> -
>>>> +        else if (ERR_GET_REASON(err) == SSL_R_UNSUPPORTED_PROTOCOL)
>>>> +        {
>>>> +            msg(D_CRYPT_ERRORS, "TLS error: Unsupported protocol. This typically "
>>>> +                 "indicates that client and server have no common TLS version enabled. "
>>>> +                 "This can be caused by mismatched tls-version-min and tls-version-max options "
>>>> +                 "on client and server. "
>>>> +                 "If your client is 2.3.6 or older  consider adding tls-version 1.1"
>>>> +                 "to the the configuration to use TLS 1.1+ instead of TLS 1.0 only");
>>>
>>>
>>> Good advice in the log.  But should this be added in the local or remote
>>> configuration?  It is the 2.3.6 reference which makes it confusing for me,
>>> otherwise I would have interpreted this as the local side where this warning
>>> occurs.  So this could be clearer.
>>
>> 2.3.7 is the first version of OpenVPN which enables TLS 1.0+ instead TLS
>> 1.0 only by default. See this commit by Steffan:
>>
>> https://github.com/OpenVPN/openvpn/commit/8dc6ed28941cb9b9167e0b466e96b5f11359eb59
>>
> 
> I think the problem is: we apply this patch to the latest 2.3.x release,
> so it will never appear on "2.3.6 or older" clients.
> Hence, does it really make sense to print that particular sentence?

This appears in the server log when a 2.3.6 client or older tries to
connect to a server that has OpenSSL 1.1.1.

I am not sure that OpenVPN 2.3.x has OpenSSL 1.1 support.

Arne



