Message-ID: <9ab3a55c-062a-d849-0434-0df90bea4224@...1227...>
Date: Sun, 7 Nov 2021 13:13:06 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211107090138.3150187-1-arne@...1227...>
 <5fa04cf3-c7b7-7e26-db95-ee734b0001ea@...68...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <5fa04cf3-c7b7-7e26-db95-ee734b0001ea@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Completely remove DES checks
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
To: Matthias Andree <matthias.andree@...68...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 07.11.21 um 12:57 schrieb Matthias Andree:
> Am 07.11.21 um 10:01 schrieb Arne Schwabe:
>> We already removed the check in d67658fee for OpenSSL 3.0. This 
>> removes the
>> checks entirely for all crypto libraries.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   src/openvpn/crypto.c         | 15 --------
>>   src/openvpn/crypto_backend.h | 28 ---------------
>>   src/openvpn/crypto_mbedtls.c | 56 ------------------------------
>>   src/openvpn/crypto_openssl.c | 66 ------------------------------------
>>   4 files changed, 165 deletions(-)
>> -    /* DES is deprecated and the method to even check the keys is 
>> deprecated
>> -     * in OpenSSL 3.0. Instead of checking for the 16 weak/semi-weak 
>> keys
>> -     * we just accept them in OpenSSL 3.0 since the risk of randomly 
>> getting
>> -     * these is pretty low (and "all DES keys are weak" anyway) */
>> -    return true;
> 
> Should not we nuke DES altogether in that case? Or am I misunderstanding
> the patch?


The patch removes checking for weak keys and making DES just like any 
other CBC cipher and not doing extra checks for this. It basically 
removes the special treatment of DES.

Arne


