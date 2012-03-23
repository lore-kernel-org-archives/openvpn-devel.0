MIME-Version: 1.0
In-Reply-To: <20120323153206.GD1181@...1296...>
References: <20120323153206.GD1181@...1296...>
Date: Fri, 23 Mar 2012 17:43:09 +0200
Message-ID: <CAOazyz19CCi=EZ7Wqp1LOUcPw2DfAdS0H8XnGe-0uL3fQOkDbA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] discussion: get rid of useless HAVE_* tests
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Gert,

There are a lot of extra cleanups to do in code.

I left this as-is as I have some thoughts of further work on
platform.c, like splitting it into its own library.

The problem is to support the loggings, need to allocate some time to
properly integrate that.

So please wait with this one.

Thanks,
Alon.

On Fri, Mar 23, 2012 at 5:32 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> reviewing some of the build patches, I found tests like
>
> #ifdef HAVE_CHDIR
>
> or
>
> #ifdef HAVE_GETPID
>
> ... which is craziness. =C2=A0All platforms OpenVPN runs on (except for W=
IN32)
> are fully POSIX compliant, and those are all required to have these
> functions - so testing for them, and having special #ifdef in the code
> for them, and then doing things like this:
>
> int
> platform_chdir (const char* dir)
> {
> #ifdef HAVE_CHDIR
> #ifdef WIN32
> =C2=A0int res;
> =C2=A0struct gc_arena gc =3D gc_new ();
> =C2=A0res =3D _wchdir (wide_string (dir, &gc));
> =C2=A0gc_free (&gc);
> =C2=A0return res;
> #else
> =C2=A0return chdir (dir);
> #endif
> #else
> =C2=A0return -1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<<<< yea=
h, how much good will that do?
> #endif
>
> is just extra code in various places that serves no purpose than to
> make "look, we can test for it!" autotools maniacs happy.
>
>
> So I propose that after Alon's build patches have been merged, I go
> through the HAVE_* defines and rip out everything that is part of
> POSIX and is not use on #ifdef WIN32 anyway (like "getpid()").
>
> We're not going to port this to a non-posix OS any time soon.
>
>
> Comments?
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...
> fax: +49-89-35655025 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gert@...1297...
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

