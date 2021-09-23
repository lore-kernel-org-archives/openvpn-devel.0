References: <20210922211254.7570-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a7c18fd1-7c90-c353-8506-e6ccb36282e6@...1227...>
Date: Thu, 23 Sep 2021 22:21:55 +0200
MIME-Version: 1.0
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 22.09.21 um 23:12 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> The following series of patches implement a built-in
> provider for interfacing OpenSSL 3.0 when external 
> keys are in use.
> 
> Essentially, to intercept the sign operation, the SSL_CTX
> object has to be created with properties string set to 
> prioritize our provider. In the provider we implement
> only keymgmt and signature operations and specify the
> property string as optional. That allows all operations
> we do not provide to be used from the default provider.
> 
> This patch set stops at interfacing the provider with
> management-external-key. For pkcs11-helper, only some glue
> code is needed and is in the works. Same with cryptoapicert
>  aka CNG, but I want to cleanup the old code a bit before
> hooking to the provider.

I did a quick test with my Android client to see if it works and RSA
keys look good so far. I am getting a request like:

NC9t8IkYrjAQcCzc85zN0H5TvwfAUDwYkR4j2ga6fGw=,RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest

from the management interface. But I haven't found the right Signature
method from java yet to actually sign it correctly:

sig = Signature.getInstance(SHA256withRSA/PSS);
sig.setParameter(new PSSParameterSpec("SHA-256", "MGF1",
MGF1ParameterSpec.SHA256, 32, 1));
sig.initSign(privkey);
sig.update(data);
signed_bytes = sig.sign();

is what I expected to be the correct signature but the server complains
with OpenSSL: error:0407E068:rsa routines:RSA_verify_PKCS1_PSS_mgf1:bad
signature

I will have to figure out where this goes wrong.

With an EC key somewhere in that stack, EC/RSA gets confuse as there is
rsa_keymgmt_import/rsa_keymgmt_name in the stack and then later
ec_keymgmt_name. I haven't digged into that as it is getting late here.


2021-09-23 22:19:56 TLS: Initial packet from
[AF_INET]192.168.188.61:1194, sid=7c606dcc fe241304
2021-09-23 22:19:56 In xkey provider query op with op = 4
2021-09-23 22:19:56 In xkey provider query op with op = 3
2021-09-23 22:19:56 In xkey provider query op with op = 10
2021-09-23 22:19:56 In xkey provider query op with op = 21
2021-09-23 22:19:56 VERIFY OK: depth=0, CN=dionysos
2021-09-23 22:19:56 In keymgmt_new
2021-09-23 22:19:56 In keydata_new
2021-09-23 22:19:56 In rsa_keymgmt_import
2021-09-23 22:19:56 In keymgmt_import
2021-09-23 22:19:56 In rsa_keymgmt_name
2021-09-23 22:19:56 In xkey signature_newctx
2021-09-23 22:19:56 In xkey digest_verify init with mdname <SHA2-256>
2021-09-23 22:19:56 In xkey digest_init_helper with mdname = <SHA2-256>
2021-09-23 22:19:56 In xkey signature_settable_ctx_params
2021-09-23 22:19:56 In signature_set_ctx_params
2021-09-23 22:19:56 xkey_sign_parameters: setting padmode to <pss>
2021-09-23 22:19:56 In xkey signature_settable_ctx_params
2021-09-23 22:19:56 In signature_set_ctx_params
2021-09-23 22:19:56 xkey_sign_parameters: setting saltlen to digest
2021-09-23 22:19:56 In xkey digest_verify
2021-09-23 22:19:56 In xkey signature_freectx
2021-09-23 22:19:56 In ec_keymgmt_name
2021-09-23 22:19:56 In xkey provider query op with op = 12
2021-09-23 22:19:56 In ec_keymgmt_name
2021-09-23 22:19:56 In xkey provider query op with op = 12
2021-09-23 22:19:56 In ec_keymgmt_name
2021-09-23 22:19:56 In xkey provider query op with op = 12


RSA for comparison:

2021-09-23 22:17:40 TLS: Initial packet from
[AF_INET]192.168.188.61:1194, sid=0e4a91a6 67f591d2
2021-09-23 22:17:40 In xkey provider query op with op = 4
2021-09-23 22:17:40 In xkey provider query op with op = 3
2021-09-23 22:17:40 In xkey provider query op with op = 10
2021-09-23 22:17:40 In xkey provider query op with op = 21
2021-09-23 22:17:40 VERIFY OK: depth=0, CN=dionysos
2021-09-23 22:17:40 In keymgmt_new
2021-09-23 22:17:40 In keydata_new
2021-09-23 22:17:40 In rsa_keymgmt_import
2021-09-23 22:17:40 In keymgmt_import
2021-09-23 22:17:40 In rsa_keymgmt_name
2021-09-23 22:17:40 In xkey signature_newctx
2021-09-23 22:17:40 In xkey digest_verify init with mdname <SHA2-256>
2021-09-23 22:17:40 In xkey digest_init_helper with mdname = <SHA2-256>
2021-09-23 22:17:40 In xkey signature_settable_ctx_params
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 xkey_sign_parameters: setting padmode to <pss>
2021-09-23 22:17:40 In xkey signature_settable_ctx_params
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 xkey_sign_parameters: setting saltlen to digest
2021-09-23 22:17:40 In xkey digest_verify
2021-09-23 22:17:40 In xkey signature_freectx
2021-09-23 22:17:40 In rsa_keymgmt_name
2021-09-23 22:17:40 In xkey signature_newctx
2021-09-23 22:17:40 In xkey digest_sign_init with mdname = SHA256>
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 In xkey signature_freectx
2021-09-23 22:17:40 In rsa_keymgmt_name
2021-09-23 22:17:40 In xkey signature_newctx
2021-09-23 22:17:40 In xkey digest_sign_init with mdname = SHA2-256>
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 In xkey signature_settable_ctx_params
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 xkey_sign_parameters: setting padmode to <pss>
2021-09-23 22:17:40 In xkey signature_settable_ctx_params
2021-09-23 22:17:40 In signature_set_ctx_params
2021-09-23 22:17:40 xkey_sign_parameters: setting saltlen to digest
2021-09-23 22:17:40 In xkey digest_sign
2021-09-23 22:17:40 In xkey digest_sign
2021-09-23 22:17:40 In xkey signature_sign with siglen = 256
2021-09-23 22:17:40 P:
2021-09-23 22:17:40 xkey management_sign: requesting sig with algorithm
<RSA_PKCS1_PSS_PADDING,hashalg=SHA256,saltlen=digest>
2021-09-23 22:17:40 MANAGEMENT: CMD 'pk-sig'
2021-09-23 22:17:40 In xkey signature_freectx

