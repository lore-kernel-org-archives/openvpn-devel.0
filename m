From: Arthur Titeica <arthur@...1389...>
Date: Tue, 20 Jul 2010 23:08:25 +0300
References: <4BC96D34.3000408@...515...> <201007192332.28862.arthur@...1389...>
	<4C44D0EB.4040703@...1114...>
In-Reply-To: <4C44D0EB.4040703@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2344893.8ojFtTxg2a";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007202308.30058.arthur@...1389...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Does --multihome work in latest
	OpenVPN release?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--nextPart2344893.8ojFtTxg2a
Content-Type: Text/Plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 20 July 2010 01:25:47 David Sommerseth wrote:
> On 19/07/10 22:32, Arthur Titeica wrote:
> > On Sunday 02 May 2010 02:34:47 Peter Rabbitson wrote:
> >> David Sommerseth wrote:
> >>> On 01/05/10 21:39, Peter Rabbitson wrote:
> >>>> Peter Rabbitson wrote:
> >>>>> Peter Rabbitson wrote:
> >>>>>> Samuli Sepp=C3=A4nen wrote:
> >>>>>>> Hi,
> >>>>>>>=20
> >>>>>>> Is someone successfully using the --multihome option on latest
> >>>>>>> OpenVPN release? Or is this bug report still valid:
> >>>>>>>=20
> >>>>>>> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D562099>
> >>>>>>=20
> >>>>>> I am sorry I dropped the ball on testing that one. Will test the
> >>>>>> coming night EST, and update.
> >>>>>=20
> >>>>> Looking more at the *debian* changelog, I see that there was a 3rd
> >>>>> party ipv6 patch, which *could* have caused these problems. However
> >>>>> it is not very easy for me to compile a "clean" openvpn on the
> >>>>> multihomed server. Please let me know if this can be diagnosed in
> >>>>> any other way, if not - I will find a way to test with vanilla
> >>>>> openvpn.
> >>>>=20
> >>>> And unfortunately I was right (proven with the help of [1]) :(
> >>>>=20
> >>>> openvpn_2.1~rc20-1_i386.deb works
> >>>> openvpn_2.1~rc20-2_i386.deb does not
> >>>>=20
> >>>> The only code-change between the two is:
> >>>>   * patches/jjo-ipv6-support.patch: Added ipv6 support. (Closes:
> >>>>   #307846)
> >>>>=20=20=20
> >>>>     Patch from JuanJo Ciarlante.
> >>>>=20
> >>>> So this got to be the culprit. Attaching a -U10 diff between the
> >>>> sources of both debian packages (not too long):
> >>>>=20
> >>>> [1] http://snapshot.debian.org/package/openvpn/
> >>>=20
> >>> Thank you very much, Peter, for tracking this one down!  One question
> >>> though.  Do you have configuration files and a "how to test it"
> >>> description available which you could share with us?  That would help
> >>> others to test it out as well - and it might help JJO to follow this
> >>> one further.
> >=20
> > Hello,
> > I'm using the latest git
> > (git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git)
> > and multihome doesn't seems to work as far as I've tested.
> >=20
> > I have 2 links balanced with something like
> >=20
> > # ip route show
> > ...
> > default
> >=20
> >         nexthop via x.x.x.x  dev eth2 weight 2
> >         nexthop via y.y.y.y  dev ppp5 weight 1
> >=20
> > and openvpn somehow fails with or without multihome.
> >=20
> > I'm not a programmer but I'dd gladly help with anything else (making
> > tests, patches or even providing a test multihomed openvpn server).
>=20
> (moving over to the developers mailing list)
>=20
> Thank you for your testing!  If you put together some configuration
> files for client and server and a clear description of how to test this,
> that would save a lot of time for us when digging into the code.
>=20
> If your config files makes use of certificates, please make your test
> environment work by using the keys in the source tree, located in the
> sample-keys/ directory.
>=20
> Please try to make the config files for us as close to your setup as
> possible.  This will really help us get closer to understand what
> exactly happens.
>=20
> I have opened a bug ticket on this issue, to not forget this issue.  It
> can be tracked here:
> <https://community.openvpn.net/openvpn/ticket/28>
>=20
> Please report back with configuration files and a description of how to
> prepare an environment for reproducing this behaviour.
>=20
>=20

Hello,
I've managed to setup a test dual-homed server with the following configs:

server: http://psw.ro/tmp/test-server.conf
client: http://psw.ro/tmp/test-client.conf

With verb 6 on the client after successfully connecting thru one of the lin=
ks=20
-  connecting thru the second link hangs for a period of ~10 minutes with t=
he=20
following log:

client-log1: http://psw.ro/tmp/client-log1.log

If needed I'll try to find some time to better describe my network setup.

Thanks.

--=20
Arthur Titeica
PharmEc Software Constanta

--nextPart2344893.8ojFtTxg2a
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJMRgI5AAoJEPQNH/fZRCfhRzIH/0tLoT3mDBhvwaMxs5E9GLjy
V9YcdVQAi/1I/zsiXzw8SKdp0OsgBc8D8ftgZ1cm5vTZkDXuBR2OVEfgpUstqFaz
FXt401U4gRpxlbqYGNcBUDXAgWMC+J5ZTv7sLmnoDhW4X1/Ztt306LsjCNefpxVk
6tb5tfGjhXi9wextXeBOUU4AQ8ekavGskMS8HBYv1ykYyNjhxXooDaaYm6P4ciuX
LMGA/w+Bh9VhiqsI0m/UwxkKeqTxB+eitkeLmSamNOLocnAjgWKYWIRe11ijGjUI
JibDLFutitbcwWLl3enaktS/qkkwuZPCzQFbOIIXrOIyWwotVZy7o+cRNwuHE14=
=NfxG
-----END PGP SIGNATURE-----

--nextPart2344893.8ojFtTxg2a--

