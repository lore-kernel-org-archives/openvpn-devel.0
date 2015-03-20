Message-ID: <550C4A34.3000401@...515...>
Date: Fri, 20 Mar 2015 18:26:28 +0200
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <AMSPR07MB232F26EA163FA5FB6ACEA0EC1010@...2021...>	<550AD5A3.9040201@...515...>
	<550B4623.6000609@...1490...>
	<AM3PR07MB2250C04AEA819AB8748A362C10E0@...2023...>
In-Reply-To: <AM3PR07MB2250C04AEA819AB8748A362C10E0@...2023...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kccq8LUEQItq8wc910JWFrwN31JWrq3Cc"
Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ryan O'Connor <ryanoconnor@...2020...>, Jason Haar <Jason_Haar@...1490...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kccq8LUEQItq8wc910JWFrwN31JWrq3Cc
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

If you search the archives of this list (or possibly openvpn-users), you
will find an earlier mail from Jason Haar which had instructions on how
to configuring OpenVPN to run inside nssm.exe.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Hmm Interesting idea.
>
> I will grab a copy of NSSM and give it a try.
>
> So does it need to be constantly running on the client machine or is it j=
ust a service installer that you setup the service and its parameters (im g=
uessing what .ovpn connection to run) and it will install it?
>
> Thanks for the recommendation!
>
> Ryan
>
> -----Original Message-----
> From: Jason Haar [mailto:Jason_Haar@...1490...]=20
> Sent: 19 March 2015 21:57
> To: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8
>
> Unless other changes have been made to the windows service, I'd recommend=
 not using it at all. There are error conditions under which it just hangs =
and blocks openvpn.exe from working
>
> We moved to using nssm - we set it to auto-restart on error and now openv=
pn as a Windows service is as reliable as openvpn as a Unix service
>
> Jason
>
> --
> Cheers
>
> Jason Haar
> Corporate Information Security Manager, Trimble Navigation Ltd.
> Phone: +1 408 481 8171
> PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1
>
>
> -------------------------------------------------------------------------=
-----
> Dive into the World of Parallel Programming The Go Parallel Website, spon=
sored by Intel and developed in partnership with Slashdot Media, is your hu=
b for all things parallel software development, from weekly thought leaders=
hip blogs to news, videos, case studies, tutorials and more. Take a look an=
d join the conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> -------------------------------------------------------------------------=
-----
> Dive into the World of Parallel Programming The Go Parallel Website, spon=
sored
> by Intel and developed in partnership with Slashdot Media, is your hub fo=
r all
> things parallel software development, from weekly thought leadership blog=
s to
> news, videos, case studies, tutorials and more. Take a look and join the=
=20
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel




--kccq8LUEQItq8wc910JWFrwN31JWrq3Cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlUMSjkACgkQwp2X7RmNIqPFCACgqjQtGmhFPimMwWne46FFRPPC
MxwAoLfZTUhBPcHzfxFB4SWedC6l5k1g
=QHxs
-----END PGP SIGNATURE-----

--kccq8LUEQItq8wc910JWFrwN31JWrq3Cc--

