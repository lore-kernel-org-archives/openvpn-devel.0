References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-9-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56BB3775.5010801@...1227...>
Date: Wed, 10 Feb 2016 14:13:25 +0100
MIME-Version: 1.0
In-Reply-To: <1454874438-5081-9-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 08/10] Add AEAD cipher support (GCM)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Overall the code looks good and works well in my tests. A few remarks
(but ACK otherwise):

> AC_ARG_ENABLE(
>     [aead-modes],
>     [AS_HELP_STRING([--disable-aead-modes], [disable AEAD crypto modes
> @<:@default=3Dyes@:>@])],
>     ,
>     [enable_aead_modes=3D"yes"]
> )

I would not make this user configurable. If it wasn't for RHEL5 I even
would throw out 0.9.8 support and always compile it in.


     {
+      /* Get the key we will use to encrypt the packet. */
       tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &co);
+      /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer-id =
to the
+       * packet before openvpn_encrypt(), so we can authenticate the opcod=
e too.
+       */
+      if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.tls_m=
ulti->use_peer_id)

The latter part of that if might be turned into a small inline fuction
to make it clearer. Or alternatively a local boolean variable to be used
in both if places.


>   /* Prepare IV */
>   {
>     struct buffer iv_buffer;
>     struct packet_id_net pin;
>     const int iv_len =3D cipher_ctx_iv_length (ctx->cipher);
>
>     ASSERT (iv_len >=3D 12 && iv_len <=3D OPENVPN_MAX_IV_LENGTH);
A comment about the 12 would be nice here. (=3D> 96 bits ....)

>     /* set_tag() call required for older OpenSSL versions only */
What does older mean in this context? Add an idef or atleast specify the
version in the file.

>     const int ad_size =3D BPTR (buf) - ad_start - tag_size;

ad_size can be 0. Did you check what hte PolarSSL/OpenSSL function do on
a 0 byte call?


Also add for the manpage:

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6b97fc9..30faff3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3991,6 +3991,10 @@ Set
 .B alg=3Dnone
 to disable authentication.
=20
+If a AEAD
+.B \-\-cipher
+is selected like AES-128-GCM is used the authentication of that cipher
is used for the data channel packets.
+
 For more information on HMAC see
 .I http://www.cs.ucsd.edu/users/mihir/papers/hmac.html
 .\"*********************************************************

Arne




