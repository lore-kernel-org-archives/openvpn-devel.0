References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
Date: Wed, 22 Jul 2020 16:02:25 +0200
MIME-Version: 1.0
In-Reply-To: <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Arne,

thank you for your feedback. I tested the patch on the latest master 
version at the time of writing and it looks like these requirements were 
added in the last week which is why I wasn't able to address them 
before.I will look into the new issues and get back to you when they are 
fixed.

I agree that most of these functions only require exposing existing 
functionality on our side.

Sincerely
Juliusz

On 22/07/2020 15:37, Arne Schwabe wrote:
> Am 15.07.20 um 10:26 schrieb Juliusz Sosinowicz:
>> Hi Everyone,
>>
>> do you have an update on the latest patch I sent? There have been
>> updates to wolfSSL to fix the remaining issues brought up last time.
>>
> Yes. I looked at this today in the expectation that I just compile test,
> do a few quick tests and the ACK+merge it:
>
> However during our preperation for the next OpenVPN release, we
> reevaluated the minimum OpenSSL version and decided that OpenSSL 1.0.2
> is our minimum target for the next release and removed the OpenSSL 1.0.1
> compatibility defines. I was not aware that WolfSSL depended on the
> compatibility to 1.0.1 but rather surprised since we added all the tests
> compatibility in autoconf that made the OpenSSL 1.1.0+ API checks also
> work for WolfSSL. We also removed the option to compile OpenVPN without
> AEAD support and since WolfSSL supports TLS 1.3, I also did not expect
> that this would be problematic for WolfSSL.
>
>
> The missing functions that I can see quickly are:
>
> SSL_CTX_set1_curves/SSL_CTX_set1_groups
> SSL_CTX_get0_certificate
> X509_get0_notBefore
> X509_get0_notAfter
> SSL_CTX_set_ecdh_auto (Would not be need if WolfSSL declared >= 1.1.0
> version)
> CRYPTO_memcmp
>
> Also EVP_CIPH_FLAG_AEAD_CIPHER was undefined. It looks that in the older
> version/patch the use of the define was ifdef'ed under the assumption
> that support of AEAD implies existence of the macro, which is seems not
> to have been true in the case of WolfSSL.
>
> None of the offending functions looks particularly bad. The get0 are
> just the more modern name of older identical OpenSSL version. The set
> groups is probably already somehow support but not exposed and I would
> be surprised if a constant time memcmp does not already exist in WolfSSL.
>
> Reverting the patch that removed 1.0.1 feel like a bad option at this
> point and will also raise (rightfully) eyebrows and questions.
>
> Arne
>
>

