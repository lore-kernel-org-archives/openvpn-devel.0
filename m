Message-ID: <4F74591C.40100@...1114...>
Date: Thu, 29 Mar 2012 14:44:12 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...> <4F4CAEF1.9070001@...1114...>
	<4F4CB771.5060004@...1550...>
In-Reply-To: <4F4CB771.5060004@...1550...>
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

On 28/02/12 12:16, Igor Novgorodov wrote:
>> On 28/02/12 06:54, Igor Novgorodov wrote:
>>> Then maybe we should move these calls to crypto_openssl.c into 
>>> crypto_init_lib() function to make crypto.c
>>> library-independent? And why OpenSSL_add_all_algorithms() and
>>> stuff is called only when USE_SSL is not defined?
>>> 
>>> And if these calls are for 0.9.8, maybe add a check for
>>> OpenSSL version?
>> Remember that OpenSSL covers two parts.  One part is the SSL
>> stuff, the other part is the crypto layer.  So even if the SSL
>> stuff isn't used, the crypto stuff most likely is.  In the crypto
>> stuff, also all the hashing algorithms are included.  However,
>> using SSL without crypto doesn't make sense.  If it's not needed
>> any more by OpenSSL 1.0.0, then make it version dependent.  Can
>> probably be done at compile time.
> Well, i'm no expert in OpenSSL programming, but looking through 
> internet, i haven't found an evidence that this stuff should not be
> called during initialization in OpenSSL 1.0.x
> 
> So, just to make OpenVPN possible to build with --ssl-type=polarssl
> and --disable-ssl, i propose the attached patch that moves calls to
> these functions into crypto_openssl.c
> 
>> Removing the ERR_load_crypto_strings() call will most likely
>> break the error logging too, which is used by the msg() function.
>> It will not make the crypto/SSL errors more understandable, how I
>> understand it.
>> 
>> May I suggest that both ERR_load_crypto_strings() and 
>> SSL_load_error_strings() (gotta love the consistency of function
>> naming) is loaded by default, unless ENABLE_SMALL is defined?
> I agree, added the check for ENABLE_SMALL in ssl_openssl.c and 
> crypto_openssl.c to the attached patch.
> 
>> Right now, this patch makes me really concerned and scared.  For
>> this to be accepted, a lot of testing must be done - and most
>> likely by people understanding the darker sides of crypto far
>> better than I.  We can't risk that we're regressing on a well
>> proved and tested encryption layer. There are people located in
>> not so democratic countries who use OpenVPN to access a
>> not-restricted/censored Internet - and their safety may rely on
>> the security OpenVPN provides.
> 
> I agree fully. So if we just move these calls into
> crypto_openssl.c, no regression would occur i think.

Your patch has now been applied to the master branches on the -stable
and -testing git trees.

commit 39b54baa36e8625fd29d0a1ed6482f83fa78d322
Author: Igor Novgorodov <igor@...1550...>
Date:   Tue Feb 28 15:16:01 2012 +0400

    Remove calls to OpenSSL when building with --disable-ssl

    Move OpenSSL calls out from the generic crypto layer and into the
    OpenSSL specific layer.  Also don't load all algortihms if SSL
    isn't enabled.

    Error strings will also not be loaded into memory if ENABLE_SMALL
    is configured.

    Signed-off-by: Igor Novgorodov <igor@...1550...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


Thank you very much for you contribution!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk90WRoACgkQDC186MBRfrqcawCeOudeBqhCzBH7PPXcE3J6otAJ
dTQAnjccy239NSzTJodNHrCFtNnH25/E
=CtJw
-----END PGP SIGNATURE-----

