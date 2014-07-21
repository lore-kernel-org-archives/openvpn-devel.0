Message-ID: <53CD293A.3040601@...1114...>
Date: Mon, 21 Jul 2014 16:52:42 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>	<CAA1Abx+R_ARom8UBH2z-qRz0bqwq7==vT5KY93OWCgeQQc=ShA@...278...>
	<20140721120250.GK1118@...1296...>
In-Reply-To: <20140721120250.GK1118@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CPqu5oP2GDko2eciRBuu54MQ5piUg8xpX"
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPqu5oP2GDko2eciRBuu54MQ5piUg8xpX
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 21/07/14 14:02, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jul 21, 2014 at 01:24:53PM +0200, Steffan Karger wrote:
>> LibreSSL has just been ported to Linux.=20
>=20
> I'd stay away from LibreSSL for a while.  "We do OpenBSD, and do not care
> for portability" seems to have side effects on things like "seeding RNG"
> that should be fully understood before using that.
>=20
> (Unfortunately I do not have the link that details this particular issue
> - came around it last week)

Maybe it was this one? <https://lwn.net/Articles/605509/>

But I generally agree, LibreSSL should not be used too easily currently.
 It takes a long time to mature an SSL library and ensure it is secure
and good.  Many also questions how the LibreSSL team will tackle
security updates of new issues found in OpenSSL, and due to the
freshness of LibreSSL, nobody really knows.  How will these fixes be
ported to LibreSSL and how will they ensure it will work just as well
there as in OpenSSL?

I also feel that OpenSSL have been bashed a bit too harshly by media and
the "I don't like OpenSSL"-mobs.  Remember that OpenSSL the really first
true open sourced SSL which got a real breakthrough (before that, it was
ssley, which OpenSSL do somewhat build upon).  Many others have come and
gone in the mean time as well.  In addition: All kind of software have
bugs.  Some will be severe.  And with time, it will appear also in other
libraries as well as OpenSSL.  There have already been many issues which
have been fixed in PolarSSL, GnuTLS, NSS, etc, etc.

Yes, there are issues with OpenSSL.  Some code is ancient, some code is
very poorly documented.  Some code paths are dead on many of today's
platforms.  But it doesn't mean it's completely crappy code.  And the
OpenSSL seems to try to fix and correct some of this as well.

What is important, no matter which library you use, is that it gets
quickly updates when something is found.  OpenSSL have generally been
fairly good at this (once issues have been noticed).  But this also
requires that the sys-admins are responsible in their update processes,
and also updates the libraries as soon as possible after the official
update was released.


--
kind regards,

David Sommerseth



--CPqu5oP2GDko2eciRBuu54MQ5piUg8xpX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPNKToACgkQDC186MBRfrrvqACfa0TJLrEM1zcyCcDhWLbjASBC
AcsAoKcirkdPUbMuGUfBBTk5Nqqx269+
=vWI+
-----END PGP SIGNATURE-----

--CPqu5oP2GDko2eciRBuu54MQ5piUg8xpX--

