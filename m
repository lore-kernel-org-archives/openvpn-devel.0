Date: Mon, 20 Feb 2017 13:29:00 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170220132900.050e2b1e@...1799...>
In-Reply-To: <CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
	<20170219174934.GK93896@...1296...>
	<CAKh=nwGOyR6reYpPvxqFVRKGDhpn7fLmw-GNBjMy=bJrqKTPmw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/l.NJgyqp/UAgQJV5Z.ULoGV";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/l.NJgyqp/UAgQJV5Z.ULoGV
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Emmanuel Deloget <logout@...260...> on Mon, 2017/02/20 12:45:
> Hello,
>=20
> On Sun, Feb 19, 2017 at 6:49 PM, Gert Doering <gert@...1296...> wrote:
> > Hi,
> >
> > On Sun, Feb 19, 2017 at 01:03:45PM +0100, Steffan Karger wrote:=20=20
> >> Thank you very much.  You approach looks good to me, and quite closely
> >> matches what I had in mind for when I would find the time to tackle
> >> this.  (Which might have taken me a while, so really happy to see these
> >> patches!)=20=20
> > [..]=20=20
> >> Also very good that this is split up into small and independently
> >> reviewable patches.  I'll start review soon.=20=20
> >
> > While Steffan is our resident expert on nasty crypto libraries, I just
> > want to echo the sentiment - having these "chunks" tackle one API funct=
ion
> > at a time, they are easily testable, and in case something explodes, it=
's
> > much easier to bisect to find the problematic one.
> >
> > Now back to being a commit slave for Steffan's ACKs :-)  (I do not know
> > the APIs well enough to properly comment on the changes, I can only run
> > tests...)=20=20
>=20
> I resumed the work this morning. So far the results are :
>=20
> * 0.9.8zh --> EVP_PKEY_id() is not defined. I'm adding this to
> openssl_compat.h and will provide a v2 patch with the change. Once
> added, OpenVPN compiled successfully and was able to connect to my
> /2.3 server.
>=20
> * 1.0.0t --> compile OK, connect OK
>=20
> * 1.0.1u --> compile OK, connect OK
>=20
> * 1.0.2.k --> compile OK, connect OK
>=20
> * 1.1.0-git --> compile OK, failure to connect. I'm currently
> investigating this issue. I'll  provide a patch as soon as I fix this
> (this is a bit ironic ; I may have forgotten something somewhere...).

That matches my findings. Built against openssl 1.1.0e (Arch Linux package
openssl 1.1.0.e-1 [0]) the build itself succeeds, but 'make check' reports
lots of cipher failures.

Are your patches available from a public git repository?

[0] https://www.archlinux.org/packages/staging/x86_64/openssl/
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/l.NJgyqp/UAgQJV5Z.ULoGV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliq4QwACgkQiUUh18yA
9HbsBQgAt9kSHdIMND56so22n6+pqgsMwZqZi/c7BNTGCAZ5orWS0YJCRYtHGhaK
0a2weiFfH78LTRZbwVGnQw7XjRANTncHn+JJGCgqRKqXvAngHhusi+7jE25klGUg
KAL2lV/x3YT9YzSFuENMvFBVbwvEWC4qYlayB+NX60X9JWWcwC3LKzQxnWA3qXf9
we7Z0z0cdCUp2xQHeDqQoSNiXFdeV8wDq7W5jxXQ95H2NLZHu+6+nKzn8LDn3ErZ
PijhF+lGZR849Vi2iYi+nk1e/6gCUFEsNHne60y/lcFQovKEgAt05L+PNOx8MTXI
HUNTiq96X4oB7F3goT3c1tajEum5cA==
=eLek
-----END PGP SIGNATURE-----

--Sig_/l.NJgyqp/UAgQJV5Z.ULoGV--

