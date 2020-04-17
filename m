References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
Date: Fri, 17 Apr 2020 15:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200417085159.GC1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net



On 17/04/2020 10:51, Gert Doering wrote:
> Hi,
> 
> On Thu, Apr 16, 2020 at 01:39:28PM +0200, Arne Schwabe wrote:
>> index 18a86ceb..dadf0a90 100644
>> --- a/src/openvpn/crypto.h
>> +++ b/src/openvpn/crypto.h
>> @@ -528,21 +528,7 @@ void crypto_read_openvpn_key(const struct key_type *key_type,
>>   * As memcmp(), but constant-time.
>>   * Returns 0 when data is equal, non-zero otherwise.
>>   */
>> -static inline int
>> -memcmp_constant_time(const void *a, const void *b, size_t size)
>> -{
> 
> Not sure I understand the motivation for this change.  "Just so uncrustify
> stops trying to change this" is not really strong.

well, sometimes to adhere to the codestyle, you have to re-arrange code :)

On top of that, this is basically allowing us to re-use an existing
openssl API when possible.

> 
> Also, keeping the "inline" part would be good...  this is in the per-packet
> path.

I am not sure it would work in this case, because the function is
defined in a .c file now - it's not inlineable anymore outside of the
mbedtls code.....

Regards,

-- 
Antonio Quartulli

