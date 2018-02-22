MIME-Version: 1.0
In-Reply-To: <c42f92c8-6f07-2f3d-4f3f-9ee2f9313a24@...1856...>
References: <93167c2a-c7a2-de57-f793-7fdc2004bfb2@...1435...>
 <1516981990-4610-1-git-send-email-selva.nair@...277...>
 <c42f92c8-6f07-2f3d-4f3f-9ee2f9313a24@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Feb 2018 17:33:51 -0500
Message-ID: <CAKuzo_hA_0Wk4buH9yGzcbROeiW6Y3Nx3daeinHtWvUsavdSSA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Move setting private key to a
 function in prep for EC support
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Feb 22, 2018 at 4:47 PM, Steffan Karger <steffan@...1856...> wrote:
> Hi,
>
> On 26-01-18 16:53, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - Also add reference counting to CAPI_DATA (application data):
>>
>>   When the application data is assigned to the private key
>>   we free it in the key's finish method. Proper error handling
>>   requires to keep track of whether data is assigned to the
>>   key or not before an error occurs. For this purpose, add a
>>   reference count to CAPI_DATA struct and increment it when it is
>>   assigned to the key or its method.
>>

..

>> -    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
>> -    * we decrease it here with RSA_free(), or it will never be cleaned up. */
>> -    RSA_free(rsa);
>> +    cd->ref_count--; /* so that cd will get freed with the private key */
>
> Would a call to CAPI_DATA_free() - effectively the same - not be more
> clear?  I'll let you decide, I'm okay with this too.

Very true. I wonder why I didn't write it so in the first place.. Will
ponder a bit and do a v3.

>
>>      return 1;
>>
>>  err:
>> -    if (cert)
>> -    {
>> -        X509_free(cert);
>> -    }
>> -    if (rsa)
>> -    {
>> -        RSA_free(rsa);
>> -    }
>> -    else
>> -    {
>> -        if (my_rsa_method)
>> -        {
>> -            free(my_rsa_method);
>> -        }
>> -        CAPI_DATA_free(cd);
>> -    }
>> +    CAPI_DATA_free(cd);
>>      return 0;
>>  }
>>
>>
>
> Code looks good, and works as expected on my Win10 test machine.
>
> Accepted-by: Steffan Karger <steffan@...1856...>

Wonder what "Accepted-by" does on patchwork...

Thanks for the review.

Selva

