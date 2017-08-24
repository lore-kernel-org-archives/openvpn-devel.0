Date: Thu, 24 Aug 2017 20:55:12 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20170824205512.2d89b29d@...1799...>
In-Reply-To: <4f5262ab-4a6e-83e1-2950-35db895ddf22@...2080...>
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
 <20170824204045.2937b4d6@...1799...>
 <1749ebf9-6823-5420-3bcf-79b72eae2e76@...2181...>
 <4f5262ab-4a6e-83e1-2950-35db895ddf22@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QI49J_7cHSLyy7fXGA6xfUi"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <a@...2181...>

--Sig_/QI49J_7cHSLyy7fXGA6xfUi
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Thu, 2017/08/24 20:51:
> On 24/08/17 20:40, Antonio Quartulli wrote:
> >=20
> >=20
> > On 25/08/17 02:40, Christian Hesse wrote:=20=20
> >> David Sommerseth <openvpn@...2080...> on Thu, 2017/08/24
> >> 20:16:=20=20
> >>> On 24/08/17 09:57, Antonio Quartulli wrote:=20=20
> >>>> My effort in writing the commit message has been quite poor.
> >>>>
> >>>> The assignment is useless because 'ret' is re-assigned a few lines
> >>>> later without ever being read.=20=20=20=20
> >>>
> >>> Hmmm.  I'm not convinced of this change.  But I'm also weird in these
> >>> cases :)
> >>>
> >>> I think it is good defensive programming to predefine the state of
> >>> variables.  When that is not done, it is up the the compiler to decide
> >>> what to do - which most of the times does a sane job these days.  But
> >>> you're at the mercy of the compiler.
> >>>
> >>> In this case,  I would expect the compiler to optimize this out anywa=
y,
> >>> regardless of the approaches used.  The compiler doesn't necessarily =
set
> >>> the value first to true and then to change it to the output of
> >>> multi_process_post().  It might just as well postpone the declaration.
> >>>
> >>> So I think a better approach would be to completely move the "bool re=
t"
> >>> down.  So it will become:
> >>>
> >>>    bool ret =3D multi_process_post(m, mi, mpp_flags);
> >>>
> >>> Which I think is also closer to what the compiler would end up with
> >>> anyway.=20=20
> >>
> >> ISO C90 forbids mixed declarations and code in C. Probably compilers w=
ill
> >> start to complain.=20=20
> >=20
> > We try to stick to C99. I think it allows such mix, no?=20=20
>=20
> That is correct.  We set -std=3Dc99 unless CFLAGS already contains -std=
=3D.
> But we expect OpenVPN to be C99 compliant.
>=20
> And C99 allows this.

You are right... So scratch my concern.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/QI49J_7cHSLyy7fXGA6xfUi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlmfIRAACgkQiUUh18yA
9HYe8wf+O+2r3wObPw4zJHkl8lstv7VijVVu5qtH0yyqDne9f5zgr7ibRTKSAsgb
A1IgzQvRltlgaFwWC2qh93ced/MMcaYUj4jZ1DA02sjXyK5Hq+g5w6SIlIKSw+Gt
OjVE4ZPmCKSV/RguflHn0RgMd8j9CCwaj3llE9Uk+0EWi47Xg63UfZlX4LzsB8mE
sSNs7UKy4Cm3BL7itr+bQPE9JrqdbEsBl+gzO4KRdyYqiiDB2s21y5zTtV4GiHR8
tzRBNIq2njeW/fKA+jqIc49aIyDZh55hTl17f78JrUE+Ga51O8rBEyDo+6o6dOK/
3jjZTZBBXKYqrhVJDXFFOPxf6EdZFw==
=deEI
-----END PGP SIGNATURE-----

--Sig_/QI49J_7cHSLyy7fXGA6xfUi--

