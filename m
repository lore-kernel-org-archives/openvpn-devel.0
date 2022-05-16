Message-ID: <4229a130-77ff-8261-0581-725dcb15ea54@...1227...>
Date: Mon, 16 May 2022 12:42:54 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220510113055.1829260-1-arne@...1227...>
 <20220513130437.2221164-1-arne@...1227...>
 <CAKuzo_geB6xQ_vvk2uDrcsL6RvmLJFo_aFnmWrs-t3QW+3Lx7w@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_geB6xQ_vvk2uDrcsL6RvmLJFo_aFnmWrs-t3QW+3Lx7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Implement ED448 and ED25519 support
 in xkey_provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


>>       /* if management client cannot do digest -- we do it here */
>> -    if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_DIGEST))
>> +    if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_DIGEST)
>> +        && strcmp(alg.mdname, "none") != 0)
> 
> nit: Why not strcmp(alg.mdname, "none")? That's how we use it
> elsewhere in the patch and this file. Unless our coding style now
> requires this.

clang-tidy complained but I have no strong preference, I will remove the 
!= 0 in v3 of the patch.

>>       }
>> +    else if (EVP_PKEY_get_id(pkey) == EVP_PKEY_ED25519)
>> +    {
>> +        mdname = NULL;
>> +        params[0] = OSSL_PARAM_construct_utf8_string(OSSL_SIGNATURE_PARAM_DIGEST, (char *)mdname, 0);
> 
> I think it's wrong to pass NULL here as the last 0 in
> OSSL_PARAM_construct() means what is passed is a null-terminated
> string. We cope with this in xkey_provider for this particular case by
> checking for NULL, but generally we would dereference strings in
> OSSL_PARAM without checking. OpenSSL also may.
> 
> In any case, mdname = NULL is all that is required for this key type
> and no need to set any params (same as with EC).

Good point. I still think the OpenSSL API is kind of broken here as it 
basically forces you do pass NULL in 
EVP_DigestSignInit/EVP_DigestSignInit_ex but you cannot pass the same 
with params but that is not the place to fix it.

Arne


