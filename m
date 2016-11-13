From: Arne Schwabe <arne@...1227...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-3-git-send-email-steffan.karger@...1435...>
Message-ID: <e5e524cb-1b41-2dab-8204-a4e0f49334c7@...1227...>
Date: Sun, 13 Nov 2016 11:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <1478636302-9678-3-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Add control channel encryption
 (--tls-crypt)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net


> This boils down to the following on-the-wire packet format:
> 
>    -opcode- || -session_id- || -packet_id- || auth_tag || * payload *

I am pretty that opcode is *not* authenticated looking the code. Which
is probably not a problem but should not be documented as authenticated.
(There is a buf_advance(buf ,1) before calling the unwrap function.

>    Where
>    - XXX - means authenticated, and
>    * XXX * means authenticated and encrypted.

This misalignes the rest of the packet. I am not sure how big the
penality actually is but we have DATA_V2 and COMP_V2 fix this
misalignment. But then again ignore my comment for control channel traffic.

For the packet format I think it would be very good to add a key id to
help transisition or allow more paranoid people to have a a key per
client. In the server you would specify all allowed valid keys together
with their ids (or somehow emded that id/read that id from keyfile). Not
that saying that this should be implement in the first version of the
patch but something that we can implement later without having a
tls-crypt and a tls-crypt v2 packet format.
> 
> Which is very similar to the current tls-auth packet format, and has the
> same overhead as "--tls-auth" with "--auth SHA256".
> 
> The use of a nonce misuse-resistant authenticated encryption scheme
> allows us to worry less about the risks of nonce collisions.  This is
> important, because in contrast with the data channel in TLS mode, we
> will not be able to rotate tls-crypt keys often or fully guarantee nonce
> uniqueness.  For non misuse-resistant modes such as GCM [1], [2], the
> data channel in TLS mode only has to ensure that the packet counter
> never rolls over, while tls-crypt would have to provide nonce uniqueness
> over all control channel packets sent by all clients, for the lifetime
> of the tls-crypt key.
> 
> Unlike with tls-auth, no --key-direction has to be specified for
> tls-crypt.  TLS servers always use key direction 1, and TLS clients
> always use key direction 2, which means that client->server traffic and
> server->client traffic always use different keys, without requiring
> configuration.
> 
> Using fixed, secure, encryption and authentication algorithms makes both
> implementation and configuration easier.  If we ever want to, we can
> extend this to support other crypto primitives.  Since tls-crypt should
> provide privacy as well as DoS protection, these should not be made
> negotiable.
> 
> Security considerations:
> ------------------------
> 
> tls-crypt is a best-effort mechanism that aims to provide as much
> privacy and security as possible, while staying as simple as possible.
> The following are some security considerations for this scheme.
> 
> 1. The same tls-crypt key is potentially shared by a lot of peers, so it
>    is quite likely to get compromised.  Once an attacker acquires the
>    tls-crypt key, this mechanism no longer provides any security against
>    the attacker.
> 
> 2. Since many peers potentially use the tls-crypt key for a long time, a
>    lot of data might be encrypted under the tls-crypt key.  This leads
>    to two potential problems:
> 
>    * The "opcode || session id || packet id" combination might collide.
>      This might happen in larger setups, because the session id contains
>      just 64 bits or random.  Using the uniqueness requirement from the
Typo: of random

>      GCM spec [3] (a collision probability of less than 2^(-32)),
>      uniqueness is achieved when using the tls-crypt key for at most
>      2^16 (65536) connections per process start.  (The packet id
>      includes the daemon start time in the packet ID, which should be
>      different after stopping and (re)starting OpenPVN.)
> 
>      And if a collision happens, an attacker can *only* learn whether
>      colliding packets contain the same plaintext.  Attackers will not
>      be able to learn anything else about the plaintext (unless the
>      attacker knows the plaintext of one of these packets, of course).
>      Since the impact is limited, I consider this an acceptable
>      remaining risk.
> 
>    * The IVs used in encryption might collide.  When two IVs collide, an
>      attacker can learn the xor of the two plaintexts by xorring the
>      ciphertexts.  This is a serious loss of confidentiality.  The IVs
>      are 128-bit, so when HMAC-SHA256 is a secure PRF (an assumption
>      that must also hold for TLS), and we use the same uniqueness
>      requirement from [3], this limits the total amount of control
>      channel messages for all peers in the setup to 2^48.  Assuming a
>      large setup of 2^16 (65536) clients, and a (conservative) number of
>      2^16 control channel packets per connection on average, this means
>      that clients may set up 2^16 connections on average.  I think these
>      numbers are reasonable.
> 
> (I have a follow-up proposal to use client-specific tls-auth/tls-crypt
> keys to partially mitigate these issues, but let's tackle this patch
> first.)

How does the server know which packet Id to use? Part of opcode, e.g.
some bits there or part of the session id.


> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#include "syshead.h"
> +
> +#ifdef ENABLE_CRYPTO
> +#include "crypto.h"
> +#include "session_id.h"
> +
> +#include "tls_crypt.h"
> +
> +int tls_crypt_buf_overhead(void)
> +{
> +  return packet_id_size (true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
> +}
> +
> +void
> +tls_crypt_init_key (struct key_ctx_bi *key, const char *key_file,
> +    const char *key_inline, bool tls_server) {
> +  struct key_type kt;
> +
> +  kt.cipher = cipher_kt_get ("AES-256-CTR");

This can fail, if we are on a weird OpenSSL library. We assert later
(ctx->cipher). I think you should also add an ASSERT/M_FATAL here that
gives gives a clear indication that the crypto library does not support
AES-256-CTR.

> +  kt.cipher_length = cipher_kt_key_size (kt.cipher);
> +  kt.digest = md_kt_get ("SHA256");
Same here.



> +  gc_init (&gc);
> +
> +  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s",
> +      format_hex (BPTR (src), BLEN (src), 80, &gc));
> +
> +  /* Get packet ID */
> +  {
> +    struct packet_id_net pin;
> +    packet_id_alloc_outgoing (&opt->packet_id.send, &pin, true);
> +    packet_id_write (&pin, dst, true, false);
> +  }
> +
> +  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s",
> +      format_hex (BPTR (dst), BLEN (dst), 0, &gc));
> +
> +  /* Buffer overflow check */
> +  if (!buf_safe (dst, BLEN (src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))

This does not take the opcode into account

> +    {
> +      msg (D_CRYPT_ERRORS, "TLS-CRYPT WRAP: buffer size error, "
> +	  "sc=%d so=%d sl=%d dc=%d do=%d dl=%d", src->capacity, src->offset,
> +	  src->len, dst->capacity, dst->offset, dst->len);
> +      goto err;
> +    }
> +
> +  /* Calculate auth tag and synthetic IV */
> +  {
> +    uint8_t *tag = NULL;
> +    hmac_ctx_reset (ctx->hmac);
> +    hmac_ctx_update (ctx->hmac, BPTR (dst), BLEN (dst));
> +    hmac_ctx_update (ctx->hmac, BPTR (src), BLEN (src));
> +
> +    ASSERT (tag = buf_write_alloc (dst, TLS_CRYPT_TAG_SIZE));
> +    hmac_ctx_final (ctx->hmac, tag);
> +
> +    dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP TAG: %s",
> +        format_hex (tag, TLS_CRYPT_TAG_SIZE, 0, &gc));
> +
> +    cipher_ctx_reset (ctx->cipher, tag);
> +  }
> +
> +  /* Encrypt src */
> +  {
> +    int outlen = 0;
> +    ASSERT (cipher_ctx_update (ctx->cipher, BEND (dst), &outlen,
> +	BPTR (src), BLEN(src)));

Indentation is wrong here.

> +    ASSERT (buf_inc_len (dst, outlen));
> +    ASSERT (cipher_ctx_final (ctx->cipher, BPTR (dst), &outlen));
> +    ASSERT (buf_inc_len (dst, outlen));
> +  }
> +
> +  dmsg (D_PACKET_CONTENT, "TLS-CRYPT WRAP TO: %s",
> +      format_hex (BPTR (dst), BLEN (dst), 80, &gc));
> +
> +  gc_free (&gc);
> +  return true;
> +


Otherwise all looks. Note that I have not extensively tested it so far
but more looked on the sourcecode and crypto stuff.

Arne

