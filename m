Message-ID: <52F7AB7E.7000502@...1227...>
Date: Sun, 09 Feb 2014 17:23:26 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <52F6E3AF.1080400@...1030...>	<20140209115057.GT16637@...1296...>	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>	<20140209151951.GU16637@...1296...>	<52F7A006.4010302@...1227...>
	<CAAbSJMWyDjSNdXM6AZPDeevAtR=bBg8C1sbUBY+64hLri2oOLg@...278...>
In-Reply-To: <CAAbSJMWyDjSNdXM6AZPDeevAtR=bBg8C1sbUBY+64hLri2oOLg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="c8NWDGeSOCWSqraSCb7A2EiFIhgUWLbAb"
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mickael Chazaux <mickael.chazaux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c8NWDGeSOCWSqraSCb7A2EiFIhgUWLbAb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


>> Does lport 0 work?
>>
> Yes. I use it (see my previous mail). But it is not documented in
> openVPN, and the use of a port value of 0 in bind() hardly. In the
> source the --lport value is sent to bind() directly, so it happens to
> work. It would be great if --lport 0 were mentioned in the manual, to
> avoid breaking this behavior in the future.
>
>
I might alread have broken this. I am not sure how getaddrinfo reacts to
"0" instead of NULL of servname.

Arne


--c8NWDGeSOCWSqraSCb7A2EiFIhgUWLbAb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL3q34ACgkQe8+cMNS4zRfK5QCgj4xV8rhyfJfcmeZJPhXFdho6
x3IAoNNV1NbBepHY9MbXx/pIzk+zTt5R
=Ummy
-----END PGP SIGNATURE-----

--c8NWDGeSOCWSqraSCb7A2EiFIhgUWLbAb--

