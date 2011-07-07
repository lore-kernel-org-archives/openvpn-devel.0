Message-ID: <4E1561B0.9080802@...1114...>
Date: Thu, 07 Jul 2011 09:35:12 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>	<4E14B584.9040905@...515...>
	<1309993689.2862.60.camel@...1471...>
In-Reply-To: <1309993689.2862.60.camel@...1471...>
Subject: Re: [Openvpn-devel] PolarSSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: chantra <chantra@...1258...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/07/11 01:08, chantra wrote:
> Samuli,
> 
> You will need patch openvpn-plugin.h
> 
> diff --git a/openvpn-plugin.h b/openvpn-plugin.h
> index 9cce9d8..529a1c6 100644
> --- a/openvpn-plugin.h
> +++ b/openvpn-plugin.h
> @@ -25,12 +25,8 @@
> #ifndef OPENVPN_PLUGIN_H_
> #define OPENVPN_PLUGIN_H_
> 
> -#ifdef USE_OPENSSL
> -#include "ssl_verify_openssl.h"
> -#endif
> -#ifdef USE_POLARSSL
> -#include "ssl_verify_polarssl.h"
> -#endif
> +struct x509_cert;
> +typedef struct x509_cert x509_cert_t;
> 
> That will get the plugin to compile, but will break when using openssl.

This is the wrong approach, as this will break the SSL modularity begin
implemented.

> I believe the plugins should not need to know if openvpn uses polarssl or
> openssl... that might meant that openvpn will need to provide a generic
> x509 cert library to be used by openvpn plugins.

For now, I say the plug-ins will need to be SSL implementation aware.  This
is especially important for the plugin-v3 API.  This API provides a parsed
X509 struct to the plug-ins with the certificate information.  So this API
needs to be adopted to support both PolarSSL and OpenSSL, and plug-ins need
to use the appropriate SSL library which OpenVPN uses.

To provide a generic X509 cert library sounds good, but I believe the
efforts of providing such a layer will be far more costly (in time) than to
have SSL implementation aware plug-ins.  And it might give far more
challenges in regards to supported features.

So for now, I recommend plug-ins to support OpenSSL and/or PolarSSL
natively.  If someone can come up with a sensible X509 API layer which can
be used instead, lets review that if someone provides it.


kind regards,

David Sommerseth


> On Wed, 2011-07-06 at 12:20 -0700, Samuli Seppänen wrote:
>> Hi Adriaan,
>>
>> I tried building your tree on Debian 5 (amd64) VM and got this error:
>>
>> #make plugins
>> /usr/bin/make -C plugin/auth-pam/
>> make[1]: Entering directory
>> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
>> gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -c -I../.. auth-pam.c
>> In file included from auth-pam.c:49:
>> ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
>> before ‘x509_cert_t’
>> make[1]: *** [auth-pam.o] Error 1
>> make[1]: Leaving directory
>> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
>> make: *** [build-stamp] Error 2
>>
>> The same VM has been used to successfully build the official release
>> packages.
>>
>> Samuli
>>
>>
[...snip...]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4VYa0ACgkQDC186MBRfroUDACfXevwkwEQAlFxI/3jIffz2Hbo
kJYAniv9+oLrqafN1zq/1oUG59rbIgPX
=QthI
-----END PGP SIGNATURE-----

