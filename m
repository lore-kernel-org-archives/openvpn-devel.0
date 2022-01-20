Message-ID: <8477c4e8-161a-5518-9a49-3d6e7c205346@...1227...>
Date: Thu, 20 Jan 2022 11:18:08 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-5-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-5-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 04/18] Implement import of custom
 external keys
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 14.12.21 um 17:59 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
>    Our key object retains info about the external
>    key as an opaque handle to the backend. We also
>    need the public key as an EVP_PKEY *.
> 
>    For native keys we use OpenSSL API to import
>    data into the key. The 'handle' representing the
>    private key in that case is the OpenSSL EVP_PKEY
>    object itself.
> 
>    For importing custom keys, we define custom
>    parameters describing the key using OSSL_PARAM
>    structure. We define 4 required and 1 optional
>    parameters for loading the key:
> 
>    Required params of type OSSL_PARAM:
> 
>    {.key="xkey-origin", .data_type = OSSL_PARAM_UTF8_STRING
>     .data = "foobar", .data_size = 0 }
> 
>    Note: data_size = 0 refer to NUL terminated string in OpenSSL.
>    This parameter is only used to identify that the key as non-native
>    with an opaque handle. We really do not check the content of
>    the string. Should not be NULL.
> 
>    {.key="handle", .data_type = OSSL_PARAM_OCTET_PTR,
>     .data = &handle, .data_size = sizeof(handle)}
> 
>    {.key="pubkey", .data_type = OSSL_PARAM_OCTET_STRING,
>     .data = &pubkey, .data_size = sizeof(pubkey)}
> 
>    {.key="sign_op", .data_type = OSSL_PARAM_OCTET_PTR,
>     .data = &sign_op_ptr, .data_size = sizeof(sign_op_ptr)}
> 
>    Optional param:
> 
>    {.key="free_op", .data_type = OSSL_PARAM_OCTET_PTR,
>     .data = &free_op_ptr, .data_size = sizeof(free_op_ptr)}
> 
>    The 'handle' is opaque to us and is retained. The caller
>    should not free it. We will free it when no longer required
>    by calling 'free_op()', if provided. The 'handle' should
>    not be NULL as that indicates missing private key.
> 
>    The 'pubkey' must be an 'EVP_PKEY *' variable, and is duplicated
>    by us. The caller may free it after return from import.
> 
>    The 'sign_op' and 'free_op' function pointers should be of type
>    'XKEY_EXTERNAL_SIGN_fn' and 'XKEY_PRIVKEY_FREE_fn' defined
>    in xkey_common.h
> 
> For example, for management-external-key, we really do not
> need any 'handle'. Pass anything that will live long and
> won't dereference to NULL. We do not use it for any other
> purpose. Pointer to a const string could be a choice.
> In this case, free_op = NULL is the safest choice.
> 
> For a usage of keymgmt_import(), see the helper function
> implemented using it to load the management key in the next commit.
> 
> v2 changes: "origin" --> "xkey-origin"
>              This was 5/9 in v1


Acked-By: Arne Schwabe <arne@...1227...>



