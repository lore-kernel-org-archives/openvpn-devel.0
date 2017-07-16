References: <20170716082207.23646-1-coroner@...2290...>
	<53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
	<71634ec3-3179-a976-afb5-e41e1e076a55@...2290...>
	<18d68a41-9903-4118-182f-355e52f27149@...2181...>
	<bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
From: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>
Message-ID: <3d4b17dc-95c8-8398-ce08-99d3a1aa0f2a@...2290...>
Date: Sun, 16 Jul 2017 13:45:14 +0200
MIME-Version: 1.0
In-Reply-To: <bda8bfa8-701a-99a1-4d02-676918cf1fe2@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 2017-07-16 11:26, Antonio Quartulli wrote:
>
> On 16/07/17 17:24, Antonio Quartulli wrote:
>> (re-adding the ml: please keep it in the CC list)
>>
>> On 16/07/17 17:16, Szil=C3=A1rd Pfeiffer wrote:
>>> On 2017-07-16 10:47, Antonio Quartulli wrote:
>>>> Hi Szil=C3=A1rd,
>>>>
>>>>
>>>> On 16/07/17 16:22, Szil=C3=A1rd Pfeiffer wrote:
>>>>> ---
>>>>>  doc/openvpn.8             |  4 ++++
>>>>>  src/openvpn/options.c     | 17 +++++++++++++++++
>>>>>  src/openvpn/ssl_common.h  |  7 ++++---
>>>>>  src/openvpn/ssl_openssl.c |  6 ++++++
>>>>>  4 files changed, 31 insertions(+), 3 deletions(-)
>>>>>
>>>> how about adding some text in the commit message explaining what the
>>>> patch is doing and *why* it would be helpful? casual reader not into T=
LS
>>>> (like me) may miss the benefit of this changes.
>>> The option does what ssl_prefer_server_ciphers options does in NGINX, t=
he SSLHonorCipherOrder option does in Apache, ...
>>>
>>> http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_prefer_serve=
r_ciphers
>>> https://httpd.apache.org/docs/current/mod/mod_ssl.html#sslhonorcipheror=
der
>>>
>>> The reason explained for example in the following blog post.
>>>
>>> https://tribut.de/blog/secure-your-services-using-sane-cipher-ordering/=
#what-cipher-ordering-is-all-about
>> why not putting some of this information in the commit message as well?
>>
>>>> And why making it a compile time option?
>>> What do you mean? It can be set from command line.
>>>
>> all your code is surrounded by "#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE",
>> hence I imagined you wanted your code to be included based on a compile
>> time option. However, I don't see where SSL_OP_CIPHER_SERVER_PREFERENCE
>> should be defined? Am I missing something or it was forgotten?
>>
> Sorry, but I realized just now that this is an OpenSSL specific
> mechanism and that the define is coming from OpenSSL itself.
You are right. No problem.
>
> This is not my field, so I'll leave the review to somebody else, but
> still, this should be explained in the commit message,
>
OK. I will write it to the commit message.

