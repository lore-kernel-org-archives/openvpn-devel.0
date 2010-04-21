Message-ID: <4BCF0259.8070902@...1347...>
Date: Wed, 21 Apr 2010 09:49:13 -0400
From: Richard Monk <rmonk@...1347...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enig5F1317D6F3F1A6B79F420444"
Subject: [Openvpn-devel] Slight modification to the contrib client.up
 script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F1317D6F3F1A6B79F420444
Content-Type: multipart/mixed; boundary="------------030809070000020904000305"

This is a multi-part message in MIME format.
--------------030809070000020904000305
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had an issue come up where the clients were getting DNS entries in the
reverse order the server sends them when using the client.up contrib
script.  Since the DNS servers on our system are in order from
closest->farthest network wise from the VPN server, having them
backwards caused some performance issues.

I've attached a patch that puts the DNS entries in the correct order
that the server sends them.  Can this be updated in the next release?

--=20
Richard Monk (rmonk@...1347...) - Security Analyst
Red Hat - Centennial Office: Raleigh, NC USA
+1 (919) 890 8501
GPG Key ID: 0x1EBEF129

--------------030809070000020904000305
Content-Type: text/plain;
 name="dns-order-client.up.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dns-order-client.up.patch"

LS0tIGNsaWVudC51cC5vcmlnCTIwMTAtMDQtMjEgMDk6MTk6MjkuNDIzNTYzNTIyIC0wNDAw
CisrKyBjbGllbnQudXAJMjAxMC0wNC0yMSAwOTozNzozMS40MzQ1NjMxOTIgLTA0MDAKQEAg
LTcsNiArNyw5IEBACiAjIHNvbWVvbmUgYXQgYm9sZGFuZGJ1c3RlZCBkaW5rIGNvbQogIyBo
dHRwOi8vd3d3LmJvbGRhbmRidXN0ZWQuY29tLwogCisjIEVkaXQgYnkgUmljaGFyZCBNb25r
IDxybW9ua0ByZWRoYXQuY29tPiBBcHIgMjEsIDIwMTAKKyMgTG9hZCBETlMgZW50cmllcyBp
biB0aGUgc2FtZSBvcmRlciB0aGUgb3BlblZQTiBzZXJ2ZXIgcHJvdmlkZXMgdGhlbQorCiAj
IFBVUlBPU0U6IFRoaXMgc2NyaXB0IGF1dG9tYXRpY2FsbHkgc2V0cyB0aGUgcHJvcGVyIC9l
dGMvcmVzb2x2LmNvbmYgZW50cmllcwogIyBhcyBwdWxsZWQgZG93biBmcm9tIGFuIE9wZW5W
UE4gc2VydmVyLgogCkBAIC00Myw2ICs0Niw4IEBACiB1bnNldCBkbnMKIHVuc2V0IG9wdAog
CityZXNvbHZDb25mPSIvZXRjL3Jlc29sdi5jb25mIgorCiAjIENvbnZlcnQgRU5WcyB0byBh
biBhcnJheQogCiB3aGlsZSBmb3B0PWZvcmVpZ25fb3B0aW9uXyRpOyBbIC1uICIkeyFmb3B0
fSIgXTsgZG8KQEAgLTYxLDE0ICs2NiwxNiBAQAogCiAjIE5vdywgZG8gdGhlIHdvcmsKIAor
aT0xCiBpZiBbIC1uICIke2Ruc1sqXX0iIF07IHRoZW4KLQlmb3IgaSBpbiAiJHtkbnNbQF19
IjsgZG8KLQkJc2VkIC1pIC1lICIxLDEgaSBuYW1lc2VydmVyICR7aX0iIC9ldGMvcmVzb2x2
LmNvbmYgfHwgZGllCisJZm9yIGRuc1NlcnZlciBpbiAiJHtkbnNbQF19IjsgZG8KKwkJc2Vk
IC1pIC1lICIke2l9IGkgbmFtZXNlcnZlciAke2Ruc1NlcnZlcn0iICIke3Jlc29sdkNvbmZ9
IiB8fCBkaWUKKwkJbGV0IGkrKwogCWRvbmUKIGZpCiAKIGlmIFsgLW4gIiR7ZG9tYWlufSIg
XTsgdGhlbgotCXNlZCAtaSAtZSAiJGosMSBpIHNlYXJjaCAke2RvbWFpbn0iIC9ldGMvcmVz
b2x2LmNvbmYgfHwgZGllCisJc2VkIC1pIC1lICIkaiwxIGkgc2VhcmNoICR7ZG9tYWlufSIg
IiR7cmVzb2x2Q29uZn0iIHx8IGRpZQogZmkKIAogIyBhbGwgZG9uZS4uLgo=
--------------030809070000020904000305--

--------------enig5F1317D6F3F1A6B79F420444
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEAREKAAYFAkvPAlkACgkQb7MZRB6+8SmwVgCeIErktbRJmDXyigblsddcLUqw
fNUAnRT84ioR5NICgePUIZUOOXGXwrLu
=q7Dq
-----END PGP SIGNATURE-----

--------------enig5F1317D6F3F1A6B79F420444--

