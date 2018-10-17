MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
In-Reply-To: <20181007215837.489-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Oct 2018 23:15:02 -0400
Message-ID: <CAKuzo_gpYNnLaBdaKwiUGsRbRJL0BnNceBUq37NPBughb8qKFw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for OpenSSL TLS 1.3 when
 using management-external-key
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Not a review, but some thoughts:

On Sun, Oct 7, 2018 at 5:59 PM Arne Schwabe <arne@...1227...> wrote:
>
> For TLS 1.0 to 1.2 OpenSSL calls us and requires a PKCS1 padded
> response, for TLS 1.3 it requires to an unpadded response. Since we
> can PCKS1 pad an unpadded response, we prefer to always query for
> an unpadded response from the management interface and add the PCKS1
> padding ourselves when needed.


First, one clarification:

The reason for unpadded response is that when PSS padding is in use,
OpenSSL adds the padding and, thus, asks for raw RSA encryption
(unpadded). This is because RSA_sign or rsa_priv_enc callbacks
do not support a way of indicating PSS padding. In fact, OpenSSL
1.1.1 client talking to 1.1.1 server prefers PSS padding even for
TLS 1.2, so this is not a TLS 1.3-only problem.

>
> This patch adds an 'unpadded' parameter to the management-external-key
> option to signal that it is uses the new unpadded API. Since we cannot

I do not particularly like this new option:
"management-external-key-unpadded". Apart from the confusing name,
this doesn't really address the basic limitation of the current
pkey-sig (old rsa-sig) directive. We should have extended it when the
new name was introduced. pkey-sig should pass not just the data (or
hash) to sign but additional info like digest type in use, padding
mode etc. Or have a way for the management client to query additional
parameters that may be necessary for signing.

Using padded data and requiring the external "engine" to do a raw
signature may look like a way out of this but not really: not all external
libraries may support such a usage. AFAICS, Windows CNG does not. Also
some hardware devices may insist on doing the padding inside --
especially non-deterministic padding like PSS.

So what about naming this "management-external-key-version2" and then
extend pk-sig as below?

pk-sig <base64-data-to-sign> [signing-algorithm]

where the <signing algorithm> could be, say, SHA256_RSA_PKCS1 or
NONE_RSA_PKCS1 or SHA384_RSA_PSS etc. If missing, and the key
is RSA, the client can assume it is NONE_RSA_PKCS1 and expect the hash
with digest-info header already added and sign as such. Or, if the key
is EC, do the ECDSA signing operation as is being done now.

The "unpadded" case could be indicated by NONE_RSA_RAW. These
mnemonics are just examples -- we could use PKCS11 identifiers or something
else.

To get unpadded data we have to override sign() in EVP_PKEY_METHOD but
that would also provide max flexibility.

Now, I think its safe to just update and document this and require that
management-interface clients that use the external key feature must
update if using client compiled with OpenSSL 1.1.1. Android(?) and iOS (?)
clients may be the only one's affected, but those are shipped as one complete
package. I'm not aware of any standalone management-client UI that uses
the external-key feature.

> support TLS 1.3 without unpadded queries we disable TLS 1.3 otherwise.

If we must do this, disabling TLS 1.3 will not enough. One way is to
also explicitly set the padding mode to RSA_PKCS1_PADDING (for TLS1.2)

EVP_PKEY_CTX_set_rsa_padding(ctx, pad) can do this.

>
> We also do the same for cryptoapi since it uses the same API.

Let's just fix cryptoapi --- I'm working on it. Anyway it does
not use the same API as external key and prepadded data (= nopadding)
will not work with Windows. This'll have to be fixed before we release binaries
linked with OpenSSL 1.1.1.

>
> Using the management api client version instead might seem like the
> more logical way but since we only now that version very late,
> it would extra logic and complexity to deal with this asynchronous
> behaviour .

IMO, we should explore this further and try to avoid
--management-external-key-foo.

Selva

