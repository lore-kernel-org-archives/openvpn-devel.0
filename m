MIME-Version: 1.0
In-Reply-To: <d272283b-a764-8380-6616-85b0817cade1@...1227...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-4-git-send-email-selva.nair@...277...>
 <d272283b-a764-8380-6616-85b0817cade1@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Jan 2018 23:41:00 -0500
Message-ID: <CAKuzo_jAKoBBi8oWu23mgSFCru=Uv9_gVQhQ9y_PwvNA9NsvSg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Document management request
 >ECDSA_SIGN and response ecdsa-sig
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

FWIW, some remarks on the hash and the signature below.

On Tue, Jan 16, 2018 at 5:23 PM, Arne Schwabe <arne@...1227...> wrote:
> Am 14.01.18 um 20:44 schrieb selva.nair@...277...:
>> From: Selva Nair <selva.nair@...277...>
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>> ---
>>  doc/management-notes.txt | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
>> index a9ba18a..e2e8249 100644
>> --- a/doc/management-notes.txt
>> +++ b/doc/management-notes.txt
>> @@ -795,6 +795,36 @@ Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
>>  This capability is intended to allow the use of arbitrary cryptographic
>>  service providers with OpenVPN via the management interface.
>>
>> +COMMAND -- ecdsa-sig (OpenVPN 2.5 or higher)
>> +------------------------------------------
>> +Same as rsa-sig but for EC keys: requires openssl 1.1
>> +
>> +Provides support for external storage of the EC private key. Requires the
>> +--management-external-key option. This option can be used instead of "key"
>> +in client mode, and allows the client to run without the need to load the
>> +actual private key. When the SSL protocol needs to perform a sign
>> +operation, the data to be signed will be sent to the management interface
>> +via a notification as follows:
>> +
>> +>ECDSA_SIGN:[BASE64_DATA]
>> +
>> +The management interface client should then create a DER encoded signature of
>> +the (decoded) BASE64_DATA using the private key and return the SSL signature as
>> +follows:
>> +
>> +ecdsa-sig
>> +[BASE64_SIG_LINE]
>> +.
>> +.
>> +.
>> +END
>> +
>> +Base64 encoded output of ECDSA_sign() (OpenSSL) or mbedtls_pk_sign()
>> +(mbed TLS) will provide a correct signature.
>> +
>
> Signature.getInstance("NONEwithECDSA") worked for me in Java for this.
> Any other signature algorithm did _NOT_ work e.g. SHA384withECDSA. I
> think ecdsa-sign might already provided a hash to sign.

Yes, the hash is what is provided in this signature request. In this
particular case,
the data is handshake history and may not be even saved. Its the accumulated
hash that is passed in by the SSL/TLS library to the callback.

So "NONEwithECDSA" should be the right choice for Java (Sun/Oracle) -- or
ECDSAforSSL in case of IBM Java.

>
> On the other hand mbedtls documentation states:
>
>    For RSA, md_alg may be MBEDTLS_MD_NONE if hash_len != 0. For
>    ECDSA md_alg may never be MBEDTLS_MD_NONE.

External RSA keys currently work with both openssl and mbedtls.

To elaborate, for RSA, its more complicated as the hash to be encoded
with the OID of the hash algo prepended to it as specified in PKCS1 v1.5,
then padded and signed. Unless the pre TLS1.2  MD5+SHA1 mixed hash is
in use. In the latter case only padding is needed and that's the case where
mbedtls specifies hash type as none.

For RSA, openssl callback gets the encoded hash (not padded) and signing
involves padding + encryption only (hash type is not needed). But mbedtls
provides the hash and hash algorithm and the signing routine has to encode it.
However, the pkcs1 v1.5 encoding part is already present in ssl_mbedtls.c
(implemented by Stefan, I suppose) so what the management interface gets is
the same  data for both openssl and  mbedtls builds as far as RSA is concerned.

>
> So this interface might not work with mbedtls.

It should work if only we could find a way to set a callback for this
in mbedtls.
It seems they provide that facility only for RSA keys. Stefan may know.
Not sure how pkcs11-helper hooks on to it -- does it support EC keys?

Regards,

Selva

