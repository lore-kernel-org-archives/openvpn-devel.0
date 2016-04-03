From: Mike Auty <mike.auty@...277...>
Message-ID: <5701661B.80904@...277...>
Date: Sun, 3 Apr 2016 19:51:07 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bLbPh3C4LUEQ8KcCQ8uDlgHFLLDWPCmHC"
Subject: [Openvpn-devel] [PATCH 0/7] Vlan support for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bLbPh3C4LUEQ8KcCQ8uDlgHFLLDWPCmHC
Content-Type: multipart/mixed; boundary="5M55ARjvwdO28qHVd7CP33kk20ESMhJBw"
From: Mike Auty <mike.auty@...277...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5701661B.80904@...277...>
Subject: [PATCH 0/7] Vlan support for openvpn

--5M55ARjvwdO28qHVd7CP33kk20ESMhJBw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

This is the start of a 7-patch set to add vlan support to openvpn, as
authored by Fabian Knittel.

This a squashed patchset (originally numbering 21 patches, but now
reduced to 7).  These were originally written up to four years ago, and
have been maintained (at sparse intervals) by the original author.  He's
made use of them in production at a large university for the past four
years, and I'm keen to implement them in a medium sized international
organization.

These were slated for inclusion in openvpn four years ago but were never
fully reviewed.  I tried asking for these to be included back in
January, but was told that the patches were too numerous to be reviewed.
 I've therefore squashed the patches down and merged the comments in
order to create this patchset.

I contacted the original author asking if he could do the squashing, but
got no reply for a month.  I then contacted him again with my attempt
asking him if he was happy with the attribution and merging of the
comments and gave him a month to review them and provide a response.
I've still had no reply and am therefore submitting them to the list.

The original author's repository is available at [1].  I'm currently
maintaining the original patchset against the current master at [2], but
I'm relatively new to using git for interacting with large projects, so
didn't add the patches into a branch unfortunately.  The recent
conversations (including previous history) are available at [3].

Please let me know what further I'll need to do in order to help get
these patches included upstream?

Thanks,

Mike  5:)

[1] https://github.com/fknittel/openvpn
[2] https://github.com/ikelos/openvpn
[3] https://sourceforge.net/p/openvpn/mailman/message/34750695/


--5M55ARjvwdO28qHVd7CP33kk20ESMhJBw--

--bLbPh3C4LUEQ8KcCQ8uDlgHFLLDWPCmHC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iKYEARECAGYFAlcBZilfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldEZGQjEyM0ZDRDBCRjcwREE1MzA0MjNBREJC
QkFENkEyNkMyMDE1N0EACgkQu7rWomwgFXp/OgCdF9h33FXG0DrmObMAl15avs08
YlgAoIXdiwVZsEfBFpEu48F986eo959/
=hmnn
-----END PGP SIGNATURE-----

--bLbPh3C4LUEQ8KcCQ8uDlgHFLLDWPCmHC--

