MIME-Version: 1.0
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
 <20181007073824.GA962@...1296...>
In-Reply-To: <20181007073824.GA962@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Oct 2018 15:08:12 -0400
Message-ID: <CAKuzo_htJTZuXewxpgTM4jx6s+HRQVRhPRrTmObLx0huRDfYuA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007bdb780577e494ad"
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007bdb780577e494ad
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Oct 7, 2018 at 3:38 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Mar 04, 2018 at 12:44:02PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Openssl docs do not explicitly state these to be macros although they
> > are currently defined as such. Use AC_CHECK_DECLS to test for these so
> that
> > both function and macro forms could be detected.
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
> > ---
> > Though not meant as a fixup for libressl, as a side effect
> > this also makes 2.4.5 build with newer libressl versions.
> > (built on freebsd 11 using libressl 2.6.4 while testing patch 238)
> > Notes: (i) libressl defines only the set functions and neither
> > are macros. So get functions will get used from the compat layer.
>
> So, going through open patches in patchwork I came to this one.
>
> Reading through the thread, I'm not sure what the final outcome on
> the patch and the problem was?  LibreSSL seems to be fixed (thanks,
> Jeremie :-) ) and if we build with OpenSSL 1.1.0g+, all is good?
>
> Phrased differently: does anything need to be done with this patch or
> should I click on "superceded" in patchwork now?
>

Agreed, if LibreSSL has got those macros defined now, we should just drop
this patch.

I'm marking these as superseded.

Selva

--0000000000007bdb780577e494ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">On Sun, Oct 7, 2018 at 3:38 AM Gert <span class=3D"" style=3D"" id=3D":36=
3.1" tabindex=3D"-1">Doering</span> &lt;<span class=3D"" style=3D"" id=3D":=
363.2" tabindex=3D"-1">gert</span>@<span class=3D"" style=3D"" id=3D":363.3=
" tabindex=3D"-1">greenie</span>.<span class=3D"" style=3D"" id=3D":363.4" =
tabindex=3D"-1">muc</span>.<span class=3D"" style=3D"" id=3D":363.5" tabind=
ex=3D"-1">de</span>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<=
br>
<br>
On Sun, Mar 04, 2018 at 12:44:02PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Openssl docs do not explicitly state these to be macros although they<=
br>
&gt; are currently defined as such. Use AC_CHECK_DECLS to test for these so=
 that<br>
&gt; both function and macro forms could be detected.<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; ---<br>
&gt; Though not meant as a fixup for libressl, as a side effect<br>
&gt; this also makes 2.4.5 build with newer libressl versions.<br>
&gt; (built on freebsd 11 using libressl 2.6.4 while testing patch 238)<br>
&gt; Notes: (i) libressl defines only the set functions and neither<br>
&gt; are macros. So get functions will get used from the compat layer.<br>
<br>
So, going through open patches in patchwork I came to this one.<br>
<br>
Reading through the thread, I&#39;m not sure what the final outcome on<br>
the patch and the problem was?=C2=A0 LibreSSL seems to be fixed (thanks,<br>
Jeremie :-) ) and if we build with OpenSSL 1.1.0g+, all is good?<br>
<br>
Phrased differently: does anything need to be done with this patch or<br>
should I click on &quot;superceded&quot; in patchwork now?<br></blockquote>=
<div><br></div><div>Agreed, if <span class=3D"" style=3D"" id=3D":363.6" ta=
bindex=3D"-1">LibreSSL</span> has got those macros defined now, we should j=
ust drop<br>this patch.<br></div><div>=C2=A0<br></div><div>I&#39;m marking =
these as superseded.<br><br></div><div><span class=3D"" style=3D"" id=3D":3=
63.7" tabindex=3D"-1">Selva</span><br></div></div></div></div>

--0000000000007bdb780577e494ad--

