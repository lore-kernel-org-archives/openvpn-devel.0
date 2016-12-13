References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
Date: Tue, 13 Dec 2016 22:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

So the first phase of the great reformatting is on its way.  I have
just pushed out a reformatting branch to the following repositories:

   https://github.com:OpenVPN/openvpn.git
   https://gitlab.com:openvpn/openvpn.git
     git://git.code.sf.net/p/openvpn/openvpn

This is based on the last master branch, with two additional commits.
 The first commit adds the reformatting script which does the complete
reformatting in a consistent way across the complete source tree.  The
second commit is massive, with the complete reformatting.

Have fun and report back.

Btw.  The reformatting commit is PGP signed using the same key this
mail is signed with.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUGs0AAoJEIbPlEyWcf3yLMAP/R4vVszKHG8bQNAJYtUSKnUd
PFw+DVw+kyaiPnuzrCF1MWrCcV20uC9dTmWivI/7qLxWvk6NlcFTcy9ziXeOitK1
yZE3Xc1n3GsDnV6DBUbbsoHNS0PSJ6GldnyBMSXm7MuxOm1fZYQHems5B+tWA1IW
pA+alUkY+Z2U2VQ2XQbg4tIAwwXiiI9+AkIT+xHRxAiYlrMSJG/Mkw2hFuJCn9sB
8vtWU0h0ckFC60ouR7fsrcEyq307DhKEVmdgjYTv9sgTDlzxMIEsgWhS6PV1MqnB
FH9hKirQ8ATxLY2iE8cofBuD7wbcrxRSSksl9ko8Si7WOiVLq39Gf+G7sj1fBSeG
qB7WvEga32BuIsIJYbvLCBbXSUF7nDytyeqj6w4QLyzEcRyr+c+QRDKwTrLf/mKO
7oJY7KSz78DUefBX1u23njadBu64AKqG7PkWwOQPA/piPXWl0o8M7DeE/OcG+ZS3
Dt1YvJ0PgYjwVSk7oBqBK3NwloMAuHLKYH27V1ZjUmn8GkSho0Na0tAmsMOwHF+f
wlskxKdhDPWzfQXwl2MihxjyexsIKgousglnYMGjI7BImtnYxPRlS3TEmmF0MiFE
IvP5hWQepWinctVOdbsFObKe7MEfMPTBlrOcMpklifQlDFm+iRDNf4QYpxG7UBoE
gnqSLAqeLFjAbof94Crc
=3DeLCd
-----END PGP SIGNATURE-----

