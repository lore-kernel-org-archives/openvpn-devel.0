References: <56211F0D.2010806@...515...> <18065708.JIrWLiTMeq@...2001...>
	<ac7rqc.nwgq22.2u3ktu-qmf@...2076...>
	<2892922.l0hsuaC9oU@...2001...>
	<SN1PR08MB1391C6A8CA4653A464FAC48EB93A0@...2065...>
	<001101d10aaa$ca65c3c0$5f314b40$@gmail.com>
From: ValdikSS <iam@...2070...>
Message-ID: <5626A785.90507@...2070...>
Date: Tue, 20 Oct 2015 23:43:49 +0300
MIME-Version: 1.0
In-Reply-To: <001101d10aaa$ca65c3c0$5f314b40$@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sxxfJwf3eI4PJeXhxcRArtpORBK7Qh0PC"
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>, "'Morris, Russell'" <rmorris@...1315...>, 'Heiko Hund' <heiko.hund@...1489...>, samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sxxfJwf3eI4PJeXhxcRArtpORBK7Qh0PC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

By the way, there is an open-source SecurePoint VPN client (https://sourcef=
orge.net/projects/securepoint/) which handles current versions of Windows v=
ery well.
And here is my list of available open-source OpenVPN GUIs: https://gist.git=
hub.com/ValdikSS/9d7b13b5ef510c6b6d45#file-openvpn-guis-md

On 19.10.2015 23:14, Fish Wang wrote:
> Regarding Windows OpenVPN GUI: I have an internal fork of this OpenVPN GU=
I (https://github.com/jochenwierum/openvpn-manager) from jochenwierum, with=
 many bug fixes and improvements, and it works fairly well on Windows. Mayb=
e I should tidy my patches and open source it on github?
>
> Best,
> Fish
>
> -----Original Message-----
> From: Morris, Russell [mailto:rmorris@...1315...]=20
> Sent: Monday, October 19, 2015 7:59 AM
> To: Heiko Hund <heiko.hund@...1489...>; samuli@...515...
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
>
> Hi,
>
> Just a couple thoughts here, from a (absolutely!) non-expert ... :-(.
>
> I have been trying to develop my own "GUI" - not because the current one =
doesn't work (not at all!), but because I want a bit of an extended feature=
 set ... to be able to change Tray Icon color with traffic (Tx/Rx), and plo=
t ping timing to a remote machine over the link, and as well traffic and bi=
t rate plots in the UL and DL.
>
> That all said, I can definitely see that the network adapter (TAP) and op=
envpn.exe really are up and down (a lot!) on Windows ... :-(. I am trying t=
o use NSSM to at least keep openvpn.exe up (i.e. restart it), but the netwo=
rk connection is a challenge also - often having to be reset (disabled and =
enabled). So to the question below ... yes, Windows does need some work.
>
> I'd be happy to help out - but as above, I'm not an expert. So definitely=
 willing, but usefulness may be questionable unfortunately ... ;-).
>
> Thanks!
>
> ... Russell
>
>
>
> -----Original Message-----
> From: Heiko Hund [mailto:heiko.hund@...1489...]=20
> Sent: Monday, October 19, 2015 9:16 AM
> To: samuli@...515...
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
>
> On Monday 19 October 2015 10:20:23 samuli@...515... wrote:
> Ok, I think here is the main misunderstanding. My understanding was that =
you
> want a Windows development team. That I think would be counter productive=
. For
> the other topics I do not have a opinion.
>
> No, and I do not think that the service should take care of that. That's
> rather things that can be handled by the GUI.
>
> Hehe nice turn demanding proof, that'll shut up ppl. =3D)
>
> Heiko
>
>
> Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karls=
ruhe, Deutschland
> Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... ww=
w.sophos.de
> Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
> Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilp=
ert, Jennifer Onslow.
> Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
> Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... w=
ww.sophos.de
> Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=
=C3=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Je=
nnifer Onslow
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--sxxfJwf3eI4PJeXhxcRArtpORBK7Qh0PC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWJqeHAAoJEFzXIC7viPdyLpkQAJ9zZO3Bv16s5fmOvOsFYiWS
zFtiPabF8Qq+LWlV5RcvngXa++6q+bRMbMC1I7g3UwVEa6jp7I1yuX1QoqGF72JO
3irYXtdIm6U1EuRjioHI0jZvfDpTp1cl9vmHFKi9EKrWnbJZ94MMbH3AP2TLYs/m
K0RpoTQte/MlctMYfk20drtvVkcrzPtOK4RPw0rhlwzwfuoZDmafs/qMtsAjhj5d
stONCDKCBRP2+DnlCzQgPuPfVTGwgxjiJbw+Vij/TVaixiq9qGnEi4NVWvrMK8AC
hCHeH6zNUZMA99EXAQKNYqNVaQFKzsXNwdoFsH/3cxZeJ5t8EqMP8A3nTV8Sk70R
Qu1zYP7OZuRZkFTmkAQnWpuygEl6QU/jZ/KnMG3ZhbtDBTckpYZZHsFtNOvtEUsa
OzxMYUCYW3iEkHIDQQB0kIUWO78HTVIsrCWADCpb/CvfXgYILGqJ6DVo39D8Xf1C
Oa9q0NPWVY3tD7+r2DDaD50ScFFJ5TS8AecknMidOOc0Ke+Hr6hu9+Xvy8UswP8K
RwNGnZmMjABIengj78Y25nbWcHppMxN71pq9hu3vpVYK5pxcXIRQ0b3C8iOoZcs6
o2BAel1Z+ZX+QUSY1yx4SQgRaE0PbILtEoicbunm8U5zq5cFTpm4CVZ1QSGeZCzJ
b4DH9nPpLZjXdh7cjpei
=v70W
-----END PGP SIGNATURE-----

--sxxfJwf3eI4PJeXhxcRArtpORBK7Qh0PC--

