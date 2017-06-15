From: Antonio Quartulli <a@...2181...>
Message-Id: <82761970-4D2B-4102-A33C-684829FA01B6@...2181...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_321D4AAC-74BA-4954-B41E-9359363EAD4D";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 16 Jun 2017 07:19:44 +0800
In-Reply-To: <9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
	<20170615074739.GI97029@...1296...>
	<1649446.B7buzjzcZ2@...2279...>
	<9e766589-ac6e-e418-1b07-41a2889e0a17@...2080...>
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Steven Haigh <netwiz@...2277...>

--Apple-Mail=_321D4AAC-74BA-4954-B41E-9359363EAD4D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> On 16 Jun 2017, at 06:01, David Sommerseth <openvpn@...2080...> wrote:
> That said ... this needs to be changed, I think it makes sense to take
> some action to reduce this possibility.  By manipulating pointers
> provided to you via the the plug-in interface, you can make the OpenVPN
> process crash and burn ... and it is fairly easily.  If you manage to
> modify memory regions too much so other OpenVPN data structures gets
> corrupted, it will explode in interesting ways.

What happens if a plugin crashes on its own because of a segfault (for exam=
ple)? I think the entire openvpn process will crash, right?
If I am right, this means that protecting openvpn private objects is not re=
ally going to save the process from a possible horrible death.

>=20
>> If so, should these changes also be in the client-connect script?
>=20
> That should not be possible.  There exist no direct API to modify the
> environment variables from plug-ins, that is purely a side-effect if how
> the memory buffers and pointers sent to plug-ins are handled.
>=20
>> If not, the environment might need a reset before the auth-user-pass-ver=
ify
>> script is called?
> Either reset (which I think is harder) or to copy the information into
> new fresh buffers which are discarded once the plug-ins returns.
>=20

I second this idea - sounds easy and protects the openvpn env from changes.=
 (assuming this is not done on a fast path, because a full blown copy of th=
e env might have perf issues).

Cheers,


--
Antonio Quartulli




--Apple-Mail=_321D4AAC-74BA-4954-B41E-9359363EAD4D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZQxYVAAoJENPhyAjNbKBQYWMP/3MPCxYFuENf2ze6TZKmU5WO
8swvz2EsXxQVZ/K6R0lGFhYYI3nIMgeQW2YHix72EEEovJJg4osA7Xt7k3XMvQEv
95I7dqKSdJ7HDxaAKbHTh1DGxobPSdPE2ZHLqoss+P8gaBffi3h7OV3Nt1r7vvAn
MaLx0sCLCp7uJU6GURLQp8oW2dM6lssQXKGMeD8TJaD83gDjd2Gd2Mn7UleBVRN1
8ohDkCD33tVyD4TfMmHvHGlKUQeKQrgC3j3hjsRAXQzEgKxa2oZnmOiPbH4ZEeUx
rt+vlfN0c/m0eU/56ZC4M+rFf3DMok8hmN+JZE8EPR5BrpDP9nVCdgSEHGLI7kFE
K+pK5AxtNGXb9tI87mXCi6S7r3zwRRkOImebNFjjeRJ+0ayuhCLeEY1NR2LuhR/X
WSP1s+YhPjtcEvAsfyDnwHal7nBD/HndprkOirH4oomegm/ZnS2EcO8IAMQO/G8v
lO5X3j7clHt4xI5p2y+z18Twb2bPcg6lVusaInsa0WrM2dYBUmbfSg4TZL0J9COg
tyT4uB+/29i7ZuQlicRt1ghDEza61J8DHBOB/ZBboAVCA+1H+Jy5ys+Rf/i47wA1
u0VeObFDBhJwkrqI+pfZGCf05dRTLcRnRT5Ul/nbop0UAvmTZqg9rvNfg3C/b5tH
DiMse3gtfTY2LJZicd3+
=gXrn
-----END PGP SIGNATURE-----

--Apple-Mail=_321D4AAC-74BA-4954-B41E-9359363EAD4D--

