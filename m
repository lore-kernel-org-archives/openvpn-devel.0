References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <bcae1150-1258-ff98-112d-b23e8a75d3e8@...1435...>
Date: Thu, 2 Aug 2018 16:15:06 +0200
MIME-Version: 1.0
In-Reply-To: <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GgngW5lc4zxv8BTKM3AXCxDoZhTVxnGZV"
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] Introduce buffer_write_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--GgngW5lc4zxv8BTKM3AXCxDoZhTVxnGZV
Content-Type: multipart/mixed; boundary="066rxLf0SOJj9WDpKjYfmBLxNhFte7LtH";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <bcae1150-1258-ff98-112d-b23e8a75d3e8@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/7] Introduce buffer_write_file()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>
In-Reply-To: <ce36e7e1-ed29-c4fa-4e6b-cff22a2f2d83@...2181...>

--066rxLf0SOJj9WDpKjYfmBLxNhFte7LtH
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review.  Responses inline.

On 02-08-18 11:10, Antonio Quartulli wrote:
> On 26/07/18 00:08, Steffan Karger wrote:
>> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
>> index 0972139..20e2b9c 100644
>> --- a/src/openvpn/buffer.c
>> +++ b/src/openvpn/buffer.c
>> @@ -343,16 +343,33 @@ convert_to_one_line(struct buffer *buf)
>>      }
>>  }
>>=20=20
>> -/* NOTE: requires that string be null terminated */
>> -void
>> -buf_write_string_file(const struct buffer *buf, const char *filename, i=
nt fd)
>> +bool
>> +buffer_write_file(const char *filename, const struct buffer *buf)
>=20
> Since you are removing the old comments from both function declaration
> and definition, why not adding some little doxygen style doc?

In the .h, I added the following doxygen:

+/** Write buffer contents to file */
+bool buffer_write_file(const char *filename, const struct buffer *buf);

I'll expand it to explicitly state the return values, but I don't think
there's much more to say.

> I see you are also changing the way this method works (now it takes only
> the filename instead of a fd), but given that we currently use it only
> once in our code (for now), I think this change is ok and actually makes
> the logic more self-contained (no need for the caller to deal with the
> fd at all).

Yeah, that's the idea :)  I was duplicating the surrounding code and
decided I didn't like that.

>>  {
>> -    const int len =3D strlen((char *) BPTR(buf));
>> -    const int size =3D write(fd, BPTR(buf), len);
>> -    if (size !=3D len)
>> +    bool ret =3D false;
>> +    int fd =3D platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
>> +                           S_IRUSR | S_IWUSR);
>> +    if (fd =3D=3D -1)
>> +    {
>> +        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
>> +        goto cleanup;
>> +    }
>> +
>> +    const int size =3D write(fd, BPTR(buf), BLEN(buf));
>> +    if (size !=3D BLEN(buf))
>>      {
>> -        msg(M_ERR, "Write error on file '%s'", filename);
>> +        msg(M_ERRNO, "Write error on file '%s'", filename);
>> +        goto cleanup;
>> +    }
>> +
>> +    ret =3D true;
>> +cleanup:
>> +    if (close(fd))
>=20
> nitpikcing: I'd dare to say that in the rest of the code we prefer to
> use "func() < 0" as check, to make it more explicit that we are looking
> for errors (my personal feeling is that when i see something like your
> expression I always need to double check "does this function return
> something positive too? what in case of errors?").
>=20
> On top of that consistency is always good :-)

Ok, will change.

>> +    {
>> +        msg(M_ERRNO, "Close error on file %s", filename);
>> +        ret =3D false;
>>      }
>> +    return ret;
>>  }
>>=20=20
>>  /*
>> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
>> index 6b6025e..180dd56 100644
>> --- a/src/openvpn/buffer.h
>> +++ b/src/openvpn/buffer.h
>> @@ -469,11 +469,8 @@ const char *skip_leading_whitespace(const char *str=
);
>>=20=20
>>  void string_null_terminate(char *str, int len, int capacity);
>>=20=20
>> -/*
>> - * Write string in buf to file descriptor fd.
>> - * NOTE: requires that string be null terminated.
>> - */
>> -void buf_write_string_file(const struct buffer *buf, const char *filena=
me, int fd);
>> +/** Write buffer contents to file */
>> +bool buffer_write_file(const char *filename, const struct buffer *buf);
>>=20=20
>>  /*
>>   * write a string to the end of a buffer that was
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 5381ef2..35bd243 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -1427,27 +1427,19 @@ write_key_file(const int nkeys, const char *file=
name)
>>  {
>>      struct gc_arena gc =3D gc_new();
>>=20=20
>> -    int fd, i;
>> -    int nbits =3D 0;
>> +    int nbits =3D nkeys * sizeof(struct key) * 8;
>>=20=20
>>      /* must be large enough to hold full key file */
>>      struct buffer out =3D alloc_buf_gc(2048, &gc);
>> -    struct buffer nbits_head_text =3D alloc_buf_gc(128, &gc);
>>=20=20
>>      /* how to format the ascii file representation of key */
>>      const int bytes_per_line =3D 16;
>>=20=20
>> -    /* open key file */
>> -    fd =3D platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUS=
R | S_IWUSR);
>> -
>> -    if (fd =3D=3D -1)
>> -    {
>> -        msg(M_ERR, "Cannot open shared secret file '%s' for write", fil=
ename);
>> -    }
>> -
>> +    /* write header */
>> +    buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits);
>>      buf_printf(&out, "%s\n", static_key_head);
>>=20=20
>> -    for (i =3D 0; i < nkeys; ++i)
>> +    for (int i =3D 0; i < nkeys; ++i)
>>      {
>>          struct key key;
>>          char *fmt;
>> @@ -1463,9 +1455,6 @@ write_key_file(const int nkeys, const char *filena=
me)
>>                              "\n",
>>                              &gc);
>>=20=20
>> -        /* increment random bits counter */
>> -        nbits +=3D sizeof(key) * 8;
>> -
>>          /* write to holding buffer */
>>          buf_printf(&out, "%s\n", fmt);
>>=20=20
>> @@ -1476,17 +1465,8 @@ write_key_file(const int nkeys, const char *filen=
ame)
>>=20=20
>>      buf_printf(&out, "%s\n", static_key_foot);
>>=20=20
>> -    /* write number of bits */
>> -    buf_printf(&nbits_head_text, "#\n# %d bit OpenVPN static key\n#\n",=
 nbits);
>> -    buf_write_string_file(&nbits_head_text, filename, fd);
>> -
>>      /* write key file, now formatted in out, to file */
>> -    buf_write_string_file(&out, filename, fd);
>> -
>> -    if (close(fd))
>> -    {
>> -        msg(M_ERR, "Close error on shared secret file %s", filename);
>> -    }
>> +    buffer_write_file(filename, &out);
>>=20=20
>>      /* zero memory which held file content (memory will be freed by GC)=
 */
>>      buf_clear(&out);
>>
>=20
> I like this change especially because the writing function now returns a
> boolean reporting its success or failure. How about adding some more
> checks in the calling chain so that such status can be used?
>=20
> As of now, if the writing function fails, openvpn will print an error
> message, but won't really return "a failure" (as in returning non-zero).
> What do you think?

Absolutely right, will improve error handling and make openvpn return
non-zero.

-Steffan


--066rxLf0SOJj9WDpKjYfmBLxNhFte7LtH--

--GgngW5lc4zxv8BTKM3AXCxDoZhTVxnGZV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbYxHzAAoJEEEwndWOY1w5DPQH/2P2e/CjCrfm0T2UmWS1wQZ8
hPKv/Zeyzm6Fg+lXTm9+HSg8QTpp2+TQZ5g1AugudUHrJpkjqvL1/swbQaZ/fW0M
mCCRrZ9OSNDAvnD5xp/NmSEMHRIrxpZZKzY//TLmRX4TQ/dTVeEi1FxiZoTTlv/D
vVf4UezlQGhe7BX91kwMHc85THVnxEaqfTvDSzvg+i1Wny65WJbx8x1viVvATjf1
5ysBdbxp1AA8Uoya8ss2ve+JizYFhvxDax0wIiDRjlHjLyxHtgrovLm6d+UIFaa8
14q2ulXkKx/m62CbnblAHoBzWxtoikx4JRRJ53edf6AAA6Yex9cvlzWw6o4pkXc=
=kTSJ
-----END PGP SIGNATURE-----

--GgngW5lc4zxv8BTKM3AXCxDoZhTVxnGZV--

