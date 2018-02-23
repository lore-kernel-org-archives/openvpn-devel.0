References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
 <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <084aa45a-6ca8-33c8-2ba8-7839e3e59219@...1435...>
Date: Fri, 23 Feb 2018 13:02:43 +0100
MIME-Version: 1.0
In-Reply-To: <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in
 mbed 2.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

Thanks for reviewing!

On 23-02-18 10:17, Antonio Quartulli wrote:
> On 07/02/18 20:22, Steffan Karger wrote:
>> -        mbedtls_sha256(cert->tbs.p, cert->tbs.len, sha256_hash, false);
>> +        if (0 != md_full(sha256_kt, cert->tbs.p, cert->tbs.len, sha256_hash))
> 
> Why not using mbedtls_sha256_ret() since we are already in
> mbedtls-specific code here?
> Any advantage in using a wrapper for another wrapper? :-P
> 
> (mbedtls_sha256_ret() is also the suggested replacement for
> mbedtls_sha256())
> 
> 
> Moreover, SHA256 is statically selected, therefore using
> mbedtls_sha256_ret() would also avoid the md_kt_t local variable.

This was the only place in the code where we took a (direct) dependency
on functions from sha256.h.  By using our internal wrapper, I could also do:

@@ -60,7 +60,6 @@

 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
-#include <mbedtls/sha256.h>

Since reducing dependencies usually reduces maintenance burden, I prefer
this solution.

>> +        {
>> +            msg(M_WARN, "WARNING: failed to personalise random");
>> +        }
>> +
> 
> Since we now have a reason for the failure, may it make sense to print a
> proper description based on the return value? (even though I think
> mbedtls_sha256_ret() can't really return something different from 0)

md_full returns true/false, but you're right we can improve error
reporting.  Are you satisfied if I add an mbed_ok() wrapper *inside*
md_full() to print the internal mbed error?  I think that should be
sufficient information.

-Steffan

