MIME-Version: 1.0
In-Reply-To: <4B978D0E.9090606@...1114...>
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
	<4B978D0E.9090606@...1114...>
Date: Wed, 10 Mar 2010 18:42:43 +0200
Message-ID: <9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
	not defined
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

This is not the way to do it.

Use AC_USE_SYSTEM_EXTENSIONS in autoconf, which detects libc settings.

The current autoconf shape is poor, long ago I offered James to
rewrite it but he refused. I only made it partially work for cross
compile.

There are a lot of none standard/best practice stuff there.

I did fix automake stuff... :)

Alon.

On Wed, Mar 10, 2010 at 2:14 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/03/10 11:49, David Sommerseth wrote:
> > From: David Sommerseth <dazo@...384...>
> >
> > This is to include peercred support on hosts where _GNU_SOURCE is not
> > defined by default. =C2=A0This issue has been found on Gentoo with glib=
c-2.8.
> >
> > The solution was discussed on the IRC meeting March 4, 2010
> > in #openvpn-discussions.
> > <http://thread.gmane.org/gmane.network.openvpn.devel/3242>
> >
> > Signed-off-by: David Sommerseth <dazo@...384...>
> > ---
> > =C2=A0syshead.h | =C2=A0 =C2=A04 ++++
> > =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
> >
>
> This is the "Gentoo patch", modified to be more generic. =C2=A0In the IRC
> meeting I said I would try to make this change only in socket.c, but
> that was not possible.
>
> TARGET_LINUX is defined in config.h, and not available before syshead.h
> is included, as that is a wrapper which either includes config.h or
> config-win32.h, depending on OS. =C2=A0Further defining _GNU_SOURCE after
> including syshead.h would not make any difference at all, as it needs to
> be defined before sys/socket.h is loaded.
>
> Therefore, I'd prefer a second review on this patch.
>
>
> kind regards,
>
> David Sommerseth
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkuXjQsACgkQDC186MBRfrorFQCePuxnsCBq3pIcPJ3mG1zZO2Y9
> 4FAAniyfy82e0vJhep0TUvQeI+7nzZsr
> =3DbTNV
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

