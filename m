Message-ID: <4F4CAEF1.9070001@...1114...>
Date: Tue, 28 Feb 2012 11:39:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...>
In-Reply-To: <4F4C6C14.9030303@...1550...>
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
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 06:54, Igor Novgorodov wrote:
> Then maybe we should move these calls to crypto_openssl.c into 
> crypto_init_lib() function to make crypto.c library-independent? And 
> why OpenSSL_add_all_algorithms() and stuff is called only when
> USE_SSL is not defined?
> 
> And if these calls are for 0.9.8, maybe add a check for OpenSSL 
> version?

Remember that OpenSSL covers two parts.  One part is the SSL stuff, the
other part is the crypto layer.  So even if the SSL stuff isn't used, the
crypto stuff most likely is.  In the crypto stuff, also all the hashing
algorithms are included.  However, using SSL without crypto doesn't make
sense.  If it's not needed any more by OpenSSL 1.0.0, then make it
version dependent.  Can probably be done at compile time.

Removing the ERR_load_crypto_strings() call will most likely break the
error logging too, which is used by the msg() function.  It will not make
the crypto/SSL errors more understandable, how I understand it.

May I suggest that both ERR_load_crypto_strings() and
SSL_load_error_strings() (gotta love the consistency of function naming)
is loaded by default, unless ENABLE_SMALL is defined?

Right now, this patch makes me really concerned and scared.  For this to
be accepted, a lot of testing must be done - and most likely by people
understanding the darker sides of crypto far better than I.  We can't
risk that we're regressing on a well proved and tested encryption layer.
 There are people located in not so democratic countries who use OpenVPN
to access a not-restricted/censored Internet - and their safety may rely
on the security OpenVPN provides.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9MrvEACgkQDC186MBRfroaSgCdGkPFPLK7D9XKiJa30lkfWmaV
BJkAnAyAg+GbYmA3OrQ3HmNL+4AQTisq
=kilG
-----END PGP SIGNATURE-----

