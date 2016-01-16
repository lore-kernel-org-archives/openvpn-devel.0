Date: Sat, 16 Jan 2016 13:35:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160116123507.GE24952@...1296...>
References: <1452901505-3898-1-git-send-email-iam@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MVn5Z2XswdTku9C8"
Content-Disposition: inline
In-Reply-To: <1452901505-3898-1-git-send-email-iam@...2070...>
Subject: Re: [Openvpn-devel] [PATCH] Clarify --block-outside-dns
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

--MVn5Z2XswdTku9C8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 16, 2016 at 02:45:05AM +0300, ValdikSS wrote:
> @@ -5575,6 +5575,15 @@ DNS leaks. This option prevents any application fr=
om accessing
>  TCP or UDP port 53 except one inside the tunnel. It uses
>  Windows Filtering Platform (WFP) and works on Windows Vista or
>  later.
> +
> +This option is considered unknown on non-Windows platforms
> +and unsupported versions (Windows XP), resulting in fatal
> +error. You may want to use
> +.B \-\-setenv opt
> +or
> +.B \-\-ignore\-unknown\-option
> +to ignore said error. Note that pushing unknown options
> +from server does not trigger fatal errors.
>  .\"*********************************************************

While I agree with the idea (and this is a frequent question, so thanks!),
it's not totally correct for Windows XP - with the Fish patch, it actually
is *not* an "unknown option", it will "just fail".

--setenv opt block-outside-dns

will handle that (because it will change the message level before running
the option processor, so it does not matter if the option is unknown or
fails to initialize), but --ignore-unknown-option will not work on XP -
it is not "unknown", so that code path does not apply.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MVn5Z2XswdTku9C8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVpo4+6kuBuNlUUl1AQKcYgP/cvJYpOH1J6dowVrGGF6idhgmYv9e7kvy
VjE2fCh1rjET8utyOjIGo6j5Bmneee18g3iAAFI/IrpRFBdp6NBh/wVzxIxEekdJ
dpdW8ic40yu9VKp3Y9uWNMhe7blW+A1j5vzPRnjkspjZnTVHVQ8xjPofG5nEX2fZ
f7/JFxTxLBw=
=F5Ul
-----END PGP SIGNATURE-----

--MVn5Z2XswdTku9C8--

