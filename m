Message-ID: <51B9C0A3.9010403@...1114...>
Date: Thu, 13 Jun 2013 14:52:51 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51B9B6EE.60007@...193...>
In-Reply-To: <51B9B6EE.60007@...193...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2IUSLHIQPFINEJKGMOKXA"
Subject: Re: [Openvpn-devel] how to report bug
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Farkas Levente <lfarkas@...193...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2IUSLHIQPFINEJKGMOKXA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 13/06/13 14:11, Farkas Levente wrote:
> hi,
> what is the current prefered way to report bug in openvpn?
> trac? eg is there any chance to this will be fixed?
> https://community.openvpn.net/openvpn/ticket/225

Hi,

I'm now going to say something which might sound controversial, but I'm
actually trying to describe the reality more than the ideal way how this
normally should work.

We are quite few developers, and most of us do OpenVPN hacking in our
precious spare time.  That basically means that we have a very long
backlog of bugs to fix, and we prioritise more or less those itches
which hits us more directly.

To give you some numbers ... there is one person working fulltime on
development in OpenVPN Technologies and he got a full schedule with
development tasks related to their customers needs and demands.  The
rest of the community consists of roughly a handful developers, which
covers everything from the more general parts of OpenVPN to specialised
parts of it like IPv6, SSL/Crypto, plug-ins API, Windows port, Android port.

If there are so-called "low hanging fruits" with clear obvious solutions
which takes a short time to fix, they usually gets fixed rather soonish.
 Or security critical issues.

But if we can't be convinced it is a critical issue which needs
immediate action ... it will take time to get things fixed.  We usually
do give feedback to most patches and Trac tickets, so the best solution
then is to carefully consider the feedback ... and see if that feedback
can be implemented in a patch which can be contributed to the mailing
list (preferably) or attached to a Trac ticket.

If you, or anyone else, is interested in participating and helping out
... please, don't be shy! We need more manpower!  Show up in the
#openvpn-devel IRC channel on FreeNode, become more active the
openvpn-devel mailing (commenting on patches).  Raise your voice and let
us get to know you better.  If you have good feedback and comments and
your reasoning makes sense to the rest us, you will quickly gain more
responsibility in the community.

About 5 years ago, #openvpn-devel didn't exist at all.  Now there are
8-10 people in that channel right now who have gotten some of their
patches committed to the different OpenVPN git trees.  And 4-5 of these
are actively involved in discussing patches on a regular basis.

So if you have interest in OpenVPN development.  You can influence
OpenVPN by raising your voice and getting involved.  Gain trust among
the community members, and you will be entrusted with more responsibility.


--=20
kind regards,

David Sommerseth



------enig2IUSLHIQPFINEJKGMOKXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG5wKgACgkQDC186MBRfrow7ACcD/RU/7WYjGvyZ52TJIjfihDx
h40An0/k+BlfjMgIOZLEr2+yyWpciKD0
=ajXQ
-----END PGP SIGNATURE-----

------enig2IUSLHIQPFINEJKGMOKXA--

