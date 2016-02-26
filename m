From: David Sommerseth <openvpn@...2080...>
References: <1456171763-44172-1-git-send-email-fish.thss@...277...>
	<20160225122928.GC24952@...1296...>
	<56CEF9E5.3090508@...2080...>
Message-ID: <56D0496A.2050301@...2080...>
Date: Fri, 26 Feb 2016 13:47:38 +0100
MIME-Version: 1.0
In-Reply-To: <56CEF9E5.3090508@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BjAlPA6BMLg15hkdl6mAgDKsnrSUA1EU2"
Subject: Re: [Openvpn-devel] The puprose of the Signed-off-by: line
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BjAlPA6BMLg15hkdl6mAgDKsnrSUA1EU2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


>> The reason of adding the Signed-off-by is to have a better understanding
>> of whom have been involved in particular commits/patches.  While the
>> "Author field" in the git log (git log --pretty=3Dfuller) can only have
>> one name, more people can have been involved in the patch.  Using the
>> Signed-off-by is a way to credit them as well.
>>
>> And when everyone is consistent using the Signed-off-by line, writing
>> tools which parses our git log is also far more easier.
>>
>> The other aspect of the Signed-off-by: line has to do with juridical
>> stuff, to protect the OpenVPN project.  By adding the Signed-off-by:
>> line you basically sign-off to "Yes, I am the author of these changes
>> and I am permitted to share them with the project".  For more
>> information, these pages explains it even better (same info, two
>> different sources):
>> <https://git.eclipse.org/r/Documentation/user-signedoffby.html>
>> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/SubmittingPatches#n409>
>=20
> Hi David,
>=20
> Looks like the rationale for Signed-off-by by is not properly documented =
in Trac:
>=20
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>=20
> David: do you want to integrate above explanation to Trac or shall I?

I intended to update the wiki page as well.  It should be updated.  The
trouble is that I started thinking.  But I think we should do some more
modifications to more of this process.

There are two things I think we should agree upon first, which is
slightly different compared to the wiki page.


1) It probably makes more sense to use Reviewed-by: instead of
   Signed-off-by: when someone have reviewed and not added code to the
   commit.

2) We should probably rethink the need of Signed-off-by: lines when
   Gert or I do commits without modifying the patch in any way.  Whom
   committed the patch is now also easily accessible using
   the --pretty=3Dfuller argument to git log.

   And it should be an explicit note which states that the committer
   which adds a Signed-off-by: line to an unmodified commit does not
   mean the same as when a patch contributor does so.  The committer's
   Signed-off-by: basically means "Yes, this patch has been accepted by
   N.N" ... That was the intention of this last Signed-off-by: line.

If we drop the additional Signed-off-by: line, we are much closer to
what other projects using Signed-off-by does.

I know I'm the one to blame for all this, as I believe it was my initial
suggestion.  But that was many years ago; where both the git tool have
improved vastly and the way git is used are nowadays somewhat more
unified across projects then what it was around in 2010-ish.  And I
think we have all learned to use git far better over all these years as
well.

Thoughts?


--=20
kind regards,

David Sommerseth

--=20
kind regards,

David Sommerseth


--BjAlPA6BMLg15hkdl6mAgDKsnrSUA1EU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlbQSW0ACgkQDC186MBRfrquwgCgpBfGi/1UbM3tQ4VgM5rGESPV
6UsAoJfcLz9pM4MPUw1I3D5VQS967fmY
=klyO
-----END PGP SIGNATURE-----

--BjAlPA6BMLg15hkdl6mAgDKsnrSUA1EU2--

