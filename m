MIME-Version: 1.0
References: <20230128215901.2207208-1-selva.nair@...277...>
 <20230128215901.2207208-2-selva.nair@...277...>
 <ZL+hg0TQn5X0AAiZ@...2685...>
In-Reply-To: <ZL+hg0TQn5X0AAiZ@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jul 2023 13:42:41 -0400
Message-ID: <CAKuzo_i-DaAL93QaFBPggTGVn--VNxGhN4_fDC1qwoTVXTSP=A@...278...>
Content-Type: multipart/alternative; boundary="000000000000f3d7840601534246"
Subject: Re: [Openvpn-devel] [PATCH 2/2] signal_reset(): combine check and
 reset operations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000f3d7840601534246
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 6:18=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> On Sat, Jan 28, 2023 at 04:59:01PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - "if (sig =3D=3D X) signal_reset(sig)" now becomes
> >   "signal_reset(sig, X)" so that the check and assignment
> >   can be done in one place where signals are masked.
> >   This is required to avoid change of signal state between
> >   check and reset operations.
> >
> > - Avoid resetting the signal except when absolutely necessary
> >   (resetting has the potential of losing signals)
> >
> > - In 'pre_init_signal_catch()', when certain low priority signals
> >   are set to SIG_IGN, clear any pending signals of the same
> >   type. Also, reset signal at the end of the SIGUSR1 and
> >   SIGHUP loops where their values are checked instead of later. This
> >   avoids the need for 'signal_reset()' after SIGHUP or in
> 'init_instance()'
> >   which could cause a signal like SIGTERM to be lost.
> >
> [...]
> > diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> > index cba58276..ad0aa8a2 100644
> > --- a/src/openvpn/openvpn.c
> > +++ b/src/openvpn/openvpn.c
> > @@ -194,7 +194,6 @@ openvpn_main(int argc, char *argv[])
> >              context_clear_all_except_first_time(&c);
> >
> >              /* static signal info object */
> > -            CLEAR(siginfo_static);
> >              c.sig =3D &siginfo_static;
>
> Is that actually save? Doesn't that mean that siginfo_static might be
> used uninitialized?
>

siginfo_static is a global variable with no explicit initialization, so it
is guaranteed to
get initialized to {0} at start up.

Selva

--000000000000f3d7840601534246
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 25, 2023 at 6:18=E2=80=AF=
AM Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_bla=
nk">frank@...2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Sat, Jan 28, 2023 at 04:59:01PM -0500, <a href=3D"ma=
ilto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a> wrote=
:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - &quot;if (sig =3D=3D X) signal_reset(sig)&quot; now becomes<br>
&gt;=C2=A0 =C2=A0&quot;signal_reset(sig, X)&quot; so that the check and ass=
ignment<br>
&gt;=C2=A0 =C2=A0can be done in one place where signals are masked.<br>
&gt;=C2=A0 =C2=A0This is required to avoid change of signal state between<b=
r>
&gt;=C2=A0 =C2=A0check and reset operations.<br>
&gt; <br>
&gt; - Avoid resetting the signal except when absolutely necessary<br>
&gt;=C2=A0 =C2=A0(resetting has the potential of losing signals)<br>
&gt; <br>
&gt; - In &#39;pre_init_signal_catch()&#39;, when certain low priority sign=
als<br>
&gt;=C2=A0 =C2=A0are set to SIG_IGN, clear any pending signals of the same<=
br>
&gt;=C2=A0 =C2=A0type. Also, reset signal at the end of the SIGUSR1 and<br>
&gt;=C2=A0 =C2=A0SIGHUP loops where their values are checked instead of lat=
er. This<br>
&gt;=C2=A0 =C2=A0avoids the need for &#39;signal_reset()&#39; after SIGHUP =
or in &#39;init_instance()&#39;<br>
&gt;=C2=A0 =C2=A0which could cause a signal like SIGTERM to be lost.<br>
&gt; <br>
[...]<br>
&gt; diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c<br>
&gt; index cba58276..ad0aa8a2 100644<br>
&gt; --- a/src/openvpn/openvpn.c<br>
&gt; +++ b/src/openvpn/openvpn.c<br>
&gt; @@ -194,7 +194,6 @@ openvpn_main(int argc, char *argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 context_clear_all_exce=
pt_first_time(&amp;c);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* static signal info =
object */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CLEAR(siginfo_static);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c.sig =3D &amp;siginfo=
_static;<br>
<br>
Is that actually save? Doesn&#39;t that mean that siginfo_static might be<b=
r>
used uninitialized?<br></blockquote><div><br></div><div>siginfo_static is a=
 global variable with no explicit initialization, so it is guaranteed to</d=
iv><div>get initialized to {0} at start up.</div><div><br></div><div>Selva<=
/div></div></div>

--000000000000f3d7840601534246--

