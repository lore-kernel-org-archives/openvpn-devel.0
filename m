Date: Fri, 12 Feb 2016 15:37:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160212143742.GV24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...>
	<20160212131529.GQ24952@...1296...>
	<CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c45fqceLBNirjcru"
Content-Disposition: inline
In-Reply-To: <CAKuzo_i_hFgxESdQ6JxKEAg=Y5V96rZBEXjr=UZCz0+wcpf=kw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--c45fqceLBNirjcru
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 12, 2016 at 09:29:39AM -0500, Selva Nair wrote:
> > Since we know where we're sending the log file to, some enhancement to
> > the GUI to just go read that file in case the management interface fails
> > to connect (after <x> seconds?) would be good for troubleshooting.
> >
>=20
> This is tricky..First, if the config is not readable, log file is not set
> at that time and log goes to stdout (mapped to "/dev/null" by the GUI).
> Even otherwise  parsing the log to figure out what went wrong is not alwa=
ys
> an easy task for a program.

I'm not sure this description is fully correct - doesn't the GUI (via
service) pass the log file before --config with the remaining options?

"--log" is effective immediately, so a non-readable config file should
be in there.  At least on linux:

gert@...2123...:/tmp > touch openvpn.conf
gert@...2123...:/tmp > chmod 000 openvpn.conf
gert@...2123...:/tmp > openvpn --log mylog.txt --config openvpn.conf
gert@...2123...:/tmp > tail mylog.txt
Options error: In [CMD-LINE]:1: Error opening configuration file: openvpn.c=
onf
Use --help for more information.

... the log file has useful information (well, it could log the reason
why opening wasn't possible, but at least something is there)

> However, the GUI does timeout after 10 seconds or so, if the management
> interface doesn't come up. But the log will be empty if openvpn exited
> before stdout was redirected.

Yes, the GUI times out, and the user has no idea what went wrong.  Especial=
ly
for config file errors.  This needs improvement.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--c45fqceLBNirjcru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVr3uNakuBuNlUUl1AQLSeQQAjvCx6bK1QMOZ4uBPX6+nsf3xSVrSGvNf
sC5zb6+Yv4Mev9FVoeQjbXFdOnHjxIfyBpXbfRfPYWQOpQDunuW8aNiwXKpkOGV4
pWGSkLWnOGNIbzB6txS+jSWhuga5fp7JyzPborLDP/O3X7ob7OeuL1fYjuuWwMBh
FfYvnZw0c8E=
=168w
-----END PGP SIGNATURE-----

--c45fqceLBNirjcru--

