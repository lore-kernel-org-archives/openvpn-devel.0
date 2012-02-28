Message-ID: <4F4CBF04.404@...1114...>
Date: Tue, 28 Feb 2012 12:48:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...> <4F4CAEF1.9070001@...1114...>
	<4F4CB771.5060004@...1550...> <4F4CBBCF.8050409@...1114...>
	<4F4CBD28.9060001@...1550...>
In-Reply-To: <4F4CBD28.9060001@...1550...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Igor Novgorodov <igor@...1550...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 12:40, Igor Novgorodov wrote:
> On 28.02.2012 15:34, David Sommerseth wrote:
>> On 28/02/12 12:16, Igor Novgorodov wrote:
>>> On 28.02.2012 14:39, David Sommerseth wrote:
>>>> On 28/02/12 06:54, Igor Novgorodov wrote:
[...snip...]
>>>> Right now, this patch makes me really concerned and scared.
>>>> For this to be accepted, a lot of testing must be done - and
>>>> most likely by people understanding the darker sides of crypto
>>>> far better than I.  We can't risk that we're regressing on a
>>>> well proved and tested encryption layer. There are people
>>>> located in not so democratic countries who use OpenVPN to access
>>>> a not-restricted/censored Internet - and their safety may rely
>>>> on the security OpenVPN provides.
>>> I agree fully. So if we just move these calls into
>>> crypto_openssl.c, no regression would occur i think.
>> Agreed, I think it makes sense to move all native OpenSSL calls
>> into *_openssl.[ch] files.
>> 
>> I'm still not convinced about this part though.
>> 
>> +#ifndef USE_SSL +#ifndef ENABLE_SMALL +  ERR_load_crypto_strings
>> (); +#endif +  OpenSSL_add_all_algorithms (); +#endif
>> 
>> OpenSSL_add_algorithms() is also needed for *non-SSL* stuff.  It is 
>> populates the internal OpenSSL lookup tables, so you can lookup
>> strings like "MD5", "SHA512", "AES256", etc,  etc via
>> EVP_get_digestbyname() and EVP_get_cipherbyname() which will return
>> the proper EVP_* objects back. And neither of these are strictly
>> SSL, they are all crypto related.  SSL depends on the crypto part,
>> but the crypto doesn't need SSL.
> Well, it's the #ifNdef directive used, so when building *without* SSL 
> support, the OpenSSL_add_all_algorithms() will be called here, in
> crypto_openssl.c

Duh!  Sorry!!!  I didn't see the 'n' in the #ifndef.  Thanks for
highlighting that.  It all makes sense now.

> And when building with SSL support, it won't be called here, but in 
> ssl_openssl.c in tls_init_lib() instead.

Indeed.  This looks good.  So unless Adriaan see some other concerns.

Again, sorry about the noise!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Mvv8ACgkQDC186MBRfrq/fgCeJRL5uESQF8aK+qaGxb0rRyw9
V0cAn0k3HXnDa5X8hxfgRNDuwAjsXggY
=SqO3
-----END PGP SIGNATURE-----

