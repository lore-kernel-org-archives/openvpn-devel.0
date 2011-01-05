Message-ID: <4D24515D.8070605@...1114...>
Date: Wed, 05 Jan 2011 12:09:17 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D244153.4040401@...515...>
In-Reply-To: <4D244153.4040401@...515...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Added openvpnserv-specific files
 to	clean target in win/msvc.mak.in
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/01/11 11:00, Samuli Sepp=E4nen wrote:
> This patch depends on patch 2/6. Patch 6/6 depends on this patch. Maybe
> integrating them into one would have made more sense? :)
>=20

Patch 5/6 and Patch 6/6 could be merged.  Patch 2/6 is doing more
changes, but I see the pattern so you might be right that they could all
be merged into one patch.  However small commits isn't necessarily a bad
idea, so I have no complaints about this fragmentation - as long as it
is clear they do belong to each other.  When applying to the tree, I
will probably rearrange the order of these three so they come together.

This patch gets an ACK from me anyway.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0kUVsACgkQDC186MBRfroPDgCcCtu0vjtgRwwe2XnysSRHlD7H
Q0sAnjfpPDUz3kVoTBh/OFPrXO59WAOk
=3Df2pw
-----END PGP SIGNATURE-----

