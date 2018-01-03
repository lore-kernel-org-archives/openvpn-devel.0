MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
 <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 3 Jan 2018 18:13:54 +0100
Message-ID: <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
Content-Type: multipart/alternative; boundary="001a113e5a9c14423a0561e257a6"
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113e5a9c14423a0561e257a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steffan,

On Mon, Jan 1, 2018 at 4:36 PM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 01-01-18 14:57, Emmanuel Deloget wrote:
> > I'm trying to get openvpn read my certificates from a TPM2 using a
> > specially crafted PKCS#11 provider (the existing tpm2-pk11 is quite
> > limited for now but I might be able to extend it).
> >
> > However, the PKCS#11 API is not something I'm comfortable with, and I'd
> > like to know if there is some document (design or anything, really) that
> > could help me to understand what openvpn wants exactly in order for me
> > to provide the missing bits. I've read the documents at [1] but found
> > nothing here of interest (for me).
> >
> > So, does someone have any pointer?
>
> You're right that OpenVPN's pkcs11 options lack some high-level
> documentation.  Maybe I can shed some light on the basics (probably
> taking a step further back than you need).
>
> First, you need some shared object (.so, .dll) that provides the
> interface specified by the PKCS11 standard.  OpenVPN will load that
> module, and call its functions to provide private key operations.  That
> shared object is usually provided by your smartcard vendor.  That shared
> object takes care of communication with the underlying key store (smart
> card, tpm, hsm, ...).  The openvpn manpage calls this a pkcs11 'provider'.
>
> $ openvpn --show-pkcs11-ids
> /usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so
>
> The following objects are available for use.
> Each object shown below may be used as parameter to
> --pkcs11-id option please remember to use single quote mark.
>


=E2=80=8BI seen that while testing. =E2=80=8B



>
> Certificate
>        DN:             C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest-Clien=
t,
> emailAddress=3Dme@...430...
>        Serial:         02
>        Serialized id:
> Gnome\x20Keyring/1\x2E0/1\x3AUSER\x3ADEFAULT/Gnome2\x20Key\x
> 20Storage/1A9D824585217F1BD54603E83F042F570A2EE9F2
>
> (I have the openvpn client testkey in my local gnome keyring, to easily
> test pkcs11 without a hardware token.)
>
> From that list, you pick the object you want to use, and specify the
> provider and id in your config file.  In this case:
>
> pkcs11-providers "/usr/lib/x86_64-linux-gnu/pkc
> s11/gnome-keyring-pkcs11.so"
> pkcs11-id
> "Gnome\\x20Keyring/1\\x2E0/1\\x3AUSER\\x3ADEFAULT/Gnome2\\x2
> 0Key\\x20Storage/1B3B2BEBF36576443D3A903AFA8997221B93FCC1"
>
> You specify this *instead* of the regular 'key' and 'cert' options.
> Note that you'll need toe escape backslashes.
>
>
=E2=80=8BGood to know :)=E2=80=8B



> You should now be able to use pkcs11 for the private key operations.
>
> Since each keystore behaves differently, I did not specify how to get
> the private key in there.  But I guess your TPM vendor providers tooling
> for that.
>

Well, TPM2 is a keystore, so that should work :)

I am able to store the certificate in the TPM2 nvram (as a DER file) and I
have a corresponding RSA private key (also in the TPM2, in the persistent
object area).

The PKCS11 provider I'm using (tpm2-pk11) has been modified to get the
certificate from the TPM2, but I don't know how to tell openvpn to use the
corresponding key on the TPM2 (and to use the TPM2_RSA_encrypt/RSA_decrypt
functions).

I'm not sure what's missing here (probably something on my side, either
some config or some code here and there). Here are the PKCS#11 ids and my
current configuration:

root@...2370... ~# openvpn --show-pkcs11-ids

The following objects are available for use.
Each object shown below may be used as parameter to
--pkcs11-id option please remember to use single quote mark.

Certificate
       DN:             C=3DFR, O=3DME, OU=3DUnit, CN=3D005043361C24
       Serial:
 CFC3AC7FC37F777CF509506BC8EA0A94E9FBDC121686FEBEACEF99AC474ED21D
       Serialized id:  ME/TPM2/00000000/nvram/01800008

Certificate
       DN:             C=3DUS, O=3DME, OU=3DUnit, CN=3D006060584526
       Serial:         266B18A3534E3179
       Serialized id:  ME/TPM2/00000000/nvram/01800004






client
# -- yeah, this is not the real server :)
remote openvpn.example.com
port 443
dev tun
persist-key
persist-tun
proto tcp6-client
tun-mtu 1500
auth SHA256
connect-retry-max 3
remap-usr1 SIGTERM

remote-cert-tls server
tls-client
ca /etc/PKI/CA.pem
tls-auth /etc/PKI/TA.ta 1
cipher AES-256-CBC
script-security 2
pkcs11-providers "/usr/lib/libtpm2-pk11.so"

# -- in DER format

pkcs11-id "ME/TPM2/00000000/nvram/01800008"

# -------------------- previous key configuration ----------------------
# -- same as ME/TPM2/00000000/nvram/01800008
# cert /etc/PKI/client.pem
# -- also in the TPM2, but how to tell that to openvpn?
# key /etc/PKI/client.key

up /etc/openvpn/start.sh
down /etc/openvpn/stop.sh

comp-lzo
verb 11

float



In my understanding, and within a context of dual authentication (server
identifies client, client identifies server), I should see the following
set of operation:

* fetch the certificate
* initiate communication and so some RSA magic
* everything's ok? continue

Of course, I might be wrong. What I see is (with some printf within the
PKCS#11 provider, you can ignore them but they give you an idea of what
happens)

root@...2370... ~# openvpn --config /etc/openvpn/client.conf
Wed Jan  3 17:53:38 2018 us=3D413562 OpenVPN 2.4.0 aarch64-openwrt-linux-gnu
[SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD]
Wed Jan  3 17:53:38 2018 us=3D413603 library versions: OpenSSL 1.0.2k  26 J=
an
2017, LZO 2.09
Wed Jan  3 17:53:38 2018 us=3D413773 PKCS#11: Adding PKCS#11 provider
'/usr/lib/libtpm2-pk11.so'
Wed Jan  3 17:53:38 2018 us=3D413812 PKCS#11: pkcs11h_addProvider entry
version=3D'1.22', pid=3D27700, reference=3D'/usr/lib/libtpm2-pk11.so',
provider_location=3D'/usr/lib/libtpm2-pk11.so', allow_protected_auth=3D0,
mask_private_mode=3D00000000, cert_is_private=3D0
Wed Jan  3 17:53:38 2018 us=3D413832 PKCS#11: Adding provider
'/usr/lib/libtpm2-pk11.so'-'/usr/lib/libtpm2-pk11.so'
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetFunctionList
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Initialize
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetInfo
Wed Jan  3 17:53:38 2018 us=3D423143 PKCS#11: pkcs11h_addProvider Provider
'/usr/lib/libtpm2-pk11.so' manufacturerID 'ME'
Wed Jan  3 17:53:38 2018 us=3D423182 PKCS#11: _pkcs11h_slotevent_notify ent=
ry
Wed Jan  3 17:53:38 2018 us=3D423197 PKCS#11: _pkcs11h_slotevent_notify ret=
urn
Wed Jan  3 17:53:38 2018 us=3D423216 PKCS#11: Provider
'/usr/lib/libtpm2-pk11.so' added rv=3D0-'CKR_OK'
Wed Jan  3 17:53:38 2018 us=3D423230 PKCS#11: pkcs11h_addProvider return
rv=3D0-'CKR_OK'
Wed Jan  3 17:53:38 2018 us=3D423263 NOTE: the current --script-security
setting may allow this configuration to call user-defined scripts
Wed Jan  3 17:53:38 2018 us=3D423733 PKCS#11:
pkcs11h_certificate_deserializeCertificateId entry
p_certificate_id=3D0x7ffeb0a098, sz=3D'ME/TPM2/00000000/nvram/01800008'
Wed Jan  3 17:53:38 2018 us=3D423760 PKCS#11:
_pkcs11h_certificate_newCertificateId entry p_certificate_id=3D0x7ffeb0a050
Wed Jan  3 17:53:38 2018 us=3D423776 PKCS#11:
_pkcs11h_certificate_newCertificateId return rv=3D0-'CKR_OK',
*p_certificate_id=3D0x2501d9d0
Wed Jan  3 17:53:38 2018 us=3D423798 PKCS#11:
pkcs11h_token_deserializeTokenId entry p_token_id=3D0x2501d9d0,
sz=3D'ME/TPM2/00000000/nvram'
Wed Jan  3 17:53:38 2018 us=3D423813 PKCS#11: _pkcs11h_token_newTokenId ent=
ry
p_token_id=3D0x7ffeb09fb8
Wed Jan  3 17:53:38 2018 us=3D423833 PKCS#11: _pkcs11h_token_newTokenId
return rv=3D0-'CKR_OK', *p_token_id=3D0x2501de30
Wed Jan  3 17:53:38 2018 us=3D423854 PKCS#11:
pkcs11h_token_deserializeTokenId return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:38 2018 us=3D423881 PKCS#11:
pkcs11h_certificate_deserializeCertificateId return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:38 2018 us=3D423899 PKCS#11: pkcs11h_certificate_create
entry certificate_id=3D0x2501d9d0, user_data=3D(nil), mask_prompt=3D0000000=
3,
pin_cache_period=3D-1, p_certificate=3D0x7ffeb0a0a0
Wed Jan  3 17:53:38 2018 us=3D423918 PKCS#11:
pkcs11h_certificate_duplicateCertificateId entry to=3D0x2501e2a0
form=3D0x2501d9d0
Wed Jan  3 17:53:38 2018 us=3D423934 PKCS#11:
pkcs11h_certificate_duplicateCertificateId return rv=3D0-'CKR_OK',
*to=3D0x2501e310
Wed Jan  3 17:53:38 2018 us=3D423948 PKCS#11:
_pkcs11h_session_getSessionByTokenId entry token_id=3D0x2501e740,
p_session=3D0x2501e2b0
Wed Jan  3 17:53:38 2018 us=3D423961 PKCS#11: Creating a new session
Wed Jan  3 17:53:38 2018 us=3D423976 PKCS#11: pkcs11h_token_duplicateTokenId
entry to=3D0x2501ebc8 form=3D0x2501e740
Wed Jan  3 17:53:38 2018 us=3D423994 PKCS#11: pkcs11h_token_duplicateTokenId
return rv=3D0-'CKR_OK', *to=3D0x2501ec30
Wed Jan  3 17:53:38 2018 us=3D424008 PKCS#11:
_pkcs11h_session_getSessionByTokenId return rv=3D0-'CKR_OK',
*p_session=3D0x2501ebb0
Wed Jan  3 17:53:38 2018 us=3D424021 PKCS#11: pkcs11h_certificate_create
return rv=3D0-'CKR_OK' *p_certificate=3D0x2501e2a0
Wed Jan  3 17:53:38 2018 us=3D424036 PKCS#11: pkcs11h_openssl_createSession=
 -
entry
Wed Jan  3 17:53:38 2018 us=3D424086 PKCS#11: pkcs11h_openssl_createSession=
 -
return openssl_session=3D0x2501f0e0
Wed Jan  3 17:53:38 2018 us=3D424101 PKCS#11: pkcs11h_openssl_session_getEVP
- entry openssl_session=3D0x2501f0e0
Wed Jan  3 17:53:38 2018 us=3D424117 PKCS#11: pkcs11h_openssl_session_getX5=
09
- entry openssl_session=3D0x2501f0e0
Wed Jan  3 17:53:38 2018 us=3D424132 PKCS#11: pkcs11h_openssl_getX509 - ent=
ry
certificate=3D0x2501e2a0
Wed Jan  3 17:53:38 2018 us=3D758314 PKCS#11:
pkcs11h_certificate_getCertificateBlob entry certificate=3D0x2501e2a0,
certificate_blob=3D(nil), *p_certificate_blob_size=3D0000000000000000
Wed Jan  3 17:53:38 2018 us=3D758608 PKCS#11:
__pkcs11h_certificate_loadCertificate entry certificate=3D0x2501e2a0
Wed Jan  3 17:53:38 2018 us=3D758805 PKCS#11: _pkcs11h_session_validate ent=
ry
session=3D0x2501ebb0
Wed Jan  3 17:53:38 2018 us=3D758996 PKCS#11: _pkcs11h_session_validate
return rv=3D179-'CKR_SESSION_HANDLE_INVALID'
Wed Jan  3 17:53:38 2018 us=3D759184 PKCS#11:
__pkcs11h_certificate_loadCertificate return
rv=3D179-'CKR_SESSION_HANDLE_INVALID'
Wed Jan  3 17:53:38 2018 us=3D759416 PKCS#11:
_pkcs11h_certificate_resetSession entry certificate=3D0x2501e2a0,
public_only=3D1, session_mutex_locked=3D0
Wed Jan  3 17:53:38 2018 us=3D759629 PKCS#11: _pkcs11h_session_login entry
session=3D0x2501ebb0, is_publicOnly=3D1, readonly=3D1, user_data=3D(nil),
mask_prompt=3D00000003
Wed Jan  3 17:53:38 2018 us=3D759812 PKCS#11: _pkcs11h_session_logout entry
session=3D0x2501ebb0
Wed Jan  3 17:53:38 2018 us=3D759985 PKCS#11: _pkcs11h_session_logout return
Wed Jan  3 17:53:38 2018 us=3D760175 PKCS#11: _pkcs11h_session_reset entry
session=3D0x2501ebb0, user_data=3D(nil), mask_prompt=3D00000003,
p_slot=3D0x7ffeb09a28
Wed Jan  3 17:53:38 2018 us=3D760363 PKCS#11: _pkcs11h_session_reset Expect=
ed
token manufacturerID=3D'ME' model=3D'TPM2', serialNumber=3D'00000000',
label=3D'nvram'
Wed Jan  3 17:53:38 2018 us=3D760554 PKCS#11: _pkcs11h_session_getSlotList
entry provider=3D0x250093c0, token_present=3D1, pSlotList=3D0x7ffeb098c8,
pulCount=3D0x7ffeb098d0
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetSlotList
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetSlotList
Wed Jan  3 17:53:38 2018 us=3D760880 PKCS#11: _pkcs11h_session_getSlotList
return rv=3D0-'CKR_OK' *pulCount=3D1
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetTokenInfo
Wed Jan  3 17:53:38 2018 us=3D761228 PKCS#11: _pkcs11h_token_getTokenId ent=
ry
p_token_id=3D0x7ffeb098d8
Wed Jan  3 17:53:38 2018 us=3D761422 PKCS#11: _pkcs11h_token_newTokenId ent=
ry
p_token_id=3D0x7ffeb09818
Wed Jan  3 17:53:38 2018 us=3D761615 PKCS#11: _pkcs11h_token_newTokenId
return rv=3D0-'CKR_OK', *p_token_id=3D0x2501f5d0
Wed Jan  3 17:53:38 2018 us=3D761811 PKCS#11: _pkcs11h_token_getTokenId
return rv=3D0-'CKR_OK', *p_token_id=3D0x2501f5d0
Wed Jan  3 17:53:38 2018 us=3D761995 PKCS#11: _pkcs11h_session_reset Found
token manufacturerID=3D'ME' model=3D'TPM2', serialNumber=3D'00000000',
label=3D'nvram'
Wed Jan  3 17:53:38 2018 us=3D762296 PKCS#11: pkcs11h_token_freeTokenId ent=
ry
certificate_id=3D0x2501f5d0
Wed Jan  3 17:53:38 2018 us=3D762474 PKCS#11: pkcs11h_token_freeTokenId ret=
urn
Wed Jan  3 17:53:38 2018 us=3D762656 PKCS#11: _pkcs11h_session_reset return
rv=3D0-'CKR_OK', *p_slot=3D4660
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_OpenSession
---- OBJS | tpm2-pk11-e4589948e8/src/objects.c:object_load
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_readpublic [H =3D 0x81010001]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_readpublic [H =3D 0x81010002]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvlist
++++ ++++ | nvlist.count =3D 4
++++ ++++ | loading nvram index =3D 01800004
---- CERT |
tpm2-pk11-e4589948e8/src/certificate.c:certificate_read_from_tpm [index =3D
01800004]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvread [index =3D 01800004]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvreadpublic [index =3D
01800004]
++++ ++++ | added object 0x2503cbd0, certificate 0x2503ccb8
++++ ++++ | loading nvram index =3D 01800008
---- CERT |
tpm2-pk11-e4589948e8/src/certificate.c:certificate_read_from_tpm [index =3D
01800008]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvread [index =3D 01800008]
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvreadpublic [index =3D
01800008]
++++ ++++ | added object 0x2503c2c0, certificate 0x2503d568
Wed Jan  3 17:53:39 2018 us=3D209982 PKCS#11: _pkcs11h_session_login return
rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D210058 PKCS#11:
_pkcs11h_certificate_resetSession return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D210106 PKCS#11:
__pkcs11h_certificate_loadCertificate entry certificate=3D0x2501e2a0
Wed Jan  3 17:53:39 2018 us=3D210150 PKCS#11: _pkcs11h_session_validate ent=
ry
session=3D0x2501ebb0
Wed Jan  3 17:53:39 2018 us=3D210194 PKCS#11: _pkcs11h_session_validate
session->pin_expire_time=3D0, time=3D1514998419
Wed Jan  3 17:53:39 2018 us=3D210237 PKCS#11: _pkcs11h_session_validate
return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D210282 PKCS#11: _pkcs11h_session_findObjects
entry session=3D0x2501ebb0, filter=3D0x7ffeb09f30, filter_attrs=3D2,
p_objects=3D0x7ffeb09f08, p_objects_found=3D0x7ffeb09f10
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjectsInit [filters<2> =
=3D
0x7ffeb09f30]
++++ ++++ | filter[0].type =3D 0x00000000
++++ ++++ | filter[1].type =3D 0x00000102
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjects
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
++++ ++++ | object =3D 0x2503c2c0, handle =3D 38632038
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000001 =3D
CKO_CERTIFICATE (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | >> type =3D 00000102 =3D CKA_ID, value =3D 08008001
++++ ++++ | filtered =3D no
++++ ++++ | object =3D 0x2503cbd0, handle =3D 30382031
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000001 =3D
CKO_CERTIFICATE (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | >> type =3D 00000102 =3D CKA_ID, value =3D 04008001
++++ ++++ | filtered =3D yes
++++ ++++ | object =3D 0x2503be30, handle =3D 00000000
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000002 =3D
CKO_PUBLIC_KEY (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | filtered =3D yes
++++ ++++ | object =3D 0x2503b7e0, handle =3D 81010002
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000003 =3D
CKO_PRIVATE_KEY (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | filtered =3D yes
++++ ++++ | object =3D 0x2503b850, handle =3D 00000000
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000002 =3D
CKO_PUBLIC_KEY (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | filtered =3D yes
++++ ++++ | object =3D 0x25038960, handle =3D 81010001
++++ ++++ | >> type =3D 00000000 =3D CKA_CLASS, value =3D 00000003 =3D
CKO_PRIVATE_KEY (expected 00000001 =3D CKO_CERTIFICATE)
++++ ++++ | filtered =3D yes
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjects
---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjectsFinal
Wed Jan  3 17:53:39 2018 us=3D593596 PKCS#11: _pkcs11h_session_findObjects
return rv=3D0-'CKR_OK', *p_objects_found=3D1
Wed Jan  3 17:53:39 2018 us=3D593900 PKCS#11:
_pkcs11h_session_getObjectAttributes entry session=3D0x2501ebb0,
object=3D621003456, attrs=3D0x7ffeb09f18, count=3D1
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetAttributeValue
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetAttributeValue
Wed Jan  3 17:53:39 2018 us=3D595105 PKCS#11:
_pkcs11h_session_getObjectAttributes return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D595333 PKCS#11:
_pkcs11h_certificate_isBetterCertificate entry current=3D(nil),
current_size=3D0000000000000000, newone=3D0x2503dd70,
newone_size=3D00000000000006f9
Wed Jan  3 17:53:39 2018 us=3D595538 PKCS#11:
_pkcs11h_certificate_isBetterCertificate return is_better=3D1
Wed Jan  3 17:53:39 2018 us=3D595750 PKCS#11:
_pkcs11h_session_freeObjectAttributes entry attrs=3D0x7ffeb09f18, count=3D1
Wed Jan  3 17:53:39 2018 us=3D595943 PKCS#11:
_pkcs11h_session_freeObjectAttributes return
Wed Jan  3 17:53:39 2018 us=3D596137 PKCS#11:
__pkcs11h_certificate_updateCertificateIdDescription entry
certificate_id=3D0x2501e310
Wed Jan  3 17:53:39 2018 us=3D598698 PKCS#11:
__pkcs11h_certificate_updateCertificateIdDescription return
displayName=3D'/C=3DFR/O=3DME/OU=3DUnit/CN=3D005043361C24 on nvram'
Wed Jan  3 17:53:39 2018 us=3D599056 PKCS#11:
__pkcs11h_certificate_loadCertificate return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D599287 PKCS#11:
pkcs11h_certificate_getCertificateBlob return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D599501 PKCS#11:
pkcs11h_certificate_getCertificateBlob entry certificate=3D0x2501e2a0,
certificate_blob=3D0x2503dd70, *p_certificate_blob_size=3D00000000000006f9
Wed Jan  3 17:53:39 2018 us=3D599706 PKCS#11:
pkcs11h_certificate_getCertificateBlob return rv=3D0-'CKR_OK'
Wed Jan  3 17:53:39 2018 us=3D601366 PKCS#11: pkcs11h_openssl_getX509 -
return rv=3D0-'CKR_OK', x509=3D0x2501f140
Wed Jan  3 17:53:39 2018 us=3D603117 PKCS#11: pkcs11h_openssl_session_getX5=
09
- return x509=3D0x2503b3a0
Wed Jan  3 17:53:39 2018 us=3D603610 PKCS#11:
__pkcs11h_openssl_session_setRSA - entered openssl_session=3D0x2501f0e0,
evp=3D0x2503f500
Wed Jan  3 17:53:39 2018 us=3D603936 PKCS#11:
__pkcs11h_openssl_session_setRSA - return ret=3D1
Wed Jan  3 17:53:39 2018 us=3D604451 PKCS#11: pkcs11h_openssl_session_getEVP
- return ret=3D0x2503f500
Wed Jan  3 17:53:39 2018 us=3D604675 PKCS#11: pkcs11h_openssl_session_getX5=
09
- entry openssl_session=3D0x2501f0e0
Wed Jan  3 17:53:39 2018 us=3D606373 PKCS#11: pkcs11h_openssl_session_getX5=
09
- return x509=3D0x2503b3a0
Wed Jan  3 17:53:39 2018 us=3D606982 PKCS#11: pkcs11h_openssl_freeSession -
entry openssl_session=3D0x2501f0e0, count=3D2
Wed Jan  3 17:53:39 2018 us=3D607204 PKCS#11: pkcs11h_openssl_freeSession -
return
Wed Jan  3 17:53:39 2018 us=3D607419 PKCS#11:
pkcs11h_certificate_freeCertificateId entry certificate_id=3D0x2501d9d0
Wed Jan  3 17:53:39 2018 us=3D941247 PKCS#11: pkcs11h_token_freeTokenId ent=
ry
certificate_id=3D0x2501de30
Wed Jan  3 17:53:39 2018 us=3D941584 PKCS#11: pkcs11h_token_freeTokenId ret=
urn
Wed Jan  3 17:53:39 2018 us=3D941791 PKCS#11:
pkcs11h_certificate_freeCertificateId return
Wed Jan  3 17:53:39 2018 us=3D953836 Outgoing Control Channel Authenticatio=
n:
Using 256 bit message hash 'SHA256' for HMAC authentication
Wed Jan  3 17:53:39 2018 us=3D954201 Incoming Control Channel Authenticatio=
n:
Using 256 bit message hash 'SHA256' for HMAC authentication
Wed Jan  3 17:53:39 2018 us=3D954428 crypto_adjust_frame_parameters:
Adjusting frame parameters for crypto by 40 bytes
Wed Jan  3 17:53:39 2018 us=3D954712 LZO compression initializing
Wed Jan  3 17:53:39 2018 us=3D956154 Control Channel MTU parms [ L:1624
D:1170 EF:80 EB:0 ET:0 EL:3 ]
Wed Jan  3 17:53:39 2018 us=3D956821 Data Channel MTU parms [ L:1624 D:1450
EF:124 EB:406 ET:0 EL:3 ]
Wed Jan  3 17:53:39 2018 us=3D957295 crypto_adjust_frame_parameters:
Adjusting frame parameters for crypto by 68 bytes
Wed Jan  3 17:53:39 2018 us=3D957517 calc_options_string_link_mtu: link-mtu
1624 -> 1572
Wed Jan  3 17:53:39 2018 us=3D957867 crypto_adjust_frame_parameters:
Adjusting frame parameters for crypto by 68 bytes
Wed Jan  3 17:53:39 2018 us=3D958188 calc_options_string_link_mtu: link-mtu
1624 -> 1572
Wed Jan  3 17:53:39 2018 us=3D958537 Local Options String (VER=3DV4):
'V4,dev-type tun,link-mtu 1572,tun-mtu 1500,proto
TCPv4_CLIENT,comp-lzo,keydir 1,cipher AES-256-CBC,auth SHA256,keysize
256,tls-auth,key-method 2,tls-client'
Wed Jan  3 17:53:39 2018 us=3D958753 Expected Remote Options String (VER=3D=
V4):
'V4,dev-type tun,link-mtu 1572,tun-mtu 1500,proto
TCPv4_SERVER,comp-lzo,keydir 0,cipher AES-256-CBC,auth SHA256,keysize
256,tls-auth,key-method 2,tls-server'
Wed Jan  3 17:53:39 2018 us=3D959174 TCP/UDP: Preserving recently used remo=
te
address: [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443
Wed Jan  3 17:53:39 2018 us=3D959666 Socket Buffers: R=3D[87380->87380]
S=3D[16384->16384]
Wed Jan  3 17:53:39 2018 us=3D959952 Attempting to establish TCP connection
with [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 [nonblock]
Wed Jan  3 17:53:40 2018 us=3D961428 TCP: connect to
[AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 failed: Connection refused
Wed Jan  3 17:53:40 2018 us=3D962721 SIGTERM[connection
failed(soft),init_instance] received, process exiting
Wed Jan  3 17:53:40 2018 us=3D964538 PKCS#11: pkcs11h_terminate entry
Wed Jan  3 17:53:40 2018 us=3D964779 PKCS#11: Terminating openssl
Wed Jan  3 17:53:40 2018 us=3D964979 PKCS#11: _pkcs11h_openssl_terminate
Wed Jan  3 17:53:40 2018 us=3D965557 PKCS#11: Removing providers
Wed Jan  3 17:53:40 2018 us=3D965792 PKCS#11: pkcs11h_removeProvider entry
reference=3D'/usr/lib/libtpm2-pk11.so'
Wed Jan  3 17:53:40 2018 us=3D965990 PKCS#11: Removing provider
'/usr/lib/libtpm2-pk11.so'
---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Finalize
Wed Jan  3 17:53:40 2018 us=3D966236 PKCS#11: _pkcs11h_slotevent_notify ent=
ry
Wed Jan  3 17:53:40 2018 us=3D966424 PKCS#11: _pkcs11h_slotevent_notify ret=
urn
Wed Jan  3 17:53:40 2018 us=3D968218 PKCS#11: pkcs11h_removeProvider return
rv=3D0-'CKR_OK'
Wed Jan  3 17:53:40 2018 us=3D968463 PKCS#11: Releasing sessions
Wed Jan  3 17:53:40 2018 us=3D968654 PKCS#11: Warning: Found session with
references
Wed Jan  3 17:53:40 2018 us=3D968852 PKCS#11: pkcs11h_token_freeTokenId ent=
ry
certificate_id=3D0x2501ec30
Wed Jan  3 17:53:40 2018 us=3D969138 PKCS#11: pkcs11h_token_freeTokenId ret=
urn
Wed Jan  3 17:53:40 2018 us=3D969380 PKCS#11:
pkcs11h_certificate_freeCertificateIdList entry cert_id_list=3D(nil)
Wed Jan  3 17:53:40 2018 us=3D969569 PKCS#11:
pkcs11h_certificate_freeCertificateIdList return
Wed Jan  3 17:53:40 2018 us=3D969795 PKCS#11: Terminating slotevent
Wed Jan  3 17:53:40 2018 us=3D969977 PKCS#11: _pkcs11h_slotevent_terminate
entry
Wed Jan  3 17:53:40 2018 us=3D970154 PKCS#11: _pkcs11h_slotevent_terminate
return
Wed Jan  3 17:53:40 2018 us=3D970327 PKCS#11: Marking as uninitialized



Unfortunately, there is no RSA-related log, so I cannot check what openvpn
is doing with the certificate it found - so at this point, I'm a bit
confused.



>
> Hope this helps,
>


=E2=80=8BI can confirm that it does ; it helped me to undertand the PKCS#11=
 ids a
bit more :)=E2=80=8B



> -Steffan
>
>
=E2=80=8BBest regards,

-- Emmanuel Deloget=E2=80=8B

--001a113e5a9c14423a0561e257a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello Steffan,=C2=A0</div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Mon, Jan 1, 2018 at 4:36 PM, Steffan Karger <span =
dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">ste=
ffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Hi,<br>
<span><br>
On 01-01-18 14:57, Emmanuel Deloget wrote:<br>
&gt; I&#39;m trying to get openvpn read my certificates from a TPM2 using a=
<br>
&gt; specially crafted PKCS#11 provider (the existing tpm2-pk11 is quite<br>
&gt; limited for now but I might be able to extend it).=C2=A0<br>
&gt;<br>
&gt; However, the PKCS#11 API is not something I&#39;m comfortable with, an=
d I&#39;d<br>
&gt; like to know if there is some document (design or anything, really) th=
at<br>
&gt; could help me to understand what openvpn wants exactly in order for me=
<br>
&gt; to provide the missing bits. I&#39;ve read the documents at [1] but fo=
und<br>
&gt; nothing here of interest (for me).=C2=A0<br>
&gt;<br>
&gt; So, does someone have any pointer?<br>
<br>
</span>You&#39;re right that OpenVPN&#39;s pkcs11 options lack some high-le=
vel<br>
documentation.=C2=A0 Maybe I can shed some light on the basics (probably<br>
taking a step further back than you need).<br>
<br>
First, you need some shared object (.so, .dll) that provides the<br>
interface specified by the PKCS11 standard.=C2=A0 OpenVPN will load that<br>
module, and call its functions to provide private key operations.=C2=A0 Tha=
t<br>
shared object is usually provided by your smartcard vendor.=C2=A0 That shar=
ed<br>
object takes care of communication with the underlying key store (smart<br>
card, tpm, hsm, ...).=C2=A0 The openvpn manpage calls this a pkcs11 &#39;pr=
ovider&#39;.<br>
<br>
$ openvpn --show-pkcs11-ids<br>
/usr/lib/x86_64-linux-gnu/pkcs<wbr>11/gnome-keyring-pkcs11.so<br>
<br>
The following objects are available for use.<br>
Each object shown below may be used as parameter to<br>
--pkcs11-id option please remember to use single quote mark.<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">=E2=80=8BI seen that while testing. =E2=80=8B</div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Certificate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0DN:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest-Client,<br>
emailAddress=3Dme@...2371...<wbr>n<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Serial:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A002<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Serialized id:<br>
Gnome\x20Keyring/1\x2E0/1\x3AU<wbr>SER\x3ADEFAULT/Gnome2\x20Key\x<wbr>20Sto=
rage/1A9D824585217F1BD546<wbr>03E83F042F570A2EE9F2<br>
<br>
(I have the openvpn client testkey in my local gnome keyring, to easily<br>
test pkcs11 without a hardware token.)<br>
<br>
From that list, you pick the object you want to use, and specify the<br>
provider and id in your config file.=C2=A0 In this case:<br>
<br>
pkcs11-providers &quot;/usr/lib/x86_64-linux-gnu/pkc<wbr>s11/gnome-keyring-=
pkcs11.so&quot;<br>
pkcs11-id<br>
&quot;Gnome\\x20Keyring/1\\x2E0/1\\<wbr>x3AUSER\\x3ADEFAULT/Gnome2\\x2<wbr>=
0Key\\x20Storage/1B3B2BEBF3657<wbr>6443D3A903AFA8997221B93FCC1&quot;<br>
<br>
You specify this *instead* of the regular &#39;key&#39; and &#39;cert&#39; =
options.<br>
Note that you&#39;ll need toe escape backslashes.<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">=E2=80=8BGood to know :)=E2=80=8B</div><br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
You should now be able to use pkcs11 for the private key operations.<br>
<br>
Since each keystore behaves differently, I did not specify how to get<br>
the private key in there.=C2=A0 But I guess your TPM vendor providers tooli=
ng<br>
for that.<br></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-family:monospace,monospace">Well, TPM2 is a keystore, so that=
 should work :)</div><div class=3D"gmail_default" style=3D"font-family:mono=
space,monospace"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace">I am able to store the certificate in the TPM2 nvram=
 (as a DER file) and I have a corresponding RSA private key (also in the TP=
M2, in the persistent object area).</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace">The PKCS11 provider I&#39;m usin=
g (tpm2-pk11) has been modified to get the certificate from the TPM2, but I=
 don&#39;t know how to tell openvpn to use the corresponding key on the TPM=
2 (and to use the TPM2_RSA_encrypt/RSA_decrypt functions).=C2=A0</div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">I&#=
39;m not sure what&#39;s missing here (probably something on my side, eithe=
r some config or some code here and there). Here are the PKCS#11 ids and my=
 current configuration:</div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace"><br></div></div></div></div><blockquote style=3D"m=
argin:0 0 0 40px;border:none;padding:0px"><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace">root@...2370... ~# openvpn --show-pkcs11-ids</div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default" style=3D"font-family:arial,sans-serif"><font face=3D"mon=
ospace, monospace"><br></font></div></div></div></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,sans-serif"><font face=3D"monospace, monospace">The following obj=
ects are available for use.</font></div></div></div></div><div class=3D"gma=
il_extra"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace"><div class=3D"gmail_default" style=3D"font=
-family:arial,sans-serif"><font face=3D"monospace, monospace">Each object s=
hown below may be used as parameter to</font></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"gmail_default=
" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default" st=
yle=3D"font-family:arial,sans-serif"><font face=3D"monospace, monospace">--=
pkcs11-id option please remember to use single quote mark.</font></div></di=
v></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default" style=3D"font-family:arial,sans-serif"><font face=3D"mon=
ospace, monospace"><br></font></div></div></div></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,sans-serif"><font face=3D"monospace, monospace">Certificate</font=
></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
<div class=3D"gmail_default" style=3D"font-family:arial,sans-serif"><font f=
ace=3D"monospace, monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0DN:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C=3DFR, O=3DME, OU=3DUnit, CN=3D005043361=
C24</font></div></div></div></div><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif=
"><font face=3D"monospace, monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0Serial:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CFC3AC7FC37F777CF509506BC8EA0A94E9FBDC121686=
FEBEACEF99AC474ED21D</font></div></div></div></div><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace"><div class=3D"gmail_default" style=3D"font-family=
:arial,sans-serif"><font face=3D"monospace, monospace">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0Serialized id:=C2=A0 ME/TPM2/00000000/nvram/01800008</font></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default" style=3D"font-family:arial,sans-serif"><font face=3D"mon=
ospace, monospace"><br></font></div></div></div></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,sans-serif"><font face=3D"monospace, monospace">Certificate</font=
></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
<div class=3D"gmail_default" style=3D"font-family:arial,sans-serif"><font f=
ace=3D"monospace, monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0DN:=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C=3DUS, O=3DME, OU=3DUnit, CN=3D006060584=
526</font></div></div></div></div><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif=
"><font face=3D"monospace, monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0Serial:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0266B18A3534E3179</font></div></div></div></d=
iv><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_de=
fault" style=3D"font-family:arial,sans-serif"><font face=3D"monospace, mono=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0Serialized id:=C2=A0 ME/TPM2/00000000/nvr=
am/01800004</font></div></div></div></div></blockquote><div class=3D"gmail_=
extra"><div class=3D"gmail_quote"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><div><font face=3D"monospace, monospace"><br>=
</font></div><div><font face=3D"monospace, monospace"><br></font></div><div=
><font face=3D"monospace, monospace"><br></font></div><div><font face=3D"mo=
nospace, monospace"><br></font></div><div><font face=3D"monospace, monospac=
e"><br></font></div></div></div></div><blockquote style=3D"margin:0px 0px 0=
px 40px;border:none;padding:0px"><div class=3D"gmail_extra"><div class=3D"g=
mail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_default">=
<font face=3D"monospace, monospace">client</font></div></div></div></div></=
div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospace, mo=
nospace"># -- yeah, this is not the real server :)</font></div></div></div>=
</div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div=
 class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospa=
ce, monospace">remote <a href=3D"http://openvpn.example.com" target=3D"_bla=
nk">openvpn.example.com</a></font></div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t"><div class=3D"gmail_default"><font face=3D"monospace, monospace">port 44=
3</font></div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_defa=
ult"><font face=3D"monospace, monospace">dev tun</font></div></div></div></=
div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div c=
lass=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospace=
, monospace">persist-key</font></div></div></div></div></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><=
div class=3D"gmail_default"><font face=3D"monospace, monospace">persist-tun=
</font></div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_defa=
ult"><font face=3D"monospace, monospace">proto tcp6-client</font></div></di=
v></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><=
div><div class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D=
"monospace, monospace">tun-mtu 1500</font></div></div></div></div></div><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail=
_default"><div class=3D"gmail_default"><font face=3D"monospace, monospace">=
auth SHA256</font></div></div></div></div></div><div class=3D"gmail_extra">=
<div class=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"=
gmail_default"><font face=3D"monospace, monospace">connect-retry-max 3</fon=
t></div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_default"><=
font face=3D"monospace, monospace">remap-usr1 SIGTERM</font></div></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><=
div class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"mono=
space, monospace"><br></font></div></div></div></div></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><di=
v class=3D"gmail_default"><font face=3D"monospace, monospace">remote-cert-t=
ls server</font></div></div></div></div></div><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gm=
ail_default"><font face=3D"monospace, monospace">tls-client</font></div></d=
iv></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<div><div class=3D"gmail_default"><div class=3D"gmail_default"><font face=
=3D"monospace, monospace">ca /etc/PKI/CA.pem</font></div></div></div></div>=
</div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospace, mo=
nospace">tls-auth /etc/PKI/TA.ta 1</font></div></div></div></div></div><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_=
default"><div class=3D"gmail_default"><font face=3D"monospace, monospace">c=
ipher AES-256-CBC</font></div></div></div></div></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><div cla=
ss=3D"gmail_default"><font face=3D"monospace, monospace">script-security 2<=
/font></div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_defa=
ult"><font face=3D"monospace, monospace">pkcs11-providers &quot;/usr/lib/li=
btpm2-pk11.so&quot;</font></div></div></div></div></div></blockquote><block=
quote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t"><div class=3D"gmail_default"><font face=3D"monospace, monospace"># -- in=
 DER format</font></div></div></div></div></div></blockquote><blockquote st=
yle=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><div class=3D"gmail=
_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><div c=
lass=3D"gmail_default"><font face=3D"monospace, monospace">pkcs11-id &quot;=
ME/TPM2/00000000/nvram/<wbr>01800008&quot;</font></div></div></div></div></=
div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospace, mo=
nospace"><br></font></div></div></div></div></div><div class=3D"gmail_extra=
"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=
=3D"gmail_default"><font face=3D"monospace, monospace"># ------------------=
-- previous key configuration ----------------------</font></div></div></di=
v></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><d=
iv class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monos=
pace, monospace"># -- same as ME/TPM2/00000000/nvram/<wbr>01800008</font></=
div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><div><div class=3D"gmail_default"><div class=3D"gmail_default"><font=
 face=3D"monospace, monospace"># cert /etc/PKI/client.pem</font></div></div=
></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><div class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"=
monospace, monospace"># -- also in the TPM2, but how to tell that to openvp=
n?</font></div></div></div></div></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_def=
ault"><font face=3D"monospace, monospace"># key /etc/PKI/client.key</font><=
/div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><div><div class=3D"gmail_default"><div class=3D"gmail_default"><fon=
t face=3D"monospace, monospace"><br></font></div></div></div></div></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmai=
l_default"><div class=3D"gmail_default"><font face=3D"monospace, monospace"=
>up /etc/openvpn/start.sh</font></div></div></div></div></div><div class=3D=
"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default">=
<div class=3D"gmail_default"><font face=3D"monospace, monospace">down /etc/=
openvpn/stop.sh</font></div></div></div></div></div><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=
=3D"gmail_default"><font face=3D"monospace, monospace"><br></font></div></d=
iv></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<div><div class=3D"gmail_default"><div class=3D"gmail_default"><font face=
=3D"monospace, monospace">comp-lzo</font></div></div></div></div></div><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_=
default"><div class=3D"gmail_default"><font face=3D"monospace, monospace">v=
erb 11</font></div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default"><div class=3D"gmail=
_default"><font face=3D"monospace, monospace"><br></font></div></div></div>=
</div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div=
 class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"monospa=
ce, monospace">float</font></div></div></div></div></div></blockquote><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_d=
efault"><div style=3D"font-family:monospace,monospace"><br></div></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">In=
 my understanding, and within a context of dual authentication (server iden=
tifies client, client identifies server), I should see the following set of=
 operation:=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">* fetch the certificate</div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace">* initiate communication =
and so some RSA magic</div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace">* everything&#39;s ok? continue</div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace,monospace">Of course, I =
might be wrong. What I see is (with some printf within the PKCS#11 provider=
, you can ignore them but they give you an idea of what happens)</div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div=
></div></div></div><blockquote style=3D"margin:0px 0px 0px 40px;border:none=
;padding:0px"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><d=
iv class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div c=
lass=3D"gmail_default">root@...2370... ~# openvpn --config /etc/openvpn/cli=
ent.conf</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 201=
8 us=3D413562 OpenVPN 2.4.0 aarch64-openwrt-linux-gnu [SSL (OpenSSL)] [LZO]=
 [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD]</div></div></div></div></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_de=
fault">Wed Jan=C2=A0 3 17:53:38 2018 us=3D413603 library versions: OpenSSL =
1.0.2k=C2=A0 26 Jan 2017, LZO 2.09</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:38 2018 us=3D413773 PKCS#11: Adding PKCS#11 provider &=
#39;/usr/lib/libtpm2-pk11.so&#39;</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:38 2018 us=3D413812 PKCS#11: pkcs11h_addProvider entry=
 version=3D&#39;1.22&#39;, pid=3D27700, reference=3D&#39;/usr/lib/libtpm2-p=
k11.so&#39;, provider_location=3D&#39;/usr/lib/libtpm2-pk11.so&#39;, allow_=
protected_auth=3D0, mask_private_mode=3D00000000, cert_is_private=3D0</div>=
</div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D413832 =
PKCS#11: Adding provider &#39;/usr/lib/libtpm2-pk11.so&#39;-&#39;/usr/lib/l=
ibtpm2-pk11.so&#39;</div></div></div></div></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default">---- IMPL | tpm2-=
pk11-e4589948e8/src/pk11.c:C_GetFunctionList</div></div></div></div></div><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_d=
efault">---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Initialize</div></div=
></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><=
div class=3D"gmail_default">---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_G=
etInfo</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 201=
8 us=3D423143 PKCS#11: pkcs11h_addProvider Provider &#39;/usr/lib/libtpm2-p=
k11.so&#39; manufacturerID &#39;ME&#39;</div></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defaul=
t">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423182 PKCS#11: _pkcs11h_slotevent_no=
tify entry</div></div></div></div></div><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2=
018 us=3D423197 PKCS#11: _pkcs11h_slotevent_notify return</div></div></div>=
</div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div cla=
ss=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423216 PKCS#11: Pro=
vider &#39;/usr/lib/libtpm2-pk11.so&#39; added rv=3D0-&#39;CKR_OK&#39;</div=
></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monosp=
ace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423230=
 PKCS#11: pkcs11h_addProvider return rv=3D0-&#39;CKR_OK&#39;</div></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div =
class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423263 NOTE: the=
 current --script-security setting may allow this configuration to call use=
r-defined scripts</div></div></div></div></div><div class=3D"gmail_extra"><=
div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:=
53:38 2018 us=3D423733 PKCS#11: pkcs11h_certificate_deserializeCertificateI=
d entry p_certificate_id=3D0x7ffeb0a098, sz=3D&#39;ME/TPM2/00000000/nvram/0=
1800008&#39;</div></div></div></div></div><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38=
 2018 us=3D423760 PKCS#11: _pkcs11h_certificate_newCertificateId entry p_ce=
rtificate_id=3D0x7ffeb0a050</div></div></div></div></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:38 2018 us=3D423776 PKCS#11: _pkcs11h_certificate_newCertifi=
cateId return rv=3D0-&#39;CKR_OK&#39;, *p_certificate_id=3D0x2501d9d0</div>=
</div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423798 =
PKCS#11: pkcs11h_token_deserializeTokenId entry p_token_id=3D0x2501d9d0, sz=
=3D&#39;ME/TPM2/00000000/nvram&#39;</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:38 2018 us=3D423813 PKCS#11: _pkcs11h_token_newTokenId=
 entry p_token_id=3D0x7ffeb09fb8</div></div></div></div></div><div class=3D=
"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" =
style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed =
Jan=C2=A0 3 17:53:38 2018 us=3D423833 PKCS#11: _pkcs11h_token_newTokenId re=
turn rv=3D0-&#39;CKR_OK&#39;, *p_token_id=3D0x2501de30</div></div></div></d=
iv></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423854 PKCS#11: pkcs1=
1h_token_deserializeTokenId return rv=3D0-&#39;CKR_OK&#39;</div></div></div=
></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><di=
v class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div cl=
ass=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423881 PKCS#11: pk=
cs11h_certificate_deserializeCertificateId return rv=3D0-&#39;CKR_OK&#39;</=
div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423=
899 PKCS#11: pkcs11h_certificate_create entry certificate_id=3D0x2501d9d0, =
user_data=3D(nil), mask_prompt=3D00000003, pin_cache_period=3D-1, p_certifi=
cate=3D0x7ffeb0a0a0</div></div></div></div></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 1=
7:53:38 2018 us=3D423918 PKCS#11: pkcs11h_certificate_duplicateCertificateI=
d entry to=3D0x2501e2a0 form=3D0x2501d9d0</div></div></div></div></div><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defa=
ult">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423934 PKCS#11: pkcs11h_certificate=
_duplicateCertificateId return rv=3D0-&#39;CKR_OK&#39;, *to=3D0x2501e310</d=
iv></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D4239=
48 PKCS#11: _pkcs11h_session_getSessionByTokenId entry token_id=3D0x2501e74=
0, p_session=3D0x2501e2b0</div></div></div></div></div><div class=3D"gmail_=
extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:38 2018 us=3D423961 PKCS#11: Creating a new session</div></d=
iv></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D423976 PKC=
S#11: pkcs11h_token_duplicateTokenId entry to=3D0x2501ebc8 form=3D0x2501e74=
0</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gma=
il_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D=
423994 PKCS#11: pkcs11h_token_duplicateTokenId return rv=3D0-&#39;CKR_OK&#3=
9;, *to=3D0x2501ec30</div></div></div></div></div><div class=3D"gmail_extra=
"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 =
17:53:38 2018 us=3D424008 PKCS#11: _pkcs11h_session_getSessionByTokenId ret=
urn rv=3D0-&#39;CKR_OK&#39;, *p_session=3D0x2501ebb0</div></div></div></div=
></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D=
"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D424021 PKCS#11: pkcs11h_=
certificate_create return rv=3D0-&#39;CKR_OK&#39; *p_certificate=3D0x2501e2=
a0</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace=
,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=
=3D424036 PKCS#11: pkcs11h_openssl_createSession - entry</div></div></div><=
/div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div clas=
s=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D424086 PKCS#11: pkcs=
11h_openssl_createSession - return openssl_session=3D0x2501f0e0</div></div>=
</div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><d=
iv class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D424101 PKCS#1=
1: pkcs11h_openssl_session_getEVP - entry openssl_session=3D0x2501f0e0</div=
></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monosp=
ace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D424117=
 PKCS#11: pkcs11h_openssl_session_getX509 - entry openssl_session=3D0x2501f=
0e0</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"g=
mail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=
=3D424132 PKCS#11: pkcs11h_openssl_getX509 - entry certificate=3D0x2501e2a0=
</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D7=
58314 PKCS#11: pkcs11h_certificate_getCertificateBlob entry certificate=3D0=
x2501e2a0, certificate_blob=3D(nil), *p_certificate_blob_size=3D00000000000=
00000</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 u=
s=3D758608 PKCS#11: __pkcs11h_certificate_loadCertificate entry certificate=
=3D0x2501e2a0</div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:3=
8 2018 us=3D758805 PKCS#11: _pkcs11h_session_validate entry session=3D0x250=
1ebb0</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 u=
s=3D758996 PKCS#11: _pkcs11h_session_validate return rv=3D179-&#39;CKR_SESS=
ION_HANDLE_INVALID&#39;</div></div></div></div></div><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0=
 3 17:53:38 2018 us=3D759184 PKCS#11: __pkcs11h_certificate_loadCertificate=
 return rv=3D179-&#39;CKR_SESSION_HANDLE_INVALID&#39;</div></div></div></di=
v></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D759416 PKCS#11: _pkcs=
11h_certificate_resetSession entry certificate=3D0x2501e2a0, public_only=3D=
1, session_mutex_locked=3D0</div></div></div></div></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:38 2018 us=3D759629 PKCS#11: _pkcs11h_session_login entry se=
ssion=3D0x2501ebb0, is_publicOnly=3D1, readonly=3D1, user_data=3D(nil), mas=
k_prompt=3D00000003</div></div></div></div></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 1=
7:53:38 2018 us=3D759812 PKCS#11: _pkcs11h_session_logout entry session=3D0=
x2501ebb0</div></div></div></div></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 20=
18 us=3D759985 PKCS#11: _pkcs11h_session_logout return</div></div></div></d=
iv></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D760175 PKCS#11: _pkcs=
11h_session_reset entry session=3D0x2501ebb0, user_data=3D(nil), mask_promp=
t=3D00000003, p_slot=3D0x7ffeb09a28</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:38 2018 us=3D760363 PKCS#11: _pkcs11h_session_reset Ex=
pected token manufacturerID=3D&#39;ME&#39; model=3D&#39;TPM2&#39;, serialNu=
mber=3D&#39;00000000&#39;, label=3D&#39;nvram&#39;</div></div></div></div><=
/div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"=
gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D760554 PKCS#11: _pkcs11h_=
session_getSlotList entry provider=3D0x250093c0, token_present=3D1, pSlotLi=
st=3D0x7ffeb098c8, pulCount=3D0x7ffeb098d0</div></div></div></div></div><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_def=
ault">---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetSlotList</div></div>=
</div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><d=
iv class=3D"gmail_default">---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_Ge=
tSlotList</div></div></div></div></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 20=
18 us=3D760880 PKCS#11: _pkcs11h_session_getSlotList return rv=3D0-&#39;CKR=
_OK&#39; *pulCount=3D1</div></div></div></div></div><div class=3D"gmail_ext=
ra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace,monospace"><div class=3D"gmail_default">---- IMPL | tp=
m2-pk11-e4589948e8/src/pk11.c:C_GetTokenInfo</div></div></div></div></div><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_d=
efault">Wed Jan=C2=A0 3 17:53:38 2018 us=3D761228 PKCS#11: _pkcs11h_token_g=
etTokenId entry p_token_id=3D0x7ffeb098d8</div></div></div></div></div><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defa=
ult">Wed Jan=C2=A0 3 17:53:38 2018 us=3D761422 PKCS#11: _pkcs11h_token_newT=
okenId entry p_token_id=3D0x7ffeb09818</div></div></div></div></div><div cl=
ass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default=
">Wed Jan=C2=A0 3 17:53:38 2018 us=3D761615 PKCS#11: _pkcs11h_token_newToke=
nId return rv=3D0-&#39;CKR_OK&#39;, *p_token_id=3D0x2501f5d0</div></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div =
class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D761811 PKCS#11: =
_pkcs11h_token_getTokenId return rv=3D0-&#39;CKR_OK&#39;, *p_token_id=3D0x2=
501f5d0</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 201=
8 us=3D761995 PKCS#11: _pkcs11h_session_reset Found token manufacturerID=3D=
&#39;ME&#39; model=3D&#39;TPM2&#39;, serialNumber=3D&#39;00000000&#39;, lab=
el=3D&#39;nvram&#39;</div></div></div></div></div><div class=3D"gmail_extra=
"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 =
17:53:38 2018 us=3D762296 PKCS#11: pkcs11h_token_freeTokenId entry certific=
ate_id=3D0x2501f5d0</div></div></div></div></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 1=
7:53:38 2018 us=3D762474 PKCS#11: pkcs11h_token_freeTokenId return</div></d=
iv></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:38 2018 us=3D762656 PKC=
S#11: _pkcs11h_session_reset return rv=3D0-&#39;CKR_OK&#39;, *p_slot=3D4660=
</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk11-e4589948e8/src=
/pk11.c:C_OpenSession</div></div></div></div></div><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace"><div class=3D"gmail_default">---- OBJS | tpm=
2-pk11-e4589948e8/src/objects.c:object_load</div></div></div></div></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_de=
fault">---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list</div></div></div=
></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><di=
v class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div cl=
ass=3D"gmail_default">---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_readpu=
blic [H =3D 0x81010001]</div></div></div></div></div><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace"><div class=3D"gmail_default">---- TPM2 | t=
pm2-pk11-e4589948e8/src/tpm.c:tpm_readpublic [H =3D 0x81010002]</div></div>=
</div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><d=
iv class=3D"gmail_default">---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_n=
vlist<br></div></div></div></div></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><div class=3D"gmail_default">++++ ++++ | nvlist.count =
=3D 4</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D=
"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace"><div class=3D"gmail_default">++++ ++++ | loading nvram index=
 =3D 01800004</div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace"><div class=3D"gmail_default">---- CERT | tpm2-pk11-e=
4589948e8/src/certificate.c:certificate_read_from_tpm [index =3D 01800004]<=
/div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><div class=3D"gmail_default">---- TPM2 | tpm2-pk11-e4589948e8/src/=
tpm.c:tpm_nvread [index =3D 01800004]</div></div></div></div></div><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default"=
>---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvreadpublic [index =3D 018=
00004]</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">++++ ++++ | added object 0x2=
503cbd0, certificate 0x2503ccb8<br></div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">+=
+++ ++++ | loading nvram index =3D 01800008</div></div></div></div></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_de=
fault">---- CERT | tpm2-pk11-e4589948e8/src/certificate.c:certificate_read_=
from_tpm [index =3D 01800008]</div></div></div></div></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace"><div class=3D"gmail_default">---- TP=
M2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_nvread [index =3D 01800008]</div></=
div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
"><div class=3D"gmail_default">---- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:t=
pm_nvreadpublic [index =3D 01800008]</div></div></div></div></div><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">=
++++ ++++ | added object 0x2503c2c0, certificate 0x2503d568<br></div></div>=
</div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><d=
iv class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D209982 PKCS#1=
1: _pkcs11h_session_login return rv=3D0-&#39;CKR_OK&#39;</div></div></div><=
/div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div clas=
s=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D210058 PKCS#11: _pkc=
s11h_certificate_resetSession return rv=3D0-&#39;CKR_OK&#39;</div></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div =
class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D210106 PKCS#11: =
__pkcs11h_certificate_loadCertificate entry certificate=3D0x2501e2a0</div><=
/div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D210150 P=
KCS#11: _pkcs11h_session_validate entry session=3D0x2501ebb0</div></div></d=
iv></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div =
class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D210194 PKCS#11: =
_pkcs11h_session_validate session-&gt;pin_expire_time=3D0, time=3D151499841=
9</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gma=
il_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D=
210237 PKCS#11: _pkcs11h_session_validate return rv=3D0-&#39;CKR_OK&#39;</d=
iv></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D2102=
82 PKCS#11: _pkcs11h_session_findObjects entry session=3D0x2501ebb0, filter=
=3D0x7ffeb09f30, filter_attrs=3D2, p_objects=3D0x7ffeb09f08, p_objects_foun=
d=3D0x7ffeb09f10</div></div></div></div></div><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk1=
1-e4589948e8/src/pk11.c:C_FindObjectsInit [filters&lt;2&gt; =3D 0x7ffeb09f3=
0]</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace=
,monospace"><div class=3D"gmail_default">++++ ++++ | filter[0].type =3D 0x0=
0000000</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">++++ ++++ | filter[1].type =
=3D 0x00000102</div></div></div></div></div><div class=3D"gmail_extra"><div=
 class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk11-=
e4589948e8/src/pk11.c:C_FindObjects</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">-=
--- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list</div></div></div></div><=
/div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"=
gmail_default">++++ ++++ | object =3D 0x2503c2c0, handle =3D 38632038<br></=
div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><div class=3D"gmail_default">++++ ++++ | &gt;&gt; type =3D 00000000=
 =3D CKA_CLASS, value =3D 00000001 =3D CKO_CERTIFICATE (expected 00000001 =
=3D CKO_CERTIFICATE)</div></div></div></div></div><div class=3D"gmail_extra=
"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace"><div class=3D"gmail_default">++++ ++++ | &gt;=
&gt; type =3D 00000102 =3D CKA_ID, value =3D 08008001</div></div></div></di=
v></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div cla=
ss=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=
=3D"gmail_default">++++ ++++ | filtered =3D no</div></div></div></div></div=
><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail=
_default">++++ ++++ | object =3D 0x2503cbd0, handle =3D 30382031</div></div=
></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><=
div class=3D"gmail_default">++++ ++++ | &gt;&gt; type =3D 00000000 =3D CKA_=
CLASS, value =3D 00000001 =3D CKO_CERTIFICATE (expected 00000001 =3D CKO_CE=
RTIFICATE)</div></div></div></div></div><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><div class=3D"gmail_default">++++ ++++ | &gt;&gt; type =
=3D 00000102 =3D CKA_ID, value =3D 04008001</div></div></div></div></div><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmai=
l_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_de=
fault">++++ ++++ | filtered =3D yes</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">+=
+++ ++++ | object =3D 0x2503be30, handle =3D 00000000<br></div></div></div>=
</div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div cla=
ss=3D"gmail_default">++++ ++++ | &gt;&gt; type =3D 00000000 =3D CKA_CLASS, =
value =3D 00000002 =3D CKO_PUBLIC_KEY (expected 00000001 =3D CKO_CERTIFICAT=
E)</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace=
,monospace"><div class=3D"gmail_default">++++ ++++ | filtered =3D yes</div>=
</div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce"><div class=3D"gmail_default">++++ ++++ | object =3D 0x2503b7e0, handle =
=3D 81010002</div></div></div></div></div><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace"><div class=3D"gmail_default">++++ ++++ | &gt;&gt; typ=
e =3D 00000000 =3D CKA_CLASS, value =3D 00000003 =3D CKO_PRIVATE_KEY (expec=
ted 00000001 =3D CKO_CERTIFICATE)</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">+=
+++ ++++ | filtered =3D yes</div></div></div></div></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">++++ ++++=
 | object =3D 0x2503b850, handle =3D 00000000</div></div></div></div></div>=
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_=
default">++++ ++++ | &gt;&gt; type =3D 00000000 =3D CKA_CLASS, value =3D 00=
000002 =3D CKO_PUBLIC_KEY (expected 00000001 =3D CKO_CERTIFICATE)</div></di=
v></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><=
div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
<div class=3D"gmail_default">++++ ++++ | filtered =3D yes</div></div></div>=
</div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div cla=
ss=3D"gmail_default">++++ ++++ | object =3D 0x25038960, handle =3D 81010001=
</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><div class=3D"gmail_default">++++ ++++ | &gt;&gt; type =3D 000000=
00 =3D CKA_CLASS, value =3D 00000003 =3D CKO_PRIVATE_KEY (expected 00000001=
 =3D CKO_CERTIFICATE)</div></div></div></div></div><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace"><div class=3D"gmail_default">++++ ++++ | fil=
tered =3D yes</div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk11-e=
4589948e8/src/pk11.c:C_FindObjects</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">-=
--- TPM2 | tpm2-pk11-e4589948e8/src/tpm.c:tpm_list</div></div></div></div><=
/div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"=
gmail_default">---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_FindObjectsFin=
al</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gm=
ail_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace=
,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=
=3D593596 PKCS#11: _pkcs11h_session_findObjects return rv=3D0-&#39;CKR_OK&#=
39;, *p_objects_found=3D1</div></div></div></div></div><div class=3D"gmail_=
extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:39 2018 us=3D593900 PKCS#11: _pkcs11h_session_getObjectAttri=
butes entry session=3D0x2501ebb0, object=3D621003456, attrs=3D0x7ffeb09f18,=
 count=3D1</div></div></div></div></div><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk11-e458=
9948e8/src/pk11.c:C_GetAttributeValue</div></div></div></div></div><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default"=
>---- IMPL | tpm2-pk11-e4589948e8/src/pk11.c:C_GetAttributeValue</div></div=
></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><=
div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D595105 PKCS#=
11: _pkcs11h_session_getObjectAttributes return rv=3D0-&#39;CKR_OK&#39;</di=
v></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D59533=
3 PKCS#11: _pkcs11h_certificate_isBetterCertificate entry current=3D(nil), =
current_size=3D0000000000000000, newone=3D0x2503dd70, newone_size=3D0000000=
0000006f9</div></div></div></div></div><div class=3D"gmail_extra"><div clas=
s=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mo=
nospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 20=
18 us=3D595538 PKCS#11: _pkcs11h_certificate_isBetterCertificate return is_=
better=3D1</div></div></div></div></div><div class=3D"gmail_extra"><div cla=
ss=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2=
018 us=3D595750 PKCS#11: _pkcs11h_session_freeObjectAttributes entry attrs=
=3D0x7ffeb09f18, count=3D1</div></div></div></div></div><div class=3D"gmail=
_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:39 2018 us=3D595943 PKCS#11: _pkcs11h_session_freeObjectAttr=
ibutes return</div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:3=
9 2018 us=3D596137 PKCS#11: __pkcs11h_certificate_updateCertificateIdDescri=
ption entry certificate_id=3D0x2501e310</div></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defaul=
t">Wed Jan=C2=A0 3 17:53:39 2018 us=3D598698 PKCS#11: __pkcs11h_certificate=
_updateCertificateIdDescription return displayName=3D&#39;/C=3DFR/O=3DME/OU=
=3DUnit/CN=3D005043361C24 on nvram&#39;</div></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defaul=
t">Wed Jan=C2=A0 3 17:53:39 2018 us=3D599056 PKCS#11: __pkcs11h_certificate=
_loadCertificate return rv=3D0-&#39;CKR_OK&#39;</div></div></div></div></di=
v><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"gmai=
l_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D599287 PKCS#11: pkcs11h_certi=
ficate_getCertificateBlob return rv=3D0-&#39;CKR_OK&#39;</div></div></div><=
/div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><div clas=
s=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D599501 PKCS#11: pkcs=
11h_certificate_getCertificateBlob entry certificate=3D0x2501e2a0, certific=
ate_blob=3D0x2503dd70, *p_certificate_blob_size=3D00000000000006f9</div></d=
iv></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D599706 PKC=
S#11: pkcs11h_certificate_getCertificateBlob return rv=3D0-&#39;CKR_OK&#39;=
</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D6=
01366 PKCS#11: pkcs11h_openssl_getX509 - return rv=3D0-&#39;CKR_OK&#39;, x5=
09=3D0x2501f140</div></div></div></div></div><div class=3D"gmail_extra"><di=
v class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53=
:39 2018 us=3D603117 PKCS#11: pkcs11h_openssl_session_getX509 - return x509=
=3D0x2503b3a0</div></div></div></div></div><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-famil=
y:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:3=
9 2018 us=3D603610 PKCS#11: __pkcs11h_openssl_session_setRSA - entered open=
ssl_session=3D0x2501f0e0, evp=3D0x2503f500</div></div></div></div></div><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_def=
ault">Wed Jan=C2=A0 3 17:53:39 2018 us=3D603936 PKCS#11: __pkcs11h_openssl_=
session_setRSA - return ret=3D1</div></div></div></div></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed J=
an=C2=A0 3 17:53:39 2018 us=3D604451 PKCS#11: pkcs11h_openssl_session_getEV=
P - return ret=3D0x2503f500</div></div></div></div></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:39 2018 us=3D604675 PKCS#11: pkcs11h_openssl_session_getX509=
 - entry openssl_session=3D0x2501f0e0</div></div></div></div></div><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default"=
>Wed Jan=C2=A0 3 17:53:39 2018 us=3D606373 PKCS#11: pkcs11h_openssl_session=
_getX509 - return x509=3D0x2503b3a0</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:39 2018 us=3D606982 PKCS#11: pkcs11h_openssl_freeSessi=
on - entry openssl_session=3D0x2501f0e0, count=3D2</div></div></div></div><=
/div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"=
gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D607204 PKCS#11: pkcs11h_o=
penssl_freeSession - return</div></div></div></div></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:39 2018 us=3D607419 PKCS#11: pkcs11h_certificate_freeCertifi=
cateId entry certificate_id=3D0x2501d9d0</div></div></div></div></div><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defau=
lt">Wed Jan=C2=A0 3 17:53:39 2018 us=3D941247 PKCS#11: pkcs11h_token_freeTo=
kenId entry certificate_id=3D0x2501de30</div></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defaul=
t">Wed Jan=C2=A0 3 17:53:39 2018 us=3D941584 PKCS#11: pkcs11h_token_freeTok=
enId return</div></div></div></div></div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 =
2018 us=3D941791 PKCS#11: pkcs11h_certificate_freeCertificateId return</div=
></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monosp=
ace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D953836=
 Outgoing Control Channel Authentication: Using 256 bit message hash &#39;S=
HA256&#39; for HMAC authentication</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:39 2018 us=3D954201 Incoming Control Channel Authentic=
ation: Using 256 bit message hash &#39;SHA256&#39; for HMAC authentication<=
/div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D95=
4428 crypto_adjust_frame_parameters: Adjusting frame parameters for crypto =
by 40 bytes</div></div></div></div></div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 =
2018 us=3D954712 LZO compression initializing</div></div></div></div></div>=
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_=
default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D956154 Control Channel MTU parm=
s [ L:1624 D:1170 EF:80 EB:0 ET:0 EL:3 ]</div></div></div></div></div><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defau=
lt">Wed Jan=C2=A0 3 17:53:39 2018 us=3D956821 Data Channel MTU parms [ L:16=
24 D:1450 EF:124 EB:406 ET:0 EL:3 ]</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:39 2018 us=3D957295 crypto_adjust_frame_parameters: Ad=
justing frame parameters for crypto by 68 bytes</div></div></div></div></di=
v><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"gmai=
l_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D957517 calc_options_string_li=
nk_mtu: link-mtu 1624 -&gt; 1572</div></div></div></div></div><div class=3D=
"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" =
style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed =
Jan=C2=A0 3 17:53:39 2018 us=3D957867 crypto_adjust_frame_parameters: Adjus=
ting frame parameters for crypto by 68 bytes</div></div></div></div></div><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_d=
efault">Wed Jan=C2=A0 3 17:53:39 2018 us=3D958188 calc_options_string_link_=
mtu: link-mtu 1624 -&gt; 1572</div></div></div></div></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:39 2018 us=3D958537 Local Options String (VER=3DV4): &#39;V4=
,dev-type tun,link-mtu 1572,tun-mtu 1500,proto TCPv4_CLIENT,comp-lzo,keydir=
 1,cipher AES-256-CBC,auth SHA256,keysize 256,tls-auth,key-method 2,tls-cli=
ent&#39;</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 201=
8 us=3D958753 Expected Remote Options String (VER=3DV4): &#39;V4,dev-type t=
un,link-mtu 1572,tun-mtu 1500,proto TCPv4_SERVER,comp-lzo,keydir 0,cipher A=
ES-256-CBC,auth SHA256,keysize 256,tls-auth,key-method 2,tls-server&#39;</d=
iv></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:39 2018 us=3D9591=
74 TCP/UDP: Preserving recently used remote address: [AF_INET6]2a01:240:190=
6:1:0:1850:6118:4075:443</div></div></div></div></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D=
"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=
=A0 3 17:53:39 2018 us=3D959666 Socket Buffers: R=3D[87380-&gt;87380] S=3D[=
16384-&gt;16384]</div></div></div></div></div><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:5=
3:39 2018 us=3D959952 Attempting to establish TCP connection with [AF_INET6=
]2a01:240:1906:1:0:1850:6118:4075:443 [nonblock]</div></div></div></div></d=
iv><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace"><div class=3D"gma=
il_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D961428 TCP: connect to [AF_I=
NET6]2a01:240:1906:1:0:1850:6118:4075:443 failed: Connection refused</div><=
/div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D962721 S=
IGTERM[connection failed(soft),init_instance] received, process exiting</di=
v></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D96453=
8 PKCS#11: pkcs11h_terminate entry</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:40 2018 us=3D964779 PKCS#11: Terminating openssl</div>=
</div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D964979 =
PKCS#11: _pkcs11h_openssl_terminate</div></div></div></div></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defaul=
t" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">W=
ed Jan=C2=A0 3 17:53:40 2018 us=3D965557 PKCS#11: Removing providers</div><=
/div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D965792 P=
KCS#11: pkcs11h_removeProvider entry reference=3D&#39;/usr/lib/libtpm2-pk11=
.so&#39;</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 201=
8 us=3D965990 PKCS#11: Removing provider &#39;/usr/lib/libtpm2-pk11.so&#39;=
</div></div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><div class=3D"gmail_default">---- IMPL | tpm2-pk11-e4589948e8/src=
/pk11.c:C_Finalize</div></div></div></div></div><div class=3D"gmail_extra">=
<div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17=
:53:40 2018 us=3D966236 PKCS#11: _pkcs11h_slotevent_notify entry</div></div=
></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><d=
iv><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><=
div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D966424 PKCS#=
11: _pkcs11h_slotevent_notify return</div></div></div></div></div><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_defau=
lt" style=3D"font-family:monospace,monospace"><div class=3D"gmail_default">=
Wed Jan=C2=A0 3 17:53:40 2018 us=3D968218 PKCS#11: pkcs11h_removeProvider r=
eturn rv=3D0-&#39;CKR_OK&#39;</div></div></div></div></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=
=C2=A0 3 17:53:40 2018 us=3D968463 PKCS#11: Releasing sessions</div></div><=
/div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><di=
v class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D968654 PKCS#11=
: Warning: Found session with references</div></div></div></div></div><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defau=
lt">Wed Jan=C2=A0 3 17:53:40 2018 us=3D968852 PKCS#11: pkcs11h_token_freeTo=
kenId entry certificate_id=3D0x2501ec30</div></div></div></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><div class=3D"gmail_defaul=
t">Wed Jan=C2=A0 3 17:53:40 2018 us=3D969138 PKCS#11: pkcs11h_token_freeTok=
enId return</div></div></div></div></div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 =
2018 us=3D969380 PKCS#11: pkcs11h_certificate_freeCertificateIdList entry c=
ert_id_list=3D(nil)</div></div></div></div></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 1=
7:53:40 2018 us=3D969569 PKCS#11: pkcs11h_certificate_freeCertificateIdList=
 return</div></div></div></div></div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 201=
8 us=3D969795 PKCS#11: Terminating slotevent</div></div></div></div></div><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace"><div class=3D"gmail_d=
efault">Wed Jan=C2=A0 3 17:53:40 2018 us=3D969977 PKCS#11: _pkcs11h_sloteve=
nt_terminate entry</div></div></div></div></div><div class=3D"gmail_extra">=
<div class=3D"gmail_quote"><div><div class=3D"gmail_default" style=3D"font-=
family:monospace,monospace"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17=
:53:40 2018 us=3D970154 PKCS#11: _pkcs11h_slotevent_terminate return</div><=
/div></div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e"><div class=3D"gmail_default">Wed Jan=C2=A0 3 17:53:40 2018 us=3D970327 P=
KCS#11: Marking as uninitialized</div></div></div></div></div></blockquote>=
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace"><br></div></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></di=
v><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">Un=
fortunately, there is no RSA-related log, so I cannot check what openvpn is=
 doing with the certificate it found - so at this point, I&#39;m a bit conf=
used.</div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space"><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Hope this helps,<br></blockquote><div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:monospace,monospace">=E2=80=8BI can confi=
rm that it does ; it helped me to undertand the PKCS#11 ids a bit more :)=
=E2=80=8B</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
-Steffan<br><br></blockquote><div><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace,monospace">=E2=80=8BBest regards,=C2=A0</div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br><=
/div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
>-- Emmanuel Deloget=E2=80=8B</div></div><br></div></div>

--001a113e5a9c14423a0561e257a6--

