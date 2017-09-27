References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
 <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
 <3dadff5b-c169-30b1-c4fe-27f9dd39edae@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
Date: Wed, 27 Sep 2017 10:34:57 +0800
MIME-Version: 1.0
In-Reply-To: <3dadff5b-c169-30b1-c4fe-27f9dd39edae@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6Ub9eEV9Er8wDJtrmmi1xTRwudgpsKbbc"
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if
 plugin init fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Ub9eEV9Er8wDJtrmmi1xTRwudgpsKbbc
Content-Type: multipart/mixed; boundary="kWSPHVpK2wFuXt27NXS8KblehefofqF5L";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>
Message-ID: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if plugin
 init fails
References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
 <af093d4a-50c1-d18c-11d7-1f6a84fa130c@...2080...>
 <3dadff5b-c169-30b1-c4fe-27f9dd39edae@...1856...>
In-Reply-To: <3dadff5b-c169-30b1-c4fe-27f9dd39edae@...1856...>

--kWSPHVpK2wFuXt27NXS8KblehefofqF5L
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 26/09/17 00:22, Steffan Karger wrote:
> Hi,
>=20
> On 21-09-17 23:03, David Sommerseth wrote:
>> On 15/09/17 08:39, Steffan Karger wrote:
>>> close_instance() tries to remove the file in c2.pf.filename, but that o=
nly
>>> works if we actually set that if we fail.  So, set that filename as soon
>>> as we know we've created the file.
>>>
>>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>>> ---
>>> v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.
>>>
>>>  src/openvpn/pf.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>>> index 5fe1734..7479347 100644
>>> --- a/src/openvpn/pf.c
>>> +++ b/src/openvpn/pf.c
>>> @@ -618,19 +618,18 @@ pf_load_from_buffer_list(struct context *c, const=
 struct buffer_list *config)
>>>  void
>>>  pf_init_context(struct context *c)
>>>  {
>>> -    struct gc_arena gc =3D gc_new();
>>>  #ifdef PLUGIN_PF
>>>      if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
>>>      {
>>> -        const char *pf_file =3D create_temp_file(c->options.tmp_dir, "=
pf", &gc);
>>> -        if (pf_file)
>>> +        c->c2.pf.filename =3D create_temp_file(c->options.tmp_dir, "pf=
",
>>> +                                             &c->c2.gc);
>>
>> Patch looks good.  But it introduces a new compile warning.
>>
>> pf.c: In function =E2=80=98pf_init_context=E2=80=99:
>> pf.c:624:27: warning: assignment discards =E2=80=98const=E2=80=99 qualif=
ier from pointer target type [enabled by default]
>>          c->c2.pf.filename =3D create_temp_file(c->options.tmp_dir, "pf",
>>
>> I'm pondering if we need create_temp_file() to actually return
>> a const char * - wouldn't just a plain char * be enough?
>=20
> Good point.  But I think it's best to return a const char * here,
> because the memory is allocated through a gc and therefore should also
> be free'd through the gc.  The const modifier prevents freeing the data
> without a warning (as long as you keep smacking me for discarding const
> qualifiers, or we add a -Werror compile flag ;-) ).
>=20
>> The alternative is to cast the const away here; but that just
>> feels too hacky in this code path.
>=20
> Or change c->c2.filename to be const char *.  I think that's the way to
> go here.  And possibly reject a NULL gc argument in create_temp_file(),
> because that would make the function leak memory...
>=20
> What do you think?

I personally like that. It somehow brings in the concept of 'ownership'
and avoids introducing faulty code (we'd get warned as you said above).

Cheers,

--=20
Antonio Quartulli


--kWSPHVpK2wFuXt27NXS8KblehefofqF5L--

--6Ub9eEV9Er8wDJtrmmi1xTRwudgpsKbbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnLDlUACgkQB6U8WA7y
zXTU2A//UTvvLDR8rKahtUlKmAm4dLN+0pHYoPIq4vJOK9dritLM5oZmPT677IFe
CPQpdHd6S9ZeUIYGRjkS9+JsCPf4GUv7bv6JaUtRzygSAihXBjvtCoQHL69nM/qF
Rc1BoEKuZ8zjg1RIEWGMxSohz2Tt6Oiy6ABKiFyx/N6aDvTARygLgc4KO8gczPzS
tPQqS1ZwAXS3vik0HXlakEhAOu76AOGAhuAaN2EvsNbMPLGKe1xAV8WxOAFUKS9B
M6SI94d9yfP5U6CywV/H1GcOtJ2TgTup4wrlH44ygquuw9b3Nhgq0F1mGxdpaVl2
dUPHcW4tP7Fw6q8jmJQ9Kg2PLdHUCaJ7T5f5ckC7wqYHy/nO0fX0PYuQIVoqNNv9
kGDoaKR08TE1BBzkS1XCFQ7a7fXbJ7AfpbxuvzjL4nz2tok5MV7NXhxuYkkr0CzY
8/cLUlU8qxpdvvwVjKEy+lHZj8Lz+KU0uAPKM81mwKDtE+akrE8GCKXjSyqcl+La
8gIbLXfswZV/rYYlsRu8DKhq5UjF409zIJG8U6gyGwal2pZGPrDHYHijljmfhpp8
bOw93wbrgVG3VMDFZcwITzlj67xn0Taim9oNw0gnQQhmd54Cd5xivhdlKsuYXBnc
O/T4P6bNJCVJY1dvCCRM08wz0QFtQW11hLFVXt0prDlZ2aCJ0WI=
=Xo2g
-----END PGP SIGNATURE-----

--6Ub9eEV9Er8wDJtrmmi1xTRwudgpsKbbc--

