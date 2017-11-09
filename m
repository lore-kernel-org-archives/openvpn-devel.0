MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085884910@...2294...>
References: <CAKuzo_iOXui4WDuRqf6-NybpfeWNjKR3GLn7dsw98FoNoSHNMw@...278...>
 <20171105223714.7852-1-simon@...2293...>
 <CAKuzo_gsuMMhThtx4UvWoHP9ipT4x_KEFewBxh00z=h4xkc4ow@...278...>
 <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
 <CAKuzo_jDTZ41vrpZYPtzkW51=2a9X90qtwYnkGGXx85QVJceZg@...278...>
 <99D61A626FDA8A4B90A270669121BE1085884910@...2294...>
From: Selva <selva.nair@...277...>
Date: Thu, 9 Nov 2017 11:12:25 -0500
Message-ID: <CAKuzo_g+8=-S_i1tDjLtHQ36ext9o6zCGszwBCZmwb4AS5as+Q@...278...>
Content-Type: multipart/alternative; boundary="001a114e65081dd7be055d8f1319"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: Add support for
 multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114e65081dd7be055d8f1319
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Thu, Nov 9, 2017 at 3:33 AM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
> > But then making the variable static just to keep a valid pointer beyond
> the
> > current block local looks like a kludge. For me seeing static applied to
> a
> > variable scoped to a block is just confusing and unusual style. Think of
> this: if
> > you remove that static the code may still build and even work on some
> > compilers depending on optimization level etc. and mysteriously fail on
> some
> > occasions. From that one could either conclude a static qualifier is
> required
> > her or the variable is wrongly scoped. I think the latter conclusion is
> the 'right'
> > one and static is a misuse.
> >
> > As for the combination 'static const ...', it has a place and that is
> for constants
> > defined outside functions to limit the scope of an otherwise  global
> const to
> > that of the compilation unit.
> >
> > It may be just me.
>
> Not necessarily. It may be just *me*. :)
>
> Anyway, you got me convinced and I shall move those structs from data
> segment to stack in the next version of the patch.


 Glad that I don't have to invent an Acked-with-reservations: tag :)


>
> > I like it: using "OpenVPN" as a kind of namespace also avoids name
> collision
> > with any other 'foobar' installed in HKLM\Software\foobar
>
> Exactly, introducing instances is all about avoiding namespace collisions.
>
> > Not sure I follow, but will wait for the patch. I suppose naming
> additional
> > instances as, say, 'foo'  using the official package and have service
> pipe, exit
> > event etc named after it and registry keys taken from HKLM\Software\foo
> > will still work.
>
> In the v1 and v2 patches, yes. But in v3 patch, the PACKAGE/PACKAGE_NAME
> is always used as the prefix/namespace. This way we impose the "OpenVPN"
> branding to all instances by compile-time default. In v3, people can't take
> the interactive service and make it disguise as the
> "Microsoft\Office\Automatic Update".
>
> The v3 made instancing less flexible on purpose.
>
> If you disagree, I can revert to v1/2 behaviour.
>

Looked through v3 changes --- either approach (v2 or v3) is fine.


>
> > In fact I like the current patch in that it allows installing even the
> official
> > instance as a named one with name = OpenVPN and thus decouples
> > automatic and interactive services. That makes it easy to avoid
> installing the
> > legacy service, which I think no one uses anymore.
>
> Ouch. *We* would use the automatic service if it was coded slightly
> different. I didn't know the legacy automatic service is on the obsolete
> list yet.
>

The automatic service per-se will continue to be there. But now its served
by the C#/.NET version  (https://github.com/OpenVPN/openvpnserv2) that
is included in the distribution as openvpnserv2.exe We kept the old service
renamed from openvpnservice to openvpnservicelegacy as a precaution.


> Perhaps, a true replacement for the automatic service could be to make the
> openvpn.exe itself to be able to install and run as a Windows service
> (--daemon for Windows):
> - The SCM would restart it, should openvpn.exe terminate or crash.
> - Separate openvpn.exe service for each ovpn configuration, allowing
> admins to manage them individually.
> - Linux like behaviour, where you run each tunnel as a separate Systemd
> daemon.
>

Essentially that's what the new automatic service does except for the
ability to
selectively control (start/stop) individual configs. I too would like to
see that
functionality but .NET puts me to sleep.


>
> (That is exactly what I'd need for our office. Right now we are wrapping
> openvpn.exe inside a NSSM service helper. Would be nice to get that feature
> out-of-the-box.)
>

Right now using nssm is somewhat more versatile than openvpnserv2 but the
latter
does watch the process, restarts if needed etc., which the original
automatic
service was not designed to do. At that time we had debated about nssm vs
openvpnserv2.exe and the latter won because of some packaging convenience..

Personally I would like an automatic service that runs with limited
privileges
(e.g., as LocalService) which uses the interactive service to start
instances,
watches over the process and handles individual configs independently.
Refactoring the code in automatic.c may be a way to achieve that.


> Back to the interactive service... According to the latest [PATCH( v3
> missing)], one would need to start the default instance of the interactive
> service only using the following service command line:
>
> openvpnserv.exe -instance interactive ""
>

Yes that would work in a pinch and, once installed, the user need not worry
about the oddity of that command line. But ignore my comment about running
the default instance as a named one. That's not really necessary.

All said, v4 could be based on v3 or v2. Now try to convince Gert that this
belongs to 2.4 :)

Regards,

Selva

--001a114e65081dd7be055d8f1319
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<br><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Thu, Nov 9, 2017 at 3:33 AM, Simon Rozman <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<span class=3D"gmail-"><br>
&gt; But then making the variable static just to keep a valid pointer beyon=
d the<br>
&gt; current block local looks like a kludge. For me seeing static applied =
to a<br>
&gt; variable scoped to a block is just confusing and unusual style. Think =
of this: if<br>
&gt; you remove that static the code may still build and even work on some<=
br>
&gt; compilers depending on optimization level etc. and mysteriously fail o=
n some<br>
&gt; occasions. From that one could either conclude a static qualifier is r=
equired<br>
&gt; her or the variable is wrongly scoped. I think the latter conclusion i=
s the &#39;right&#39;<br>
&gt; one and static is a misuse.<br>
&gt;<br>
&gt; As for the combination &#39;static const ...&#39;, it has a place and =
that is for constants<br>
&gt; defined outside functions to limit the scope of an otherwise =C2=A0glo=
bal const to<br>
&gt; that of the compilation unit.<br>
&gt;<br>
&gt; It may be just me.<br>
<br>
</span>Not necessarily. It may be just *me*. :)<br>
<br>
Anyway, you got me convinced and I shall move those structs from data segme=
nt to stack in the next version of the patch.</blockquote><div><br></div><d=
iv>=C2=A0Glad that I don&#39;t have to invent an Acked-with-reservations: t=
ag :)=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<span class=3D"gmail-"><br>
&gt; I like it: using &quot;OpenVPN&quot; as a kind of namespace also avoid=
s name collision<br>
&gt; with any other &#39;foobar&#39; installed in HKLM\Software\foobar<br>
<br>
</span>Exactly, introducing instances is all about avoiding namespace colli=
sions.<br>
<span class=3D"gmail-"><br>
&gt; Not sure I follow, but will wait for the patch. I suppose naming addit=
ional<br>
&gt; instances as, say, &#39;foo&#39; =C2=A0using the official package and =
have service pipe, exit<br>
&gt; event etc named after it and registry keys taken from HKLM\Software\fo=
o<br>
&gt; will still work.<br>
<br>
</span>In the v1 and v2 patches, yes. But in v3 patch, the PACKAGE/PACKAGE_=
NAME is always used as the prefix/namespace. This way we impose the &quot;O=
penVPN&quot; branding to all instances by compile-time default. In v3, peop=
le can&#39;t take the interactive service and make it disguise as the &quot=
;Microsoft\Office\Automatic Update&quot;.<br>
<br>
The v3 made instancing less flexible on purpose.<br>
<br>
If you disagree, I can revert to v1/2 behaviour.<br></blockquote><div><br><=
/div><div>Looked through v3 changes --- either approach (v2 or v3) is fine.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; In fact I like the current patch in that it allows installing even the=
 official<br>
&gt; instance as a named one with name =3D OpenVPN and thus decouples<br>
&gt; automatic and interactive services. That makes it easy to avoid instal=
ling the<br>
&gt; legacy service, which I think no one uses anymore.<br>
<br>
</span>Ouch. *We* would use the automatic service if it was coded slightly =
different. I didn&#39;t know the legacy automatic service is on the obsolet=
e list yet.<br></blockquote><div><br></div><div>The automatic service per-s=
e will continue to be there. But now its served</div><div>by the C#/.NET ve=
rsion =C2=A0(<a href=3D"https://github.com/OpenVPN/openvpnserv2">https://gi=
thub.com/OpenVPN/openvpnserv2</a>) that</div><div>is included in the distri=
bution as openvpnserv2.exe We kept the old service</div><div>renamed from o=
penvpnservice to openvpnservicelegacy as a precaution.</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Perhaps, a true replacement for the automatic service could be to make the =
openvpn.exe itself to be able to install and run as a Windows service (--da=
emon for Windows):<br>
- The SCM would restart it, should openvpn.exe terminate or crash.<br>
- Separate openvpn.exe service for each ovpn configuration, allowing admins=
 to manage them individually.<br>
- Linux like behaviour, where you run each tunnel as a separate Systemd dae=
mon.<br></blockquote><div><br></div><div>Essentially that&#39;s what the ne=
w automatic service does except for the ability to</div><div>selectively co=
ntrol (start/stop) individual configs. I too would like to see that</div><d=
iv>functionality but .NET puts me to sleep.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
(That is exactly what I&#39;d need for our office. Right now we are wrappin=
g openvpn.exe inside a NSSM service helper. Would be nice to get that featu=
re out-of-the-box.)<br></blockquote><div><br></div><div>Right now using nss=
m is somewhat more versatile than openvpnserv2 but the latter</div><div>doe=
s watch the process, restarts if needed etc., which the original automatic<=
/div><div>service was not designed to do. At that time we had debated about=
 nssm vs</div><div>openvpnserv2.exe and the latter won because of some pack=
aging convenience..</div><div><br></div><div>Personally I would like an aut=
omatic service that runs with limited privileges=C2=A0</div><div>(e.g., as =
LocalService) which uses the interactive service to start instances,</div><=
div>watches over the process and handles individual configs independently.<=
/div><div>Refactoring the code in automatic.c may be a way to achieve that.=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Back to the interactive service... According to the latest [PATCH( v3 missi=
ng)], one would need to start the default instance of the interactive servi=
ce only using the following service command line:<br>
<br>
openvpnserv.exe -instance interactive &quot;&quot;<br></blockquote><div><br=
></div><div>Yes that would work in a pinch and, once installed, the user ne=
ed not worry</div><div>about the oddity of that command line. But ignore my=
 comment about running</div><div>the default instance as a named one. That&=
#39;s not really necessary.</div><div><br></div><div>All said, v4 could be =
based on v3 or v2. Now try to convince Gert that this</div><div>belongs to =
2.4 :)</div><div><br></div><div>Regards,</div><div><br></div><div>Selva</di=
v></div></div></div>

--001a114e65081dd7be055d8f1319--

