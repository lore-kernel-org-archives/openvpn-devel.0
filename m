From: Simon Rozman <simon@...2293...>
Date: Wed, 30 Oct 2019 15:30:44 +0000
Message-ID: <0CC5CC49-B907-40F3-B52E-55AC5A19CCB6@...2293...>
References: <1571304533-15614-1-git-send-email-lstipakov@...277...>
 <1571315023-17044-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1571315023-17044-1-git-send-email-lstipakov@...277...>
Content-Language: en-GB
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha256; boundary="B_3655297844_1571064579"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: OpenSSL 1.1.x support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--B_3655297844_1571064579
Content-type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Unfortunately, I have no Visual Studio 2017 available any more. So, I had t=
o upgrade the openvpn-build and openvpn to build with VS2019 first.

Tested with OpenSSL 1.1.1d and this patch is indeed required to build openv=
pn.exe.

Acked-by: Simon Rozman <simon@...2293...>

Best regards,
Simon

=EF=BB=BFOn 17.10.2019, 14:27, "Lev Stipakov" <lstipakov@...277...> wrote:

    Since we release Windows client with OpenSSL 1.1.0
    (and will switch to 1.1.1 in the next release),
    it makes sense to use a newer version in VS build.
=20=20=20=20
    This patch adds msvc-specific defines which imply
    that underlying OpenSSL is 1.1.x (works with 1.1.0 and 1.1.1).
=20=20=20=20
    Also OpenSSL library names in project file are updated.
=20=20=20=20
    Signed-off-by: Lev Stipakov <lstipakov@...277...>
    ---
=20=20=20=20
    v2: clarify in comment and commit message that
        this supports 1.1.x, which is 1.1.0 and 1.1.1.
=20=20=20=20
=20=20=20=20
     config-msvc.h               | 37 +++++++++++++++++++++++++++++++++++++
     src/openvpn/openvpn.vcxproj |  8 ++++----
     2 files changed, 41 insertions(+), 4 deletions(-)
=20=20=20=20
    diff --git a/config-msvc.h b/config-msvc.h
    index 45fae8b..875da4a 100644
    --- a/config-msvc.h
    +++ b/config-msvc.h
    @@ -76,6 +76,43 @@
     #define HAVE_POLL 1
=20=20=20=20=20
     #define HAVE_OPENSSL_ENGINE 1
    +/* hardcode usage of OpenSSL 1.1.x */
    +#define HAVE_EVP_MD_CTX_RESET 1
    +#define HAVE_EVP_MD_CTX_FREE 1
    +#define HAVE_EVP_MD_CTX_NEW 1
    +#define HAVE_HMAC_CTX_RESET 1
    +#define HAVE_HMAC_CTX_FREE 1
    +#define HAVE_HMAC_CTX_NEW 1
    +#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA 1
    +#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB 1
    +#define HAVE_X509_GET0_PUBKEY 1
    +#define HAVE_X509_STORE_GET0_OBJECTS 1
    +#define HAVE_X509_OBJECT_FREE 1
    +#define HAVE_X509_OBJECT_GET_TYPE 1
    +#define HAVE_EVP_PKEY_GET0_RSA 1
    +#define HAVE_EVP_PKEY_GET0_EC_KEY 1
    +#define HAVE_EVP_PKEY_ID 1
    +#define HAVE_EVP_PKEY_GET0_DSA 1
    +#define HAVE_RSA_SET_FLAGS 1
    +#define HAVE_RSA_GET0_KEY 1
    +#define HAVE_RSA_SET0_KEY 1
    +#define HAVE_RSA_BITS 1
    +#define HAVE_DSA_GET0_PQG 1
    +#define HAVE_DSA_BITS 1
    +#define HAVE_RSA_METH_NEW 1
    +#define HAVE_RSA_METH_FREE 1
    +#define HAVE_RSA_METH_SET_PUB_ENC 1
    +#define HAVE_RSA_METH_SET_PUB_DEC 1
    +#define HAVE_RSA_METH_SET_PRIV_ENC 1
    +#define HAVE_RSA_METH_SET_PRIV_DEC 1
    +#define HAVE_RSA_METH_SET_INIT 1
    +#define HAVE_RSA_METH_SET_SIGN 1
    +#define HAVE_RSA_METH_SET_FINISH 1
    +#define HAVE_RSA_METH_SET0_APP_DATA 1
    +#define HAVE_RSA_METH_GET0_APP_DATA 1
    +#define HAVE_EC_GROUP_ORDER_BITS 1
    +#define OPENSSL_NO_EC 1
    +#define HAVE_EVP_CIPHER_CTX_RESET 1
=20=20=20=20=20
     #define PATH_SEPARATOR     '\\'
     #define PATH_SEPARATOR_STR "\\"
    diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
    index 3b0ee60..4ffff2b 100644
    --- a/src/openvpn/openvpn.vcxproj
    +++ b/src/openvpn/openvpn.vcxproj
    @@ -78,7 +78,7 @@
         </ClCompile>
         <ResourceCompile />
         <Link>
    -      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.l=
ib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%=
(AdditionalDependencies)</AdditionalDependencies>
    +      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.li=
b;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(=
AdditionalDependencies)</AdditionalDependencies>
           <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/li=
b;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
           <SubSystem>Console</SubSystem>
         </Link>
    @@ -91,7 +91,7 @@
         </ClCompile>
         <ResourceCompile />
         <Link>
    -      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.l=
ib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%=
(AdditionalDependencies)</AdditionalDependencies>
    +      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.li=
b;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(=
AdditionalDependencies)</AdditionalDependencies>
           <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/li=
b;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
           <SubSystem>Console</SubSystem>
         </Link>
    @@ -104,7 +104,7 @@
         </ClCompile>
         <ResourceCompile />
         <Link>
    -      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.l=
ib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%=
(AdditionalDependencies)</AdditionalDependencies>
    +      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.li=
b;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(=
AdditionalDependencies)</AdditionalDependencies>
           <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/li=
b;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
           <SubSystem>Console</SubSystem>
         </Link>
    @@ -117,7 +117,7 @@
         </ClCompile>
         <ResourceCompile />
         <Link>
    -      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.l=
ib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%=
(AdditionalDependencies)</AdditionalDependencies>
    +      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;=
libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.li=
b;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(=
AdditionalDependencies)</AdditionalDependencies>
           <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/li=
b;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDir=
ectories>
           <SubSystem>Console</SubSystem>
         </Link>
    --=20
    2.7.4
=20=20=20=20
=20=20=20=20
=20=20=20=20
    _______________________________________________
    Openvpn-devel mailing list
    Openvpn-devel@lists.sourceforge.net
    https://lists.sourceforge.net/lists/listinfo/openvpn-devel
=20=20=20=20

--B_3655297844_1571064579
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIILkQYJKoZIhvcNAQcCoIILgjCCC34CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggl6MIIFWTCCBEGgAwIBAgIEO0oNLjANBgkqhkiG9w0BAQUFADA9MQswCQYDVQQGEwJz
aTEbMBkGA1UEChMSc3RhdGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTAeFw0x
NjAyMTkxNzU0NDFaFw0yMTAyMTkyMTM4MTVaMIGAMQswCQYDVQQGEwJTSTEbMBkGA1UEChMS
c3RhdGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTEUMBIGA1UECxMLaW5kaXZp
ZHVhbHMxKzATBgNVBAMTDFNpbW9uIFJvem1hbjAUBgNVBAUTDTIzNDU2Nzk1MTIwNDIwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD+LEVulmN6fPkadqe82V8M1xrQ52BYGDka
xqVw/tEwalpKEiMR6DO8VfCpkjj1Ka5JEoU21Srm1MFg6Tkot9b8ykHAGEWGakBRBSgJGBBQ
AqiO8knjtQuohXSAFeUWjLMfA3mOZG8rJbGrCyg39Fmm1jeezWYuB/7s2xrqK7Stc/GzIheq
sYE0Pw1FhqtECA52JuzoItOX368d31tN/O1ynkH7F0TXy48GFncmq5Yid3d3QVOk1qQC68lo
ILwSSkLA5xOV6mHz/XlAAb/jfNLfsIyxT1RO4+rPlOulTYVex/bfxlbKGXN4qfK/o84TFqXW
1dbDUK7jS9PzMxthWpTfAgMBAAGjggIbMIICFzAOBgNVHQ8BAf8EBAMCBaAwSwYDVR0gBEQw
QjA2BgsrBgEEAa9ZAgIDAzAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9j
cHMvMAgGBgQAizABAjAYBggrBgEFBQcBAwQMMAowCAYGBACORgEBMBoGA1UdEQQTMBGBD3Np
bW9uQHJvem1hbi5zaTCB7gYDVR0fBIHmMIHjMFagVKBSpFAwTjELMAkGA1UEBhMCc2kxGzAZ
BgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2lnZW4tY2ExDzANBgNVBAMT
BkNSTDQ1NTCBiKCBhaCBgoZXbGRhcDovL3g1MDAuZ292LnNpL291PXNpZ2VuLWNhLG89c3Rh
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

--B_3655297844_1571064579--

