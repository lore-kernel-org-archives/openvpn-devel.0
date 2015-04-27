Message-ID: <553E78D1.4000500@...68...>
Date: Mon, 27 Apr 2015 19:58:41 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>	<552E1111.6010201@...68...>
	<20150415120704.GI382@...1296...>
	<553E4C46.8050809@...1114...>
In-Reply-To: <553E4C46.8050809@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, Yegor Yefremov <yegorslists@...1030...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 27.04.2015 um 16:48 schrieb David Sommerseth:
> Having this said, if you do builds on systems with a more modern
> automake, I do want to encourage people to run 'make V=3D0' or use
> ./configure --enable-silent-rules.  This will ensure we can capture
> compiler warnings far easier.  For now I do consider this fine, as you
> do this explicitly - a different behaviour should be expected when
> using explicit options.
>=20
> When the oldest distro we need to support have a modern enough
> automake, we should revisit this topic of making the 'silent rules'
> the default behaviour - being consistent across all distros.

The question is who needs what information.

I see the dichotomy as follows:

- - Whilst operating on known terrain, as a developer, you can often
ignore compiler command-lines because you usually are acquainted with
what you're doing (and if not, it's time for sleep, sport, or food).
That's "make -sj10 V=3D0" ground.

- - Whilst providing end-user builds, perhaps through automated package
builders, you do want verbose information, in order to avoid round-trips
for asking further questions.  Some build frameworks trigger verbose
builds automatically, other's don't.

(And if you flip the switch for default behaviour, I expect to see other
consumers/end users show up and complain.)

HTH
Matthias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU+eM4ACgkQvmGDOQUufZXmeQCfZzULHSU1evIzOvFp+os7Fdro
7wMAoOzFI6g9h9tREL/RgNkWnsypiO6I
=3D3HdT
-----END PGP SIGNATURE-----

