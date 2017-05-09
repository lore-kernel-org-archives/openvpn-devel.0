References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
	<b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <8f79c477-9952-fea3-3f55-2a3d4541760a@...1435...>
Date: Tue, 9 May 2017 20:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TUcUle8eo0dQ52oDHe8ELvJkIWCL6JoDx"
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
 memory on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--TUcUle8eo0dQ52oDHe8ELvJkIWCL6JoDx
Content-Type: multipart/mixed; boundary="rCelxVuFLCWwTQXRaMNVBt6p3qupRGcLo";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <8f79c477-9952-fea3-3f55-2a3d4541760a@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
	memory on error
References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
	<b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
In-Reply-To: <b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>

--rCelxVuFLCWwTQXRaMNVBt6p3qupRGcLo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09-05-17 19:47, David Sommerseth wrote:
> On 09/05/17 12:50, Steffan Karger wrote:
>> This issue was found by Quarkslab during the OSTIF-founded security audit
>> (issue 5.4), we agree with their analysis:
>>
>> "There=E2=80=99s a special case where the client username and password a=
re not
>> erased when the server is launched without an external script or
>> authentication plugin. While being invalid, this configuration does not
>> raise any error. If the client transmits its credentials and the session
>> is not established (for instance if the certificates chain has not been
>> verified), these credentials are not erased from memory by the server.
>>
>> The likelihood of an occurrence of this issue in real life is exceptiona=
lly low since an attacker
>> needs elevated privileges on the server to exploit this kind of informat=
ion leak. The severity of
>> this issue is rated as very low."
>>
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>>  src/openvpn/ssl.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 1033e58..abf5786 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -2661,6 +2661,7 @@ key_method_2_read(struct buffer *buf, struct tls_m=
ulti *multi, struct tls_sessio
>>=20=20
>>  error:
>>      secure_memzero(ks->key_src, sizeof(*ks->key_src));
>> +    secure_memzero(up, sizeof(*up));
>>      buf_clear(buf);
>>      gc_free(&gc);
>>      return false;
>>
>=20
> Feature-ACK, but code-NAK.
>=20
> In key_method_2_read() there are a few places where `goto error;` can be
> used before `up` is allocated.  This will make secure_memzero()
> segfault, as it does not handle NULL pointers.  Or even worse (if the
> compiler let this pointer point at a random address), which leads to an
> unpredictable behaviour.
>=20
> That said, I think we should fix secure_memzero() to just return if the
> input pointer is NULL.  And even though most compilers do initialize
> variables, I think it's good to be defensive here and initialize `up` too.
>=20

Oof, good catch.  I'll send a v2 in a minute.

-Steffan



--rCelxVuFLCWwTQXRaMNVBt6p3qupRGcLo--

--TUcUle8eo0dQ52oDHe8ELvJkIWCL6JoDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZEgpEAAoJEEEwndWOY1w5Y50H/Rwwve4BDHFdRNV9sGFjIk5F
/m36MU4gsfsxm+26YB5M6cQ956TEUSgZscIzwm6dlciwP2NJpFltCC5shyaeLFBk
ooeCiaYaOG+yVLxXNPyn1DcdG90LH7W4avIKiUyUP1CiJtTSA5tsICT7hRUmt4wj
aLzAplahrRm22uJI7R5SAWrS7SOgirshr1W/39ilczYJ9tscpopS9Re440cmEmtz
1KEJbjNeum8NdKbavcK/Xqt75FdjtgSjeuvl4oDeGQWVAhXO1O1J+xf3ORo4Aj11
MOohQwemdCJ9F62LYuOQUQpxd1dObgn1xUngrxT+7C5PsWGl7N6h8R/7NI9BE10=
=Dz2q
-----END PGP SIGNATURE-----

--TUcUle8eo0dQ52oDHe8ELvJkIWCL6JoDx--

