References: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
	<9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <8018809a-aa16-32df-4c1a-724926994732@...1435...>
Date: Thu, 27 Oct 2016 16:42:35 +0200
MIME-Version: 1.0
In-Reply-To: <9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VFtCM69tf7q9hr9TC5oHsaoqWPR8B1fIm"
Subject: Re: [Openvpn-devel] [PATCH (master)] Limit --reneg-bytes to 64MB
 when using small block ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--VFtCM69tf7q9hr9TC5oHsaoqWPR8B1fIm
Content-Type: multipart/mixed; boundary="PjbmBbbqTqbAokxw53Bl8rBRGo8n8WOv5";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <8018809a-aa16-32df-4c1a-724926994732@...1435...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Limit --reneg-bytes to 64MB when
	using small block ciphers
References: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
	<9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>
In-Reply-To: <9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>

--PjbmBbbqTqbAokxw53Bl8rBRGo8n8WOv5
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 27-10-16 16:18, David Sommerseth wrote:
> On 26/10/16 17:47, Steffan Karger wrote:
>> Following the earlier warning about small block ciphers, now limit the
>> --reneg-bytes value when using a cipher that susceptible to SWEET32-like
>> attacks.  The 64 MB value has been selected with the researchers who
>> published the SWEET32 paper.
>>
>> Note that this will not change a user-set (non-zero) --reneg-bytes value,
>> to allow a user to override this behaviour if really needed.
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>>  src/openvpn/crypto.c |  5 +++--
>>  src/openvpn/ssl.c    | 24 ++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 45689f2..b40fc7a 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -836,8 +836,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
>>  	  cipher_kt_iv_size(kt->cipher));
>>        if (cipher_kt_block_size(kt->cipher) < 128/8)
>>  	{
>> -	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 bit=
 "
>> -	      "(%d bit).  Consider using a --cipher with a larger block size.",
>> +	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 "
>> +	      "bit (%d bit).  This allows attacks like SWEET32.  Consider "
>> +	      "using a --cipher with a larger block size.",
>>  	      cipher_kt_block_size(kt->cipher)*8);
>>  	}
>>      }
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index dfdc200..2c341a2 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -283,6 +283,24 @@ tls_get_cipher_name_pair (const char * cipher_name,=
 size_t len) {
>>    return NULL;
>>  }
>>=20=20
>> +/**
>> + * Limit the reneg_bytes value when using a small-block (<128 bytes) ci=
pher.
>> + *
>> + * @param cipher	The current cipher (may be NULL).
>> + * @param reneg_bytes	Pointer to the current reneg_bytes, updated if ne=
eded.
>> + * 			May *not* be NULL.
>> + */
>> +static void
>> +tls_limit_reneg_bytes (const cipher_kt_t *cipher, int *reneg_bytes)
>> +{
>> +  if (*reneg_bytes =3D=3D 0 && cipher && (cipher_kt_block_size(cipher) =
< 128/8))
>=20
> Should we also consider if *reneg_bytes > 64*1024*1024 and enforce
> maximum?  This will not allow users to override the 64MB limit, though.
>=20
> Perhaps we should allow reneg_bytes in to be overridden in v2.3 but
> enforce it to max 64MB in v2.4 or v2.5.

I believe we should provide 'sane defaults', but as far as I'm concerned
users may align a gun with their feet if they really want to.

>> +    {
>> +      msg (M_WARN, "WARNING: cipher with small block size in use, "
>> +	   "reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.");
>=20
> Depending on what we do with the >64MB ... this might need to be
> slightly reworded.  If we allow users to override the 64MB default, it
> should probably say:   "... reneg-bytes is set to 64MB ...".  I find
> "reducing" slightly misleading.
>=20
> Also if we decide not to cap at 64MB in this case, we should print
> another warning if --reneg-bytes is > 64MB.  I know this will be
> somewhat annoying to users (imaginary #openvpn question: "I get so many
> warnings now, why!? I want to get rid of them").  My experience is that
> the more warnings we produce, the easier it is to convince users to fix
> the issue rather to ignore them.

We already print the generic warning from init_key_ctx() multiple times
per connection setup (once for data channel encrypt, once for data
channel decrypt).  I think that should be annoying enough ;)

>> +      *reneg_bytes =3D 64 * 1024 * 1024;
>> +    }
>> +}
>> +
>>  /*
>>   * Max number of bytes we will add
>>   * for data structures common to both
>> @@ -1742,6 +1760,8 @@ tls_session_update_crypto_params(struct tls_sessio=
n *session,
>>        msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion fail=
ed");
>>        goto cleanup;
>>      }
>> +  tls_limit_reneg_bytes (session->opt->key_type.cipher,
>> +			 &session->opt->renegotiate_bytes);
>>    ret =3D true;
>>  cleanup:
>>    CLEAR (*ks->key_src);
>> @@ -2126,6 +2146,8 @@ key_method_2_write (struct buffer *buf, struct tls=
_session *session)
>>  	}
>>=20=20=09=09=20=20=20=20=20=20
>>        CLEAR (*ks->key_src);
>> +      tls_limit_reneg_bytes (session->opt->key_type.cipher,
>> +			     &session->opt->renegotiate_bytes);
>>      }
>>=20=20
>>    return true;
>> @@ -2354,6 +2376,8 @@ key_method_2_read (struct buffer *buf, struct tls_=
multi *multi, struct tls_sessi
>>  	}
>>=20=20
>>        CLEAR (*ks->key_src);
>> +      tls_limit_reneg_bytes (session->opt->key_type.cipher,
>> +			     &session->opt->renegotiate_bytes);
>>      }
>=20
> Regarding adding tls_limit_reneg_bytes() in key_method_2_{read,write}()
> ... How often will those functions be called?  Is it once per renegotiati=
on?

Indeed.  This is needed in master because of negotiable crypto
parameters.  We could also do it just once on startup in release/2.3,
but I thought it would be easier to keep 2.4 and 2.3 a bit similar in
this respect.

-Steffan


--PjbmBbbqTqbAokxw53Bl8rBRGo8n8WOv5--

--VFtCM69tf7q9hr9TC5oHsaoqWPR8B1fIm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEhJjAAoJEEEwndWOY1w5YjQIAJRo9qwsQRKCFz8s2BHfmcY5
c22uc8CtWwtu7/J2wK2KkGGQsG/1EzlvTXK17EhliQFizQ9woE8ofUw3NNr6Sh/Z
AReYYuFjVCxa4S1y0zuCW6NO6pyK2iCNUybGe8ESF7Ir1wUXJXb4Vbbr0PGwXB0K
6Xzid1Z7BjNakqxnlZrKTFzhondcnqk/GZGuFLDtdUK6s8c7aEg/Qd98hnDhUx0D
mZ5XcFTRfN6ayk7c+CiB1Ve8aroK7ZkSZ52tx24OwgtpD544ZJeYMuGYHhSYRG0s
j3okNJYTCYTpTTddmD4mjbvIEmadJfEGy3QZJY6I324mpGpQk0y1IqwsazEEpP8=
=37cQ
-----END PGP SIGNATURE-----

--VFtCM69tf7q9hr9TC5oHsaoqWPR8B1fIm--

