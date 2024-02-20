Date: Tue, 20 Feb 2024 17:22:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZdTRrAPWi-omptpa@...1296...>
References: <20240219192822.2477258-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0I+eLYbxP6EuVJb1"
Content-Disposition: inline
In-Reply-To: <20240219192822.2477258-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Document that auth-user-pass may be
 inlined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--0I+eLYbxP6EuVJb1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 19, 2024 at 02:28:22PM -0500, selva.nair@...277... wrote:
> Does this have to go through gerrit?

As of today, there's two ways to inject patches / patch sets for
"openvpn main" - the openvpn-devel@ list, "as always", and gerrit.

Gerrit is nice for larger and more complex patchsets, because review
can happen in pieces (=3D you can review the first half today, comment
on the web, it will remember which parts you have seen already, and
do the rest tomorrow), and also gerrit can do stuff like "so what
changed from v4 to v5?" meta-diffs.

For smaller patches "single file, trivially correct", openvpn-devel@ is
less work for me :-)

So - what is "better" depends.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0I+eLYbxP6EuVJb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJl1NGsAAoJEB2Cnv7KVigSGxEMAKlZR8trvqfn1VHxz8oFLxo2
GzCWKl0a9pekvnnlFk8WyeVpVLc2Xc3CAm/3cakIkA+RnE6EM+h+YCJz5cbdj37j
ReT81vnSK2U2y/NKwbJ0pSlhnWwIPql9jZRyCtxfcOaXMHslhHCWtWNIKmfqY13n
0c5tL1Adn7vTGq0zPvFB6MQScHoxRzNzaZK3cq/bhdR+Ai79qQMIxhq7veogwIZe
+mz+oJsOuswEpEuZkIl/rDVwX9Lza6zkmNtXJ+et2tGMm+8gNCJHKz7JvXJ8zZLh
X1tlfeHz5GJnzhLk1l1JBuTvZOMKEMabAhUusa0H3EiZXABW9D7mY4APy1zGiwZF
0KYqgwMrF5lxUnWHDuOH8Nsd/oKR2tYCc3RcMpeNovujXk+fG1cTYW1doo8gqWga
rH/j80BSSGI585Kgj2HTLsy9R6RzU6eX6yUOdppsZGV578KyU2OXUyk56COL1gkC
Ax8TEXaK83mu7oTwvWIanAKkJF7WgqRYjKIWRcRU7A==
=XFB6
-----END PGP SIGNATURE-----

--0I+eLYbxP6EuVJb1--

