MIME-Version: 1.0
References: <1522729843-28878-1-git-send-email-selva.nair@...277...>
 <1581359742-30511-1-git-send-email-selva.nair@...277...>
 <CAGyAFMVMTyANkxFoMmctyRum15E5Dntm=hWLSemg9WxgRXT_tg@...278...>
In-Reply-To: <CAGyAFMVMTyANkxFoMmctyRum15E5Dntm=hWLSemg9WxgRXT_tg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 11 Feb 2020 11:23:46 -0500
Message-ID: <CAKuzo_hqRhrAYZ=b2tcez5uTcZavg8CkpMNZKBA_q90HrMxt3Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2 v3] Skip expired certificates in
 Windows certificate store
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks for reviewing this.

On Tue, Feb 11, 2020 at 4:52 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi,
>
>> +    DWORD find_type;
>> +    const void *find_param;
>>
>>
>>
>>      if (!strncmp(cert_prop, "SUBJ:", 5))
>>      {
>>
>> +        find_param = cert_prop + 5;
>> +        find_type = CERT_FIND_SUBJECT_STR_A;
>>      }
>>      else if (!strncmp(cert_prop, "THUMB:", 6))
>>      {
>> +        find_type = CERT_FIND_HASH;
>> +        find_param = &blob;
>> +    }
>> +    while(true)
>> +    {
>>          rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
>> +                                        0, find_type, find_param, rv);
>
>
> This explodes if cert_prop doesn't start with either "SUBJ:" or "THUMB:" since we pass
> uninitialized arguments.

That's a terrible oversight. My bad. v4 is coming.

>
> This problem didn't exist before, since we looked for certificate inside above "if" blocks where
> both variables are initialized.
>
> Another thing:
>
>> +    unsigned char hash[255];
>> +    CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
>>
>>      else if (!strncmp(cert_prop, "THUMB:", 6))
>>      {
>> -        unsigned char hash[255];
>> -        CRYPT_HASH_BLOB blob;
>
>
> Why did you move "hash" and "blob" to the outer scope? I think those
> variables should stay where they have been, since they're not used outside of "if".

The actual certificate search is now done outside (in the while loop)
and it refers
to find_param which could be &blob.

Alternatively one could do the search separately for SUBJ and THUMB as
in the original,
but with the new logic of iterating through the store, a combined
approach looked
"cleaner".

Selva

