Message-ID: <4F4CBD28.9060001@...1550...>
Date: Tue, 28 Feb 2012 15:40:24 +0400
From: Igor Novgorodov <igor@...1550...>
MIME-Version: 1.0
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...> <4F4CAEF1.9070001@...1114...>
	<4F4CB771.5060004@...1550...> <4F4CBBCF.8050409@...1114...>
In-Reply-To: <4F4CBBCF.8050409@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 02/02] Remove calls to OpenSSL when
 building with --disable-ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>, openvpn-devel@lists.sourceforge.net

On 28.02.2012 15:34, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 28/02/12 12:16, Igor Novgorodov wrote:
>> On 28.02.2012 14:39, David Sommerseth wrote:
>>> On 28/02/12 06:54, Igor Novgorodov wrote:
>>>> Then maybe we should move these calls to crypto_openssl.c into
>>>> crypto_init_lib() function to make crypto.c library-independent?
>>>> And why OpenSSL_add_all_algorithms() and stuff is called only
>>>> when USE_SSL is not defined?
>>>>
>>>> And if these calls are for 0.9.8, maybe add a check for OpenSSL
>>>> version?
>>> Remember that OpenSSL covers two parts.  One part is the SSL stuff,
>>> the other part is the crypto layer.  So even if the SSL stuff isn't
>>> used, the crypto stuff most likely is.  In the crypto stuff, also
>>> all the hashing algorithms are included.  However, using SSL without
>>> crypto doesn't make sense.  If it's not needed any more by OpenSSL
>>> 1.0.0, then make it version dependent.  Can probably be done at
>>> compile time.
>> Well, i'm no expert in OpenSSL programming, but looking through
>> internet, i haven't found an evidence that this stuff should not be
>> called during initialization in OpenSSL 1.0.x
>>
>> So, just to make OpenVPN possible to build with --ssl-type=polarssl
>> and --disable-ssl, i propose the attached patch that moves calls to
>> these functions into crypto_openssl.c
>>
>>> Removing the ERR_load_crypto_strings() call will most likely break
>>> the error logging too, which is used by the msg() function.  It will
>>> not make the crypto/SSL errors more understandable, how I understand
>>> it.
>>>
>>> May I suggest that both ERR_load_crypto_strings() and
>>> SSL_load_error_strings() (gotta love the consistency of function
>>> naming) is loaded by default, unless ENABLE_SMALL is defined?
>> I agree, added the check for ENABLE_SMALL in ssl_openssl.c and
>> crypto_openssl.c to the attached patch.
>>
>>> Right now, this patch makes me really concerned and scared.  For
>>> this to be accepted, a lot of testing must be done - and most likely
>>> by people understanding the darker sides of crypto far better than
>>> I.  We can't risk that we're regressing on a well proved and tested
>>> encryption layer. There are people located in not so democratic
>>> countries who use OpenVPN to access a not-restricted/censored
>>> Internet - and their safety may rely on the security OpenVPN
>>> provides.
>> I agree fully. So if we just move these calls into crypto_openssl.c,
>> no regression would occur i think.
> Agreed, I think it makes sense to move all native OpenSSL calls into
> *_openssl.[ch] files.
>
> I'm still not convinced about this part though.
>
> +#ifndef USE_SSL
> +#ifndef ENABLE_SMALL
> +  ERR_load_crypto_strings ();
> +#endif
> +  OpenSSL_add_all_algorithms ();
> +#endif
>
> OpenSSL_add_algorithms() is also needed for *non-SSL* stuff.  It is
> populates the internal OpenSSL lookup tables, so you can lookup strings
> like "MD5", "SHA512", "AES256", etc,  etc via EVP_get_digestbyname() and
> EVP_get_cipherbyname() which will return the proper EVP_* objects back.
>   And neither of these are strictly SSL, they are all crypto related.  SSL
> depends on the crypto part, but the crypto doesn't need SSL.
Well, it's the #ifNdef directive used, so when building *without* SSL 
support, the
OpenSSL_add_all_algorithms() will be called here, in crypto_openssl.c

And when building with SSL support, it won't be called here, but in 
ssl_openssl.c in tls_init_lib() instead.

Looks fine to me.

> Adriaan, what do you think?
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9Mu80ACgkQDC186MBRfrpj2QCfYPpJa8CbFNZwJvGbyAHIpLBI
> dgwAn2P2QD6YKq2qU9N6MaKhTl2OX94M
> =ticZ
> -----END PGP SIGNATURE-----


