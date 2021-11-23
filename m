MIME-Version: 1.0
References: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
 <20211119005306.624-1-lstipakov@...277...>
 <CAGyAFMV-9Y5dzTohMqxzfiqcj=Y2cYY+c3VDPi9sCzO6oioE2Q@...278...>
 <CAKuzo_gp82JCi=z2_PROgb8pRbyBXjskwkTWQdUw=2LF0Ct1-g@...278...>
In-Reply-To: <CAKuzo_gp82JCi=z2_PROgb8pRbyBXjskwkTWQdUw=2LF0Ct1-g@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 21:33:29 +0200
Message-ID: <CAGyAFMXYmOCsb_93kiu4S+Yf8XugyJcG35uBAcVysBA-=UpQfw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Load OpenSSL config on Windows from
 trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Thanks,

I tried this one and client wasn't able to connect:

    OpenSSL: error:14201076:SSL routines:tls_choose_sigalg:no suitable
signature algorithm

So it looks like config loading works.

The binaries for V4 could be found here:
https://github.com/lstipakov/openvpn/actions/runs/1496339867

ti 23. marrask. 2021 klo 20.58 Selva Nair (selva.nair@...277...) kirjoitti:
>
> Hi,
>
> On Tue, Nov 23, 2021 at 1:37 PM Lev Stipakov <lstipakov@...277...> wrote:
>>
>> I don't have a setup to properly test it, like actually loading the
>> config - I only checked that the openvpn.exe attempted to access
>> openssl.cnf at the correct location.
>>
>> If someone wants to test - binary artifacts could be found here:
>> https://github.com/lstipakov/openvpn/actions/runs/1496114596
>>
>>
>>
>> I could also do testing if someone educates me how :)
>
>
> Try using an openssl.cnf like the one below which restricts signature alg=
orithms to a some non-PSS schemes. Change that line to restrict them furthe=
r or comment out to use defaults: not including PSS will force non-PSS sign=
ature with TLS 1.2 even with OpenSSL 1.1.1 server. And will break TLS 1.3 n=
egotiation. Removing ECC signatures and using an EC key certificate will br=
eak the connection etc..
>
> #
> # OpenSSL configuration file to restrict siglags during handshake
> #
> openssl_conf =3D default_conf
>
> [default_conf]
> ssl_conf =3D ssl_sect
>
> [ssl_sect]
> system_default =3D system_default_sect
>
> [system_default_sect]
> #MinProtocol =3D TLSv1.2
> #CipherString =3D DEFAULT@...2644...=3D0
> SignatureAlgorithms =3D RSA+SHA256:RSA+SHA384:RSA+SHA512:ECDSA+SHA256:ECD=
SA+SHA384:ECDSA+SHA512:RSA+SHA1:ECDSA+SHA1
> # possible values
> # PKCS1:  rsa_pkcs1_sha256:rsa_pkcs1_sha384:rsa_pkcs1_sha512
> # ECDSA: ecdsa_secp256r1_sha256:ecdsa_secp384r1_sha384:ecdsa_secp521r1_sh=
a512
> # PSS with rsa encryption public key rsa_pss_rsae_sha256:rsa_pss_rsae_sha=
384:rsa_pss_rsae_sha512
> # EdDSA :ed25519:ed448
> # PSS with PSS public key: rsa_pss_pss_sha256:rsa_pss_pss_sha384:rsa_pss_=
pss_sha512
> # Legacy rsa_pkcs1_sha1:ecdsa_sha1



--=20
-Lev

