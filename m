Message-ID: <4EE52A57.1040906@...1338...>
Date: Sun, 11 Dec 2011 23:10:31 +0100
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
In-Reply-To: <A273A2F6519C0D42BFF02CA9C6A825112D003E1E@...1531...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------enig46E1C5E93B8240FE1DEB864C"
Subject: Re: [Openvpn-devel] Problem with alloc_buf_gc function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tiran Kaskas <Tiran.Kaskas@...1530...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46E1C5E93B8240FE1DEB864C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tiran,

Am 11.12.2011 21:57, schrieb Tiran Kaskas:
> Looking into the function alloc_buf_gc() in file buffer.c, it returns a
> struct buffer, which seems to me is allocated on the stack, which is
> causing an issue, I believe, since the function calling alloc_buf_gc()
> will work on a buffer which becomes garbage.

'alloc_buf_gc()' is returning 'buf' (of type 'struct buffer') by value,
not by pointer, so there is no problem here.  If it were returning 'buf'
by pointer your observation would be correct.  (In C++ a typical mistake
would be to return 'buf' by reference.)

The function calling 'alloc_buf_gc()' will copy the contents of 'buf' to
its local instance of 'struct buffer' before continuing.  (An optimised
build might even eliminate the copy.)

Are you observing a specific problem with buffers or did you just happen
to stumble over this piece of code?

Cheers
Fabian


--------------enig46E1C5E93B8240FE1DEB864C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJO5SpqAAoJEPGZx5Q4PJrzsLoP/iSzvoXKyV+/I+HoW/9uCX0o
/qeUtJmzQlwBxSEiCSaI+UCOVjdAEBST3w2EbW+6z9PksvQ5MIVGrgPSDpGZYSDY
EQgG4nzqV9fdCQ2hrb/xV+T7Vn8mIMuKG/C+TQDhxa3rygHCg+cLouJHgR2Z0t08
hDpI81sSIErehbWmKC9M6eip+x8FA0LxPpN2iB55M0CHkpEKJSTo7kDEFQcizkt2
Qae2ldTq3tnRPV27R8Ptokpk6ZT6fp0KsS4qpxtaSVlvYo/dn2FeJfaZWlnBTTy2
Z/PFCrbWGKBiuuOlynSBSBkUaZF/duUJWL71kXUSLzlhkHIetVUrjjetXUlS749a
wZ+v5GMjznE6mhlOB6RoCPFurAGW1x91clTZZcmclcmTX+Tpdfa/KiISwf0AllEl
HB/2GQvdo/PdVXV0P3p0Nkyxf1sWxYvlOqd6K+2eiqnzery7aGRnjv8HZ7TK+HRU
Or4avV/36MuIRNlliOS/6/Xzqr2lN5cuoONLY/KA764KIjzqKbHxh49/SoiK+wf1
GnuEi/X6rxJh7MbZRYYRIdAcWqGlrULBxQr0lFz7oTJXg73o9MB0KAG8dDuDX7bo
bI3qLSGmiG4rchDmo5nkh8EoEPzt6CX2NOxMvsUzwaB33uud4VOWYbmxBxo4g8Zi
KehxoHl5546EwVqQx8HG
=ysQx
-----END PGP SIGNATURE-----

--------------enig46E1C5E93B8240FE1DEB864C--

