Date: Thu, 24 Aug 2017 20:40:45 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20170824204045.2937b4d6@...1799...>
In-Reply-To: <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
 <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G=BjGCylUgZ3f85ALDhnvDI"; protocol="application/pgp-signature"
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

--Sig_/G=BjGCylUgZ3f85ALDhnvDI
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Thu, 2017/08/24 20:16:
> On 24/08/17 09:57, Antonio Quartulli wrote:
> > My effort in writing the commit message has been quite poor.
> >=20
> > The assignment is useless because 'ret' is re-assigned a few lines later
> > without ever being read.=20=20
>=20
> Hmmm.  I'm not convinced of this change.  But I'm also weird in these
> cases :)
>=20
> I think it is good defensive programming to predefine the state of
> variables.  When that is not done, it is up the the compiler to decide
> what to do - which most of the times does a sane job these days.  But
> you're at the mercy of the compiler.
>=20
> In this case,  I would expect the compiler to optimize this out anyway,
> regardless of the approaches used.  The compiler doesn't necessarily set
> the value first to true and then to change it to the output of
> multi_process_post().  It might just as well postpone the declaration.
>=20
> So I think a better approach would be to completely move the "bool ret"
> down.  So it will become:
>=20
>    bool ret =3D multi_process_post(m, mi, mpp_flags);
>=20
> Which I think is also closer to what the compiler would end up with anywa=
y.

ISO C90 forbids mixed declarations and code in C. Probably compilers will
start to complain.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/G=BjGCylUgZ3f85ALDhnvDI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlmfHa0ACgkQiUUh18yA
9HbR/ggA4Hp+ugShlUqpNKn1o5G5pdrHI+BO0fnxxJ58nTAQ6/5nIDtrdjZcv9n0
0LdRviCOSg4RnaBw5G36DEL3Y4gaLkxW731yXlvGud0c7YcrrQyvmxo8D57LL1Sn
Rxa4jH1VP3B9OG6r4OaTgYnfwCGxbi81EKiTXmbkLvCt5/bPVzS4b5Fq6stHqYRf
iTBolCaVEKTPk603JYni655wua881DQNc3POHU/aVPy/ToKCvPe3S8jtKrJUdAJc
8PrJy1xuFYSGRTfHN/YiolVFcIhUu8SuJ/T35h/kTiPU4sTJyKlAIlsQIzKKSar6
Ec9AnuAsHUM6OOtoRZ7B8DpKlnUNfg==
=djUW
-----END PGP SIGNATURE-----

--Sig_/G=BjGCylUgZ3f85ALDhnvDI--

