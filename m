Message-ID: <50851BE0.3020907@...1114...>
Date: Mon, 22 Oct 2012 12:11:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
	<20121022084853.GF742@...1296...>
In-Reply-To: <20121022084853.GF742@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0CCCE35CACA9CAD2EA70AC47"
Subject: Re: [Openvpn-devel] Bug in program, bug in documentation,
 or something else?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0CCCE35CACA9CAD2EA70AC47
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/10/12 10:48, Gert Doering wrote:
> Hi Jonathan,
>=20
> On Sun, Oct 21, 2012 at 06:40:08PM -0400, Jonathan K. Bullard wrote:
>> A Tunnelblick user has reported odd behavior with name resolution failur=
es.
>> I can't tell if it is a bug in OpenVPN, a bug in the documentation, or
>> something else. The behavior is apparently the same in OpenVPN 2.2.1 and
>> 2.3alpha1.
> [..]
>> Any ideas if this is a program bug, a documentation bug, or something el=
se,
>> for example, a problem that only occurs on OS X?
>=20
> "One of those" :-) - I don't know yet, and haven't looked into the code y=
et
> (will do ASAP).
>=20
> The resolver code has been changed for 2.2 (getting rid of the old
> randomization stuff), so it might be a bug introduced there, or a much
> older bug that nobody ever noticed.
>=20
> Do you have an OpenVPN log that shows this behaviour?  Might help in
> digging down to it...

A client config file would help in addition.  I'm also wondering if
connection profiles are used ... that is, more --remote options or
<connection> blocks.

Otherwise, I would not be surprised if there are some corner case here
appearing, which surfaced more easily when the resolving code was
re-written (as Gert mentioned).

This resolver_retry_second option is only used in socket.c AFAICT, which
most of us try to avoid looking too hard on, to avoid eye cancer and/or
loosing our sanity ;-)  But there's work in progress on cleaning up that
one, unfortunately that will take some time.  But we'll try to hunt down
this which looks like an openvpn bug to me.


kind regards,

David Sommerseth


--------------enig0CCCE35CACA9CAD2EA70AC47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCFG+MACgkQDC186MBRfrpOmwCaAkB3Ro1+hGGwE4Gf2TAFEw2U
WT4AnijiIUymlki5DzPxk4mKtDKyWWLy
=Yp6H
-----END PGP SIGNATURE-----

--------------enig0CCCE35CACA9CAD2EA70AC47--

