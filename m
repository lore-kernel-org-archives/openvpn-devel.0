MIME-Version: 1.0
In-Reply-To: <bb21c180-2618-6d83-e7e1-dbc8479e8d6e@...1856...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
 <1515378076-5774-2-git-send-email-selva.nair@...277...>
 <bb21c180-2618-6d83-e7e1-dbc8479e8d6e@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 14 Jan 2018 11:31:41 -0500
Message-ID: <CAKuzo_hkT_pRGO1GOUm_6pVS9DC0V-OxUS1zMTYCiKHG6afiNQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Bring cryptoapi.c upto speed with
 openssl 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Jan 14, 2018 at 6:28 AM, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 08-01-18 03:21, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - Replace direct access to internals of openssl structs
>>   by corresponding methods.
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>> ---
>> Tested on Windows 10 with openssl 1.0.1r and 1.1.0g
>>
>>  configure.ac                 |  1 +
>>  src/openvpn/cryptoapi.c      | 69 +++++++++++++++++++++++++++-----------------
>>  src/openvpn/openssl_compat.h | 14 +++++++++
>>  3 files changed, 57 insertions(+), 27 deletions(-)
>>
>>
..

>> -    rsa->n = BN_dup(pub_rsa->n);
>> -    rsa->flags |= RSA_FLAG_EXT_PKEY;
>> +    if (EVP_PKEY_id(pkey) != EVP_PKEY_RSA)
>> +    {
>> +        msg(M_WARN, "cryptoapicert requires an RSA certificate");
>> +        goto err;
>> +    }
>> +    pub_rsa = EVP_PKEY_get0_RSA(pkey);
>
> This conflicts with the patch set from Emmanuel, where he removes
> EVP_PKEY_id().  Canbe easily resolved by changing the if to
>
>    if (!(pub_rsa = EVP_PKEY_get0_RSA))
>
> ... but only once the NULL-check patch for openssl_compat.h is applied.

I'll send a v2 assuming that patch will get merged eventually.

I would have preferred to have  EVP_PKEY_id() retained in the compat layer
as its much more convenient to use it when multiple key types are to be
differentiated.. (read as: I want to support EC certs here).

Thanks for the review.

Selva

