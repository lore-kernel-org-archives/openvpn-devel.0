Message-ID: <91536f9a-deec-9d51-a7fd-a1a15023288f@...2080...>
Date: Wed, 19 Jan 2022 15:58:30 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220119113446.17691-1-openvpn@...2080...>
 <3ac19684-2989-8fd1-fea0-b92bf1a1774e@...2181...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <3ac19684-2989-8fd1-fea0-b92bf1a1774e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Fix OPENSSL_FIPS enabled builds
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On 19/01/2022 14:44, Antonio Quartulli wrote:
> Hi David,
> 
> On 19/01/2022 12:34, David Sommerseth wrote:
>> From: David Sommerseth <davids@...515...>
>>
>> On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS
>> module enabled by default.  This revealed some incompatible code with
>> the added DCO support.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>   src/openvpn/crypto.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 5626e2b6..0415f59d 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -34,6 +34,7 @@
>>   #include "error.h"
>>   #include "integer.h"
>>   #include "platform.h"
>> +#include "openssl_compat.h"
>>   #include "memdbg.h"
>> @@ -1704,6 +1705,8 @@ print_cipher(const char *ciphername)
>>           printf(", TLS client/server mode only");
>>       }
>>   #ifdef OPENSSL_FIPS
>> +    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
>> +
> 
> from the commit message it is clear that there are incompatibilities, 
> but I am unable to guess what the real problem is.
> 
> Maybe you could extend your commit message or add a comment here?

Will do!

> How is declaring a non-used variable going to help > Oh, now I see that cipher is used but was never declared/initialized.
> Still worth a word in the commit message? ;-)

Yes!

> On top of that, anything returned by EVP_get_cipherbyname() must be 
> free'd later, or it will result in a memory leak.

Will fix!

> On top of that ²: should we add some FIPS build to our GH Actions (for 
> another patch of course)?

This exploded on stock Fedora 35 inside a mock build chroot, no FIPS 
enabling required.  The devil in the detail is that the OPENSSL_FIPS 
macro is defined unconditionally in 
/usr/include/openssl/opensslconf-x86_64.h.  So our OPENSSL_FIPS blocks 
are always built on Fedora and related downstream distros.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


