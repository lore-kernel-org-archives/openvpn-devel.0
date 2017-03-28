Date: Tue, 28 Mar 2017 14:47:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170328124704.GW93896@...1296...>
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
	<20170327183502.GJ93896@...1296...>
	<CAKh=nwE-U4C6CVw+XpdBE1RXjG_VOYoT=UuJDAPs2AOFOoP+jw@...278...>
	<668fd081-d9b4-1727-f506-07395cf0b475@...1435...>
	<8c8a5600-0e9a-eb04-41de-33ebfdf36bfd@...2080...>
	<20170328122131.GV93896@...1296...>
	<131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eFSocvuHqSR2dX+c"
Content-Disposition: inline
In-Reply-To: <131d865b-fd4d-0c8c-df75-eadc3fb4c658@...2080...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--eFSocvuHqSR2dX+c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 28, 2017 at 02:35:59PM +0200, David Sommerseth wrote:
> On 28/03/17 14:21, Gert Doering wrote:
> > On Tue, Mar 28, 2017 at 02:11:26PM +0200, David Sommerseth wrote:
> >>> That's great!  This way, 2.4 does not have to change it's behaviour.
> >>> Still, I think it makes sense to deprecate --ns-cert-type, and remove=
 it
> >>> in favour or --remote-cert-tls in openvpn 2.5.
> >>
> >> Based on the feedback and discussions in Fedora regarding to us removi=
ng
> >> --tls-remote .... I actually think 2.5 is too early.=20=20
> >=20
> > Nobody suggested removing --remote-cert-tls.
>=20
> I don't think I tried to say that :)  I mentioned --tls-remote in v2.4
> as that caused quite some noise.  I actually had to add a patch in the
> EPEL packages for EL6+EL7 bringing it back again, to ease these complaint=
s.

Ah, *that* one.  I see.  So "the last time we deprecated and removed=20
one of our zillion stale options, people complained, so we're not going
to do it again"?

We need to communicate better what might affect users in new versions, so
they can test and complain/adjust in time (like, the stricter CRL handling
in 2.4, and - obviously - the --tls-remote bit)


> > This is about --ns-cert-type.
> Right :)
>=20
> >> We need to have a
> >> patch very soon complaining loudly in the log files=20
> >=20
> > Like, 57637d0f677d824dacdc83d858357ccc80723f45? :-)
>=20
> Ahh!  I completely forgot about that patch.  Good!  It's even in v2.4.1
> already :)

Steffan was busy getting work done ;-)

> >> and get in touch
> >> with at least NetworkManager guys to ensure they have time to implement
> >> a solution when this goes away.  So I think 2.6 is more realistic.
> >=20
> > Shouldn't be so hard to do a string-substitution in NM...   with
> > 60b23236329e6921729f51e7689042a29c794a6b, this is really straightforward
>=20
> If the behaviour is really close by doing a substitution, this should be
> good enough.  --tls-remote to --verify-x509-name is more complicated,
> due to character remapping and such ugly details.

Indeed.

So - this is something people need to test on their client/server certs.=20=
=20

Initially, it broke for ours (because the CA sets "more bits than needed",
and that confused the ku test on equality), but with the new check=20
"at least these bits, more are OK" all is fine.

> > (unless your certs are really, *really* weird, providing a proper=20
> > nsCert extention, but no proper keyUsage/extKeyUsage extentions).
>=20
> Well, despite weirdness occurring (Way too) often, I think we can live
> with that noise if we have given enough time to adopt.  As long as we
> have a real and solid argument they have been doing things wrong in the
> beginning.

Indeed, again ;-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eFSocvuHqSR2dX+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY2ltHAAoJEB2Cnv7KVigSLj4L/iNT0ZabS89SKXIzscSh9qjq
X5Y+Z14jw0oqGV6fQ3zupofcOkyM4IjtrT5buMuUCHfM+0J6GhlywYFSENE0qCjM
QbTavh/mlE4vEHZqIBPR8+9/IMPIyju8y+2gzDdf0JEvyOEbeZ2SbKXSpWxWTWtK
AzjkcUAxzIoq7sUvSsAnVsG5RoWH49FqlAm1gA+pPUx2zDawz/RArqmmjfAffumA
hcUNSLNjWDtflWZ35AgzzH7gZzLYKfWcAnZYFU75tJHZh6odUj6JuRB9O8DkDFFk
smZIIiT9BIsEVlfWT5aftaxW04LpleCQn0xz6ABsgowfpaikkUmEpGlqJZodfplR
HfsN10jpJKoMNo29bpW+QlDRzt26SzLAj01lJlpDdmknYKP0ts2j9mV4sWn8uhh+
f3LrKudzkU/mTHdFuzKQiJ811nXf6HrN3mp3WNsMQo0vZiRtHxzH7qye0LVIGPKm
HtEadZMvk0yDHlAAYDWTF/y72ojFC/iv8AYqeq8xqw==
=ktpg
-----END PGP SIGNATURE-----

--eFSocvuHqSR2dX+c--

