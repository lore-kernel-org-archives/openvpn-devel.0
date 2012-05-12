Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4E79D1C9-C51B-44E5-A9B8-2785C87E61A3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
Date: Sat, 12 May 2012 17:22:52 -0400
Message-Id: <363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_4E79D1C9-C51B-44E5-A9B8-2785C87E61A3
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

My two cents on this is as follows:

As a package maintainer, I think this is going to prove to be a lot of work=
.  It means there are more packages to maintain, over the one I need to now=
.  HOWEVER, from the OpenVPN development process, I think it's best to spli=
t things out, as Alon suggests, with one caveat.  Let's wait for 3.0.  That=
's already going to be a massive change to our source tree and overall buil=
d process, and I think it would be the right time to push that out.

Hope this helps.
-----
Eric F Crist


--Apple-Mail=_4E79D1C9-C51B-44E5-A9B8-2785C87E61A3
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJPrtStAAoJEHKWQhk5DQ0OM2gH+gLNoxe1o1TAGx0AvQOJqphT
r7bVZ6W5ooWavjtMBb0Hj9qPJ5mgqYlCiIBzGuowUoJSEDWJTk0ThYEGYIBALETZ
ThLuEeUoAe0uveiAcXGTFVkgT+fZWxYc0uH47XAq+hZD11+4rJ1Q0kJGKTmfPkr1
SjJmd/5KzjmIm1mI+Ue1PXX+2b4koe4/TuoHjWzOeia84y3jD+HoapLSn+X0AuH9
i2wiFjX5VJf6L+NnC0qe7f2t7yEp/m+cVaLMnTk0oFAB7yRzEW4Jmjw9xAnSnzfA
iCxU+c9OYFbEurBRueEUdMRN/2FLTpL+idmGfYUJbJ77M/oaTIQeMDW8hkW18W4=
=yo94
-----END PGP SIGNATURE-----

--Apple-Mail=_4E79D1C9-C51B-44E5-A9B8-2785C87E61A3--

