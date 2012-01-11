MIME-Version: 1.0
In-Reply-To: <4F0DE05F.1090305@...1114...>
References: <1326290252-25076-1-git-send-email-davids@...1347...>
	<4F0DE05F.1090305@...1114...>
Date: Wed, 11 Jan 2012 21:21:25 +0200
Message-ID: <CAOazyz2NLr=LbzrbK0GpXuYnDYHn9aqkUHDHSgVL_dnq5r1yDA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] autotools ./configure don't like
	compat.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

The syshead.h is totally invalid and should be revised long time ago.

Most of the tests within the syshead.h should be done using autoconf
and inject into config.h.

This way, there is a single point of platform specific tests.

On Wed, Jan 11, 2012 at 9:17 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/01/12 14:57, David Sommerseth wrote:
> > The compat.h include file cannot be loaded when ./configure runs, as
> > many of the HAVE_* declarations are not set. =C2=A0This makes test
> > compilations when looking for features fail.
> >
> > As ./configure will load syshead.h, it pulls in compat.h this way.
> > Looking more carefully at syshead.h, there's a #ifndef PACKAGE_NAME
> > check if config.h should be included. =C2=A0This looks like a check if
> > syshead.h is loaded via ./configure or if it is a more normal
> > compilation. =C2=A0Moving the compat.h inclusion into this #ifndef bloc=
k.
> >
> > Signed-off-by: David Sommerseth <davids@...1347...> --- syshead.h |
> > 2 +- 1 files changed, 1 insertions(+), 1 deletions(-)
>
> Applied to master branches on -stable and -testing trees.
>
> commit 330baf2aee70b351cce2d138299118837adbe237
> Author: David Sommerseth <davids@...1347...>
> Date: =C2=A0 Wed Jan 11 14:52:21 2012 +0100
>
> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <davids@...1347...>
> =C2=A0 =C2=A0Acked-by: Gert Doering <gert@...1296...>
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk8N4F0ACgkQDC186MBRfrrKXACgl9S32mQ5DXHZwuI8VEyykoSm
> Hi8AoLF2f1+NEd32qflZIqn4f812CbG3
> =3D6SVX
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
> infrastructure or vast IT resources to deliver seamless, secure access to
> virtual desktops. With this all-in-one solution, easily deploy virtual
> desktops for less than the cost of PCs and save 60% on VDI infrastructure
> costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

