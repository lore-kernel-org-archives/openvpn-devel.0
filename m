MIME-Version: 1.0
References: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
 <20211119005306.624-1-lstipakov@...277...>
 <CAGyAFMV-9Y5dzTohMqxzfiqcj=Y2cYY+c3VDPi9sCzO6oioE2Q@...278...>
In-Reply-To: <CAGyAFMV-9Y5dzTohMqxzfiqcj=Y2cYY+c3VDPi9sCzO6oioE2Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Nov 2021 13:57:47 -0500
Message-ID: <CAKuzo_gp82JCi=z2_PROgb8pRbyBXjskwkTWQdUw=2LF0Ct1-g@...278...>
Content-Type: multipart/alternative; boundary="00000000000020f36b05d1795210"
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--00000000000020f36b05d1795210
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Nov 23, 2021 at 1:37 PM Lev Stipakov <lstipakov@...277...> wrote:

> I don't have a setup to properly test it, like actually loading the
> config - I only checked that the openvpn.exe attempted to access
> openssl.cnf at the correct location.
>
> If someone wants to test - binary artifacts could be found here:
> https://github.com/lstipakov/openvpn/actions/runs/1496114596


>
> I could also do testing if someone educates me how :)
>

Try using an openssl.cnf like the one below which restricts signature
algorithms to a some non-PSS schemes. Change that line to restrict them
further or comment out to use defaults: not including PSS will force
non-PSS signature with TLS 1.2 even with OpenSSL 1.1.1 server. And will
break TLS 1.3 negotiation. Removing ECC signatures and using an EC key
certificate will break the connection etc..

#
# OpenSSL configuration file to restrict siglags during handshake
#
openssl_conf = default_conf

[default_conf]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
#MinProtocol = TLSv1.2
#CipherString = DEFAULT@...2644...=0
SignatureAlgorithms =
RSA+SHA256:RSA+SHA384:RSA+SHA512:ECDSA+SHA256:ECDSA+SHA384:ECDSA+SHA512:RSA+SHA1:ECDSA+SHA1
# possible values
# PKCS1:  rsa_pkcs1_sha256:rsa_pkcs1_sha384:rsa_pkcs1_sha512
# ECDSA:
ecdsa_secp256r1_sha256:ecdsa_secp384r1_sha384:ecdsa_secp521r1_sha512
# PSS with rsa encryption public key
rsa_pss_rsae_sha256:rsa_pss_rsae_sha384:rsa_pss_rsae_sha512
# EdDSA :ed25519:ed448
# PSS with PSS public key:
rsa_pss_pss_sha256:rsa_pss_pss_sha384:rsa_pss_pss_sha512
# Legacy rsa_pkcs1_sha1:ecdsa_sha1

--00000000000020f36b05d1795210
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Nov 23, 2021 at 1:37 PM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
I don&#39;t have a setup to properly test it, like actually loading the<br>
config - I only checked that the openvpn.exe attempted to access<br>
openssl.cnf at the correct location.<br>
<br>
If someone wants to test - binary artifacts could be found here:<br>
<a href=3D"https://github.com/lstipakov/openvpn/actions/runs/1496114596" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/lstipakov/openvpn/act=
ions/runs/1496114596</a>=C2=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><br>
<br>
I could also do testing if someone educates me how :)<br></blockquote><div>=
<br></div><div>Try using an openssl.cnf like the one below which restricts =
signature algorithms to a some non-PSS schemes. Change that line to restric=
t them further or comment out to use defaults: not including PSS will force=
 non-PSS signature with TLS 1.2 even with OpenSSL 1.1.1 server. And will br=
eak TLS 1.3 negotiation. Removing ECC signatures and using an EC key certif=
icate will break the connection etc..</div><div><br></div><div>#<br># OpenS=
SL configuration file to restrict siglags during handshake<br>#<br>openssl_=
conf =3D default_conf<br><br>[default_conf]<br>ssl_conf =3D ssl_sect<br><br=
>[ssl_sect]<br>system_default =3D system_default_sect<br><br>[system_defaul=
t_sect]<br>#MinProtocol =3D TLSv1.2<br>#CipherString =3D DEFAULT@...2644...=
=3D0<br></div><div>SignatureAlgorithms =3D RSA+SHA256:RSA+SHA384:RSA+SHA512=
:ECDSA+SHA256:ECDSA+SHA384:ECDSA+SHA512:RSA+SHA1:ECDSA+SHA1</div><div># pos=
sible values<br># PKCS1:=C2=A0 rsa_pkcs1_sha256:rsa_pkcs1_sha384:rsa_pkcs1_=
sha512<br># ECDSA: ecdsa_secp256r1_sha256:ecdsa_secp384r1_sha384:ecdsa_secp=
521r1_sha512<br># PSS with rsa encryption public key rsa_pss_rsae_sha256:rs=
a_pss_rsae_sha384:rsa_pss_rsae_sha512<br># EdDSA :ed25519:ed448<br># PSS wi=
th PSS public key: rsa_pss_pss_sha256:rsa_pss_pss_sha384:rsa_pss_pss_sha512=
<br># Legacy rsa_pkcs1_sha1:ecdsa_sha1</div></div></div>

--00000000000020f36b05d1795210--

