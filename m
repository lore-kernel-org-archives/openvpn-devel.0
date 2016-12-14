References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
Date: Wed, 14 Dec 2016 16:39:36 +0100
MIME-Version: 1.0
In-Reply-To: <20161214090932.GC78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
 disabled
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/12/16 10:09, Gert Doering wrote:
> Hi,
>=20
> On Wed, Dec 14, 2016 at 10:51:18AM +0200, Lev Stipakov wrote:
>> +/* + * Disable async-push if plugins are disabled + */ +#if
>> !defined(ENABLE_PLUGIN) && defined(ENABLE_ASYNC_PUSH) +#undef
>> ENABLE_ASYNC_PUSH +#endif +
>=20
> That one gets a NAK from me, for the reasons given.
>=20
> As long as we *have* --enable/--disable options in configure, they
> should be validated *there* and not silently ignored.
>=20
> David's argument about "configure is for finding system dependent
> things and compiler settings" has some merits, but then we should
> get rid of all compile-time --enable/--disable settings.

By this logic should we enforce users to add --disable-def-auth if
- --disable-plugin is set?  If so, then we should probably also do
something with --disable-plugin-auth-pam and
- --disable-plugin-down-root.  And with --disable-plugin-auth-pam, we
need to look at --enable-pam-dlopen as well.

And to put things in context of the async-push stuff.  In the C code
we already check if --disable-def-auth is enabled or not.

If we truly start to look into this for the other options, we will
have quite a good job ahead of us.  Otherwise we end up with even more
mess where we are not even consistent.

I say it again, configure.ac is *NOT* the place to do sanity checks on
which openvpn features depends on each-other.  We have not done that
before, and we should not do it now.  It just provides far more
non-production code to maintain, and more places to look for issues
when code we expect to to be compiled in isn't being compiled in.
This way leads is a rats nest and will cause much more maintenance
burden in the future, which I will not accept lightly.

Yes, I see the short-term convenience to solve that specific Trac
ticket.  But it really isn't the right long-term solution.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUWe4AAoJEIbPlEyWcf3yX8QQAMDl+us2tVSCCABm0RZ77srQ
kRNIrxitehRgzlJi6/Hsod4lDtUxiJ9Q70EjFswHeRkAw9jAD1C69h2Ht4z7etb7
zdqPO+qH44YEA+lDeOu8dcP73q9Ff3izEJdF35ripHCbNymrKkoT+4+OkYDj3VIl
xRMLnem3MWfpmdqxzhGdkU/NkSMUMiGF8S7xAJDakvZ7CGvNOfUByWlG7dmUXU9U
oRxb0oyJdnSuj8SWDS5sQb6VsXyqAGnKKnE82YL6KZxTYOmri/SkO3HcfBT61dlq
bR/CypjuDCppP6bTRegV0xP0V7qNyjm3F6VzTu7Wt5TyFw60AN9xsKV6B71vwUzp
h2dhe3QEYQHYJ2m+vcwxRI0CfzO1zQM7UiJ23OjMgYeyMu7Y01fpm/Y1MixTVMct
rSeXOpJQkNFCs3v/NPrA8a85IIptDa8cLiOzz3Hca3hIESRmPhZgPxSeAGz+cqNQ
Ql8pZ2YMroFUQZIGcsJblXO/s/G8ud4urruXPGnrCj26mGUNBjmht0iLIZs7EJK1
bhviQSkPXeoUSWuonw9TN+hx3w8YRJocHaUkVz26+F9HnLJbma8Sew7BK+pqs1g6
2yNpxYUQtlChbItP+q7dYCYm23m5uRs28sP52u1AKMfeIbA5FPGpqBB/Kjz0ueQn
sh5T6CFecL9NAGIxJf9h
=3D26tU
-----END PGP SIGNATURE-----

