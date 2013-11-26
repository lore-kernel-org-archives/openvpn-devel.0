Message-ID: <529482BD.5050001@...1114...>
Date: Tue, 26 Nov 2013 12:15:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <l142b75v@...1062...>	<1385131108-19717-1-git-send-email-dazo@...384...>
	<CAA1AbxJZa2gMBXpHiQuXD2J+8eOZCvQp+ftzrC49fH2HDfNACg@...278...>
In-Reply-To: <CAA1AbxJZa2gMBXpHiQuXD2J+8eOZCvQp+ftzrC49fH2HDfNACg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JGo2gSU2Liajm3PgWqt9k0oB04toXJkBt"
Subject: Re: [Openvpn-devel] [PATCH] Fix file checks when --chroot is being
 used
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JGo2gSU2Liajm3PgWqt9k0oB04toXJkBt
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23. nov. 2013 10:53, Steffan Karger wrote:
> Hi David,
>
> This solution looks good. I did not test, but I do have one minor
> comment after glancing at the code:
>
> @@ -2662,7 +2700,14 @@ check_cmd_access(const char *command, const
> char *opt) * only requires X_OK to function on Unix - a scenario
> not unlikely to * be seen on suid binaries. */ -    return_code =3D
> check_file_access(CHKACC_FILE, argv.argv[0], X_OK, opt); +    if
> (chroot) +      { +        return_code =3D
> check_file_access_chroot(chroot, CHKACC_FILE, argv.argv[0], X_OK,
> opt); +      } +    else +      { +        return_code =3D
> check_file_access(CHKACC_FILE, argv.argv[0], X_OK, opt); +      }
>
>
> This if seems redundant here, as chroot is checked by
> check_file_access_chroot itself. Furthermore, for the other
> occurences of check_file_access you stick to just replacing it
> with check_file_acess_chroot. I would suggest to do that here too.

Thanks a lot for the review, Steffan!

Yeah, you're absolutely right.  I have no strong feelings for either
approaches.  But the initial reason I did it in this explicit way, was
to be, well, explicit about that we do something different when chroot
is used - instead of burying it one level deeper down.  On the other
hand, simplicity can also be just the better approach.

I hold no grudges ;-)  I've mailed a v2 version of this patch
implementing it the way you suggest.  And, surely, this change is even
slightly less intrusive than my first approach.

So I'll let it be up to you, Josh and the rest of the ML to decide
which approach you prefer more ... and Gert will apply whatever gets
an ACK I presume :)


David S.


--=20
kind regards,

David Sommerseth


--JGo2gSU2Liajm3PgWqt9k0oB04toXJkBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKUgr0ACgkQDC186MBRfro9jACfR+ERirMzusd25cHy5G1RRUx9
chAAn2FBI40XzpM2hXJfldEKL66OWLKc
=gJas
-----END PGP SIGNATURE-----

--JGo2gSU2Liajm3PgWqt9k0oB04toXJkBt--

