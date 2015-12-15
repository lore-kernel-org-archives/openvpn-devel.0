Date: Tue, 15 Dec 2015 21:54:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151215205402.GV24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
	<CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bf0bWAI6XaKQIHac"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
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

--bf0bWAI6XaKQIHac
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 12:25:23PM -0500, Selva Nair wrote:
> 1. git_master:
>  -  May be built with target =3D vista and will run correctly only on vis=
ta
> and above
>     (this is the default target in openvpn-build if git-master source is
> used)
>  -  Will support --block-outside-dns when run on vista and above --
> undefined behaviour if attempted to run on winxp

I'm fairly sure the binary will not start at all.  It's calling symbols
that are not *there*, so the dll linker will just refuse to run it.

> 2. release/2.3 (and upcoming 2.3.9)
> - May be built for target =3D winxp
>   (this is the default target in openvpn-build if release/2.3 source is
> used)
> - Support for --block-outside-dns determined automatically at run-time:
>      when run on vista and above the option will be supported
>      when run on winxp the option will be ignored or cause
>      a fatal error depending on how it is specified:
>         if pushed from a server: just a warning in the logs
>         specified in the config: fatal error unless protected by
>         ignore-unknown-option or setenv-opt or forward-compatible...

Make that "setenv opt block-outside-dns".  ignore-unknown-option will
*not* help here, as it is not "unknown", but just "not working".

>  3. Both should build correctly for 64-bit and 32-bit platforms

Yep.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bf0bWAI6XaKQIHac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnB96akuBuNlUUl1AQKmCwP+IJyxFtbdU/ovZgefimojEhS7XO60Dvc5
xtNpzQdAiIpksNkEcWVvoqO+l1IID+lFcotseAo3EBY244w7LNkBNEk0VxDunKjF
v92U10Dk0R98sXkGu3pV1/ANJ42UvEh14dzXtMwH18/+TSC4DxqLoaK3fwPEpn/4
KlJVwIz4Zh8=
=JGfE
-----END PGP SIGNATURE-----

--bf0bWAI6XaKQIHac--

