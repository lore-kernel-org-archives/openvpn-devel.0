Message-ID: <a0ae9930-ec24-3a2f-cdf8-5f3d68f97068@...2108...>
Date: Tue, 14 Mar 2023 10:02:52 +0100
MIME-Version: 1.0
Content-Language: en-US
From: David Sommerseth <dazo+openvpn@...2108...>
References: <20230311052403.1154030-1-selva.nair@...277...>
 <c471a93d-6c95-62f1-6b30-da39a744c5f3@...2108...>
In-Reply-To: <c471a93d-6c95-62f1-6b30-da39a744c5f3@...2108...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Convert ECDSA signature form
 pkcs11-helper to DER encoded form
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
To: openvpn-devel@lists.sourceforge.net

On 14/03/2023 09:45, David Sommerseth wrote:
> On 11/03/2023 06:24, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - With OpenSSL 3.0 and xkey-provider, we use 
>> pkcs11h_certificate_signAny_ex()
>>    which returns EC signature as raw r|s concatenated. But OpenSSL 
>> expects
>>    a DER encoded ASN.1 structure.
>>
>>    Do this conversion as done in cryptoapi.c. For code re-use, 
>> ecdsa_bin2sig()
>>    is consolidated with sig to DER conversion as ecdsa_bin2der() and
>>    moved to xkey_helper.c
>>
>>    In the past when we used OpenSSL hooks installed by pkcs11-helper,
>>    such a conversion was not required as it was internally handled by
>>    the library.
>>
>> Reported by: Tom <openvpn@...2719...>
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
> Just FYI, this report appeared in the bugzilla for the Fedora packaging. 
>   This seems related to this patch.
> <https://bugzilla.redhat.com/show_bug.cgi?id=2177834>
> 
> I will try to prepare a Fedora build with this patch added, for further 
> testing.

Fedora Koji builds of OpenVPN 2.6.1 with this patch included:

Fedora 38: <https://koji.fedoraproject.org/koji/taskinfo?taskID=98680872>
      x86_64 packages: 
<https://koji.fedoraproject.org/koji/taskinfo?taskID=98680943>

Fedora 37: <https://koji.fedoraproject.org/koji/taskinfo?taskID=98680878>
      x86_64 packages: 
<https://koji.fedoraproject.org/koji/taskinfo?taskID=98680991>



-- 
kind regards,

David Sommerseth
OpenVPN Inc



