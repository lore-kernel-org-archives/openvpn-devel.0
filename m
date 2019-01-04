References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
 <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
Date: Fri, 4 Jan 2019 17:25:47 +0100
MIME-Version: 1.0
In-Reply-To: <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a8WGGYR7ti6lLBLJZbQRqlloKeJ5YG0t9"
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a8WGGYR7ti6lLBLJZbQRqlloKeJ5YG0t9
Content-Type: multipart/mixed; boundary="GbYGnayFCuzFQB4PJCl7PYrIAuCoQ5YPf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c83727e1-907c-cdd3-1c0d-9c563a7dc757@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
 <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
In-Reply-To: <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>

--GbYGnayFCuzFQB4PJCl7PYrIAuCoQ5YPf
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 02/01/2019 07:35, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Il 31/12/18 01:08, David Sommerseth ha scritto:
[...snip...]
>> And IIRC, we managed to get the new unit files into the Debian openvpn 2=
.4
>> package.  And I just hope that they are updated with whatever we provide=
 in
>> our tarballs; if not - it might be considered broken packaging.  The rea=
son
>> you'll find the b0rken unit files in the upstream Debian packages is to =
not
>> break old existing installs.  Which is nice, just that it behaves broken
>> regardless.
>=20
> And this is exactly the reason I did _not_ remove openvpn.service or
> openvpn@...1685... from our Ubuntu 18.04 packages.

Okay, I was a bit unclear.  The approach used with openvpn.service and
openvpn@...1685... are broken by (Debian) design.  Quite many users have
reported that these service files does not work at all.  But I'll admit, I'm
not really up-to-date if these service files have been updated by
distro-packagers later on.

It would be far better to pop up a README file at install/update time saying
"These unit files are gone, use the new ones instead."  The reason is that
_our_ packages are different than Debian's packages, so they shouldn't need=
 to
try to duplicate the Debian packages in every detail.

Secondly, if OpenVPN is built with systemd support there are a few other
surprises some users have reported to me, when not using the unit files whi=
ch
makes use of the openvpn<->systemd interface in the C code.  We even do some
intercepts related to the --daemon if systemd is detected, where it is
effectively ignoring --daemon (as that is not needed with the new systemd
files).  My memory is blurry here, though.

The alternative is to provide an alternative to openvpn@...1685..., which d=
oes
not add all the client and server specific hardening, automatic restarts, e=
tc,
etc, but ensures the openvpn<->systemd interface is intact.

But for the openvpn.service, there is no alternative to killing it.  It's an
odd approach where it, IIRC, generates new unit files on-the-fly for specif=
ic
openvpn configs and then starts them.  I have some vague memories that it
would even overwrite existing unit files.  It is just generally a horrendous
approach, which tries to make the unit (ini) file behave like the old rc in=
it
shell script.  It feels list it tries to build a space rocket out of a
trolley; I'm not saying it's impossible, it's just not pretty and might even
be quite unsafe in many aspects.  Some times it is needed to draw a line and
say: From here we do it differently.

>>
>> So if anyone is in doubt ... UPGRADE to the openvpn-{server,client}@.ser=
vice
>> unit files ASAP.
>=20
> I'll mention this in the README.Debian. I added a short "notes from
> upstream" section there anyways.
>=20
> Do you have links to bug reports that would clarify why the old unit
> files are broken? If I'm not mistaken one of the issues was related to
> OpenVPN on Amazon EC2 and status check #2 not passing when an instance
> of openvpn@...1685... was running.

That's one of the issues.  I've gotten several reports since the v2.4 relea=
se,
covering all kind of scenarios as well, the vast majority of those issues
disappeared when switching to our new ones.  I have discussed this many tim=
es
on IRC, I know there existed some issues both in Trac and elsewhere - but
right now I don't have a good list of them handy.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--GbYGnayFCuzFQB4PJCl7PYrIAuCoQ5YPf--

--a8WGGYR7ti6lLBLJZbQRqlloKeJ5YG0t9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcL4kLAAoJEIbPlEyWcf3yPH4P/iNuVcZRv7yuqWq1KZIDiXuO
Hoa8rUIzgjSxanf48gAeUujak9Ghpp54x865ZnBmZ+v39NqptXeHjwQCh+N6gim4
Qa/F3sKIP49bhh7gA1BsTkA784vWOufXSPkEAqsBZCoEsDFxGRI/nBvDHi6qXmre
6heCoqcy/LwxVG9NLSzTxqZ513k5v8MV1iDg4/BlP7NDfy1PwE/12+qE8uTHVc+x
0FWrBPwicarjG3ORlDJPuVZlEiqmnMj97hWoY6eRIXJ864b996YPhE/0DArM0SZr
biJBhd/8cIIHRhEiivfa16H+1BI+Nk6KqlWBN/iYzxAjSggJRLI07v1IAiEEYJhF
l9A7QkIfYU62+uEs4BtPG4UOQre0xvf75/WPYltEM0GkHOdSkjzd9PXZWX5Xb8U9
LfZo3WHtz6lZxcTQgTCjPLO4jMpq0ThANjDRIAGRCBU7w2g3akJ6DjLyV5QO3Ply
/tyHGdydfw1qSz9iq/99ool9pVo2xYRvTIUfZ/kJYDoDVd+72iAUzyPBaOi9+xGD
hIfRNVesZpIp/Rs0947YVEccuwBi0GqMSMqiWUtYOd8USQxbd0hopGt+/+QAERro
2vjVf7SFQj6LR56v773JZkBDx0/H3YZRxesWP+T8fSGFuHSUYWvW9Py5U5PH3jaT
Pus85Jiur85cNC6YcbgT
=Y92U
-----END PGP SIGNATURE-----

--a8WGGYR7ti6lLBLJZbQRqlloKeJ5YG0t9--

