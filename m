References: <562103AD.1090907@...1114...> <56211876.3050801@...515...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <56217718.5030906@...1114...>
Date: Sat, 17 Oct 2015 00:15:52 +0200
MIME-Version: 1.0
In-Reply-To: <56211876.3050801@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lRxQcr4dtXMq1hQXSF5IgA7A9HFQo351e"
Subject: Re: [Openvpn-devel] The OpenVPN git repositories
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRxQcr4dtXMq1hQXSF5IgA7A9HFQo351e
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/10/15 17:32, Samuli Sepp=E4nen wrote:
>> > On the other hand, we do not want to have just a single git repository.
>> >   That is to better safe-guard us against situations similar to what t=
he
>> > Linux kernel community experienced a few years ago, where a public git
>> > tree got manipulated by an outsider.  By having several publicly
>> > available git repositories, it will hopefully be easier to discover if
>> > something bad has happened - especially for those not necessarily
>> > directly involved in the developers community.
>
> Agreed. The stunts SourceForge has been pulling off lately make me happy=
=20
> for having the repositories in GitHub also.

Well, we should always have our git repos hosted on at least two
independent sites.  I also have opinions about GitHub, but they're more
religious than technical, so I'll refrain to enter that discussion now.

>> > As a side note, both Gert and I have commit access to the public
>> > repositories, and we also do pushes to private git repositories as well
>> > - as an extra layer of repository validation.
>
> I believe Git itself should complain loudly if someone has been=20
> rewriting history of a (remote) repository maliciously.

That is right, but unless there are multiple official sources only Gert
and I will notice this when we do pushes.

If there are multiple public sources and concerned users pull down both
into their own single local repository, they can also quickly spot if
one of them have diverged or not.   Which is why I highly recommend at
least two public sources.


--=20
kind regards,

David Sommerseth


--lRxQcr4dtXMq1hQXSF5IgA7A9HFQo351e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYhdxgACgkQDC186MBRfrpwigCeNMSPxvWfhWKVGE5KrNjUOWFz
beQAn3N0KPG4P0ovx0ewfNz8zGuQI7eu
=zDvO
-----END PGP SIGNATURE-----

--lRxQcr4dtXMq1hQXSF5IgA7A9HFQo351e--

