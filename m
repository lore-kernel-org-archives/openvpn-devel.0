Date: Fri, 12 Feb 2016 14:15:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160212131529.GQ24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
	<56BD9D87.4070909@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0+8OHN0M/vVgnd4"
Content-Disposition: inline
In-Reply-To: <56BD9D87.4070909@...515...>
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
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--o0+8OHN0M/vVgnd4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 12, 2016 at 10:53:27AM +0200, Samuli Sepp=E4nen wrote:
> That would be good. We also need to warn about lack of permissions on=20
> the config files. Right now GUI just hangs if it can't read the OpenVPN=20
> config file.

This is a more fundamental issue, I think - if there is something wrong
with the config file (like: syntax error, file not found, ...) OpenVPN
will exit right away, and the GUI will wait for OpenVPN's management
interface to show up, to read back the log.

Since we know where we're sending the log file to, some enhancement to
the GUI to just go read that file in case the management interface fails
to connect (after <x> seconds?) would be good for troubleshooting.

gert,
   as usual in windows/installer problems just reporting, but unable to fix


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o0+8OHN0M/vVgnd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVr3a8akuBuNlUUl1AQLHTAQAspNsgboHo65mzj3zsD5/68z+9CECpz/T
e2pGTbb9TiYvrmemEIzpISei+OVAkBkyZ9fmWKi/Q4sDClOf906Hrm/ChxOcSOWJ
CiT3Pix6XDaf+rrsnM7fxEL9R+BdBUrHfMm1LpyE2aayJnOHMl17iSOzoV9grERK
fD7IXxzDpXE=
=Lz5p
-----END PGP SIGNATURE-----

--o0+8OHN0M/vVgnd4--

