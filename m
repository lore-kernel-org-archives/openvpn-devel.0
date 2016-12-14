References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
	<8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>
Date: Wed, 14 Dec 2016 17:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uE0NBejsTC4TaVeC7wd2rUIRse6vfHFl4"
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
 disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uE0NBejsTC4TaVeC7wd2rUIRse6vfHFl4
Content-Type: multipart/mixed; boundary="fJuEhIkCIOCNkTotIINJ6tl8dwhVWVxfK";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <83bb8b8e-5428-f6c0-9c13-766ddc1917f0@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
	disabled
References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
	<8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
In-Reply-To: <8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>

--fJuEhIkCIOCNkTotIINJ6tl8dwhVWVxfK
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14-12-16 16:39, David Sommerseth wrote:
> On 14/12/16 10:09, Gert Doering wrote:
>> Hi,
>=20
>> On Wed, Dec 14, 2016 at 10:51:18AM +0200, Lev Stipakov wrote:
>>> +/* + * Disable async-push if plugins are disabled + */ +#if
>>> !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH) +#undef
>>> ENABLE_ASYNC_PUSH +#endif +
>=20
>> That one gets a NAK from me, for the reasons given.
>=20
>> As long as we *have* --enable/--disable options in configure, they
>> should be validated *there* and not silently ignored.
>=20
>> David's argument about "configure is for finding system dependent
>> things and compiler settings" has some merits, but then we should
>> get rid of all compile-time --enable/--disable settings.
>=20
> By this logic should we enforce users to add --disable-def-auth if
> --disable-plugin is set?  If so, then we should probably also do
> something with --disable-plugin-auth-pam and
> --disable-plugin-down-root.  And with --disable-plugin-auth-pam, we
> need to look at --enable-pam-dlopen as well.

No, unless the user specified --enable-def-auth.  And yes, I think it
would be nice if we would throw an error if the user did.  "Fail-fast"
is a really good habit.

> And to put things in context of the async-push stuff.  In the C code
> we already check if --disable-def-auth is enabled or not.
>=20
> If we truly start to look into this for the other options, we will
> have quite a good job ahead of us.  Otherwise we end up with even more
> mess where we are not even consistent.

Sure, but "The other stuff is broken" is no argument to not add
something that is not broken.

> I say it again, configure.ac is *NOT* the place to do sanity checks on
> which openvpn features depends on each-other.  We have not done that
> before, and we should not do it now.  It just provides far more
> non-production code to maintain, and more places to look for issues
> when code we expect to to be compiled in isn't being compiled in.
> This way leads is a rats nest and will cause much more maintenance
> burden in the future, which I will not accept lightly.

Yes we do.  Just check the mbed TLS pkcs11 checking.  That check has
saved me some hours of re-running builds at the least.  I wish we had
more such checks.

> Yes, I see the short-term convenience to solve that specific Trac
> ticket.  But it really isn't the right long-term solution.

I respectfully disagree.  I believe this *is* the right long-term fix,
and we should aim at doing it this way.

-Steffan


--fJuEhIkCIOCNkTotIINJ6tl8dwhVWVxfK--

--uE0NBejsTC4TaVeC7wd2rUIRse6vfHFl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYUXIVAAoJEEEwndWOY1w5ROYIAIzzcWyN/pIiD8U8fIbWK0K1
qalt3CnmUOUwzhUose/vSGjDMynqmP75i/mSzbevxh8ivXwLshlBga4O/P2MXuHn
PkL4LhCsRjftMsaf/zvKLF4Zw1EHDIAQ5LkzP6Va+F2EP24cCxxW0zmGBJ/0nzfg
BEzJsH4h1TWTP8iaF/jnR0gVi3mi8y0OBxXAK5WOV2qZA09+qpuc+dN66JQ0ZuAv
O4Oy1JaZOayo9xmf4XQ/5dmeZuUnqexiqUKUFUuOeJ3YdCxY9ZVNz6WOMwqTAL6h
c3ovDGUiyC0mKzP+xVO9dDT2b8Zhvb32pba7WVF4wcl78d5sgaFOePFUVq4zuyE=
=yuzb
-----END PGP SIGNATURE-----

--uE0NBejsTC4TaVeC7wd2rUIRse6vfHFl4--

