MIME-Version: 1.0
References: <CAKuzo_izpuBXtnXHq2=QfSOen8OY0np-Gy=0=wA23uuCq6Etew@...278...>
 <b1ade983-0961-17b0-0312-3bcc169d0db2@...1800...>
In-Reply-To: <b1ade983-0961-17b0-0312-3bcc169d0db2@...1800...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 30 Jul 2021 11:16:25 -0400
Message-ID: <CAKuzo_iimo_K0bejstfafEifQ-jH4GKR=2xQ0PGLydmUjw02KA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b1642505c858bba4"
Subject: Re: [Openvpn-devel] Adding RSA-PSS support in pkcs11-helper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mike tancsa <mike@...1800...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>, tincanteksup <tincanteksup@...277...>

--000000000000b1642505c858bba4
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

Having this in a release depends on getting the PR merged upstream.

My patch for updating the API with signature parameters has been merged
into pkcs11-helper, so, in principle, we could now handle this in OpenVPN.
But that takes some effort.

Thanks for testing,

Selva

On Fri, Jul 30, 2021 at 8:39 AM mike tancsa <mike@...1800...> wrote:

> Hi,
>
>     Thanks, I finally got around to testing this with the current
> version of OpenVPN from git and it works great on my
> Aladin/SafeNet/Gemalto/Thales token (model 510x)
>
> Would be great if this was part of the default build/distribution.
>
> I can now get TLS1.3 working using the pkcs11 interface.
>
>     ---Mike
>
> On 5/2/2021 7:13 PM, Selva Nair wrote:
> > Hi,
> >
> > Currently RSA-PSS signatures are handled in pkcs11-helper by asking
> > the token to do raw RSA signature of data already padded by OpenSSL.
> > Many new hardware tokens refuse to support this mode and require the
> > padding to be done in hardware.
> >
> > For a recent user report see this thread:
> >
> https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg05732.html
> > <
> https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg05732.html
> >
> >
> > Probably there are some related tickets on Trac too.
> >
> > In OpenVPN, we have a couple of options to fix this:
> >
> > (i) Use a different library like libp11 (for OpenSSL only).
> > (ii) Extend pkcs11-helper
> > (iii) Roll something new on our own :)
> >
> > After some thought, I have decided that extending pkcs11-helper may be
> > the least painful approach --- not including the mental distress in
> > getting code reviews and changes accepted. The "helper" has several
> > features that we depend on and not readily available in alternatives.
> >
> > If anyone is interested in testing this, see
> > https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support
> > <https://github.com/selvanair/pkcs11-helper/releases/tag/pss-support>
> >
> > Though I've opened a PR at
> > https://github.com/OpenSC/pkcs11-helper/pull/31
> > <https://github.com/OpenSC/pkcs11-helper/pull/31> , it's only an RFC
> > and would likely require some iterations.
> >
> > Comments, suggestions for improvement, and test reports, are most
> welcome.
> >
> > Thanks,
> >
> > Selva
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--000000000000b1642505c858bba4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mike,<div><br></div><div>Having this in a release depen=
ds on getting the PR merged upstream.=C2=A0</div><div><br></div><div>My pat=
ch for updating the API with signature parameters has been merged into pkcs=
11-helper, so, in principle, we could now handle this in OpenVPN. But that =
takes some effort.</div><div><br></div><div>Thanks for testing,</div><div><=
br></div><div>Selva</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Jul 30, 2021 at 8:39 AM mike tancsa &lt;<a=
 href=3D"mailto:mike@...1800...">mike@...1800...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
=C2=A0=C2=A0=C2=A0 Thanks, I finally got around to testing this with the cu=
rrent<br>
version of OpenVPN from git and it works great on my<br>
Aladin/SafeNet/Gemalto/Thales token (model 510x)<br>
<br>
Would be great if this was part of the default build/distribution.<br>
<br>
I can now get TLS1.3 working using the pkcs11 interface.<br>
<br>
=C2=A0=C2=A0=C2=A0 ---Mike<br>
<br>
On 5/2/2021 7:13 PM, Selva Nair wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Currently RSA-PSS signatures are handled in pkcs11-helper by asking<br>
&gt; the token to do raw RSA signature of data already padded by OpenSSL.<b=
r>
&gt; Many new hardware tokens refuse to support this mode and require the<b=
r>
&gt; padding to be done in hardware.<br>
&gt;<br>
&gt; For a recent user report see this thread:<br>
&gt; <a href=3D"https://www.mail-archive.com/openvpn-users@...1483...=
e.net/msg05732.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-=
archive.com/openvpn-users@lists.sourceforge.net/msg05732.html</a><br>
&gt; &lt;<a href=3D"https://www.mail-archive.com/openvpn-users@...1659...=
forge.net/msg05732.html" rel=3D"noreferrer" target=3D"_blank">https://www.m=
ail-archive.com/openvpn-users@lists.sourceforge.net/msg05732.html</a>&gt;<b=
r>
&gt;<br>
&gt; Probably there are some related tickets on Trac too.<br>
&gt; =C2=A0<br>
&gt; In OpenVPN, we have a couple of options to fix this:<br>
&gt;<br>
&gt; (i) Use a different library like libp11 (for OpenSSL only).<br>
&gt; (ii) Extend pkcs11-helper<br>
&gt; (iii) Roll something new on our own :)<br>
&gt;<br>
&gt; After some thought, I have decided that extending pkcs11-helper may be=
<br>
&gt; the least painful approach ---=C2=A0not including the mental distress =
in<br>
&gt; getting code reviews and changes accepted. The &quot;helper&quot; has =
several<br>
&gt; features that we depend on and not readily available in alternatives.<=
br>
&gt;<br>
&gt; If anyone is interested in testing this, see<br>
&gt; <a href=3D"https://github.com/selvanair/pkcs11-helper/releases/tag/pss=
-support" rel=3D"noreferrer" target=3D"_blank">https://github.com/selvanair=
/pkcs11-helper/releases/tag/pss-support</a><br>
&gt; &lt;<a href=3D"https://github.com/selvanair/pkcs11-helper/releases/tag=
/pss-support" rel=3D"noreferrer" target=3D"_blank">https://github.com/selva=
nair/pkcs11-helper/releases/tag/pss-support</a>&gt;<br>
&gt;<br>
&gt; Though I&#39;ve opened a PR at<br>
&gt; <a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/31" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper/pull/31<=
/a><br>
&gt; &lt;<a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/31" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/OpenSC/pkcs11-helper/pull=
/31</a>&gt; , it&#39;s only an RFC<br>
&gt; and would likely require=C2=A0some iterations.<br>
&gt;<br>
&gt; Comments, suggestions for improvement, and test reports, are most welc=
ome.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Selva<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
<br>
</blockquote></div>

--000000000000b1642505c858bba4--

