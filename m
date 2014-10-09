Message-ID: <5436EB77.3030403@...1856...>
Date: Thu, 09 Oct 2014 22:09:27 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <CAPd-S-PVJzdHKfOhMuJMmUG8kEETKweTW46owhAJa6aS4Ny+Qg@...278...>	<5433CFD5.5060901@...515...>	<CAPd-S-OgUuuFJwkz0Unmszyi1Vmv2WEgBaG+RCJ-bWXBvfNzxg@...278...>	<5433FD92.7020400@...1227...>
	<5436B36A.1050105@...1147...> <5436B50A.7040004@...1227...>
In-Reply-To: <5436B50A.7040004@...1227...>
Subject: Re: [Openvpn-devel] Paid Engagement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 09-10-14 18:17, Arne Schwabe wrote:
>> So, it looks like running rsa_sign with a cert/key pair coming out of
>> the cryptostore store is causing some low level openssl problems.
>> Don't know how easy it is fix, but most likely it's not inside the
>> OpenVPN code...
>>
> Pretty easy (for OpenSSL standards...). You have to use the lowlevel
> functions instead of rsa_sign. See also
> https://code.google.com/p/ics-openvpn/source/browse/main/jni/jbcrypto.cpp
> 
> Basically for ics-openvpn the change was to replace
> 
> RSA_sign(NID_md5_sha1, (unsigned char*) data, datalen,
>         sigret, &siglen, pkey->pkey.rsa) <= 0 )
> 
> with
> 
>     siglen = RSA_private_encrypt(datalen,(unsigned char*)
> data,sigret,pkey->pkey.rsa,RSA_PKCS1_PADDING);
> 
> But I haven't looked at the OpenVPN source code yet which code path is
> called there.

I took a peek at the code, and I think it is the other way around. The
cryptoapi code (like e.g. openvpn's pkcs11 code), supplies openssl with
a signing function. OpenSSL then call thet function during the TLS
handshake to get a valid signature.

However, the sign function in openvpn's cryptoapi.c restricts the
possible signatures to tls 1.0/1.1 signatures and needs to be extended.
But here's the catch: Microsofts crypto API sign function does not
understand TLS 1.2 signatures either. Using the encrypt function might
work here too, but the API is quite different, so you'll have to figure
out how to retrieve the correct key (reference).

-Steffan

