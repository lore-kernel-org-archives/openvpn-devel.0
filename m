MIME-Version: 1.0
In-Reply-To: <20130116101123.GU22465@...1296...>
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...>
Date: Wed, 16 Jan 2013 12:41:45 +0200
Message-ID: <CABT9mj_MjH3Bo9tq0ahpnnA8rWh+a3UOaTH9DPgATq+ZJ_6YDQ@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=047d7b6777f24ff63504d36586b0
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7b6777f24ff63504d36586b0
Content-Type: text/plain; charset=ISO-8859-1

Right, so this is because c99 and VS don't mix. Thanks very much Gert.

To explain why I'm trying to do this: Our institution uses OpenVPN to
provide remote access (e.g. access to electronic libraries, etc) to its
users. So we used to build openvpn and package it very very similarly to
the official release (we were using msys and nsis) along with a couple of
our conf files. However, domake-win has been removed in 2.3 so I am trying
to figure out the best way to do it. What would be ideal would be the thing
that tunnelblick does with deployed mode (
http://code.google.com/p/tunnelblick/wiki/cCusDeployed). The admin does not
have to build anything, just open the package and drop a deploy folder to
the appropriate location. Sadly the windows package does not include
something similar, so lots of work need to be done to build a customized
package.

BTW, if you are referring to

https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem#BuildingnativelyonWindowsusingtheMSVCtoolchainmsvcsubdir

I am sorry to say that the info on this page outdated, one has to do quite
a few things differently to proceed. The biggest gripe is that the scripts
that are mentioned try to download stuff directly from github but github
has changed the way it exposes its files. In addition, it tries to download
some files from Alon's repo and not from the official openvpn repo. And now
that I mention it, I think that the github repo is not synced to the
official git so 2.3 is not really available there.

Best regards,
Athanasios


On Wed, Jan 16, 2013 at 12:11 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:
> > Trying to compile 2.3 with visual studio 2010. I am getting the following
> > error:
> >
> > init.c(186): error C2143: syntax error : missing ';' before 'type'
> >
> [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\openvpn\openvpn.vcxproj]
> >
> > (after that there are many many more errors, but you get the idea)
>
> Oh well, we've done it again...
>
>   if (management)
>     {
>       gc = gc_new ();
>       struct buffer out = alloc_buf_gc (256, &gc);
>
> ... this is not allowed in visual studio (having a variable declaration
> after "non-declaration" code), but gcc doesn't complain, so we usually
> don't notice.
>
> > Which puzzles me, because I thought that OpenVPN can actually be built
> with
> > visual studio. Is there something I'm missing?
>
> Visual Studio is a big pain, so we cross-compile using MinGW64 from Linux.
>
> Samuli has a wiki page somewhere on community.openvpn.net that explains
> how to build OpenVPN in a non-maddening way.
>
> But thanks for the report.  I have a Win7 VM that should actually be
> able to do a Visual Studio build - I'll try to find time to look at these
> issues and send a patch.
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>



-- 
Athanasios Douitsis

--047d7b6777f24ff63504d36586b0
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Right, so this is because c99 and VS don&#39;t mix. Thanks very much Gert.<=
br><br>To explain why I&#39;m trying to do this: Our institution uses OpenV=
PN to provide remote access (e.g. access to electronic libraries, etc) to i=
ts users. So we used to build openvpn and package it very very similarly to=
 the official release (we were using msys and nsis) along with a couple of =
our conf files. However, domake-win has been removed in 2.3 so I am trying =
to figure out the best way to do it. What would be ideal would be the thing=
 that tunnelblick does with deployed mode (<a href=3D"http://code.google.co=
m/p/tunnelblick/wiki/cCusDeployed">http://code.google.com/p/tunnelblick/wik=
i/cCusDeployed</a>). The admin does not have to build anything, just open t=
he package and drop a deploy folder to the appropriate location. Sadly the =
windows package does not include something similar, so lots of work need to=
 be done to build a customized package. <br>
<br>BTW, if you are referring to <br><br><a href=3D"https://community.openv=
pn.net/openvpn/wiki/BuildingUsingGenericBuildsystem#BuildingnativelyonWindo=
wsusingtheMSVCtoolchainmsvcsubdir">https://community.openvpn.net/openvpn/wi=
ki/BuildingUsingGenericBuildsystem#BuildingnativelyonWindowsusingtheMSVCtoo=
lchainmsvcsubdir</a><br>
<br>I am sorry to say that the info on this page outdated, one has to do qu=
ite a few things differently to proceed. The biggest gripe is that the scri=
pts that are mentioned try to download stuff directly from github but githu=
b has changed the way it exposes its files. In addition, it tries to downlo=
ad some files from Alon&#39;s repo and not from the official openvpn repo. =
And now that I mention it, I think that the github repo is not synced to th=
e official git so 2.3 is not really available there. <br>
<br>Best regards,<br>Athanasios<br><br><br><div class=3D"gmail_quote">On We=
d, Jan 16, 2013 at 12:11 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"=
mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div class=3D"im"><br>
On Tue, Jan 15, 2013 at 09:03:07PM +0200, Athanasios Douitsis wrote:<br>
&gt; Trying to compile 2.3 with visual studio 2010. I am getting the follow=
ing<br>
&gt; error:<br>
&gt;<br>
&gt; init.c(186): error C2143: syntax error : missing &#39;;&#39; before &#=
39;type&#39;<br>
&gt; [C:\openvpn4\openvpn-build\msvc\build.tmp\openvpn-2.3_master\src\openv=
pn\openvpn.vcxproj]<br>
&gt;<br>
&gt; (after that there are many many more errors, but you get the idea)<br>
<br>
</div>Oh well, we&#39;ve done it again...<br>
<br>
=A0 if (management)<br>
=A0 =A0 {<br>
=A0 =A0 =A0 gc =3D gc_new ();<br>
=A0 =A0 =A0 struct buffer out =3D alloc_buf_gc (256, &amp;gc);<br>
<br>
... this is not allowed in visual studio (having a variable declaration<br>
after &quot;non-declaration&quot; code), but gcc doesn&#39;t complain, so w=
e usually<br>
don&#39;t notice.<br>
<div class=3D"im"><br>
&gt; Which puzzles me, because I thought that OpenVPN can actually be built=
 with<br>
&gt; visual studio. Is there something I&#39;m missing?<br>
<br>
</div>Visual Studio is a big pain, so we cross-compile using MinGW64 from L=
inux.<br>
<br>
Samuli has a wiki page somewhere on <a href=3D"http://community.openvpn.net=
" target=3D"_blank">community.openvpn.net</a> that explains<br>
how to build OpenVPN in a non-maddening way.<br>
<br>
But thanks for the report. =A0I have a Win7 VM that should actually be<br>
able to do a Visual Studio build - I&#39;ll try to find time to look at the=
se<br>
issues and send a patch.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//<a href=3D"http://www.muc.de/=
~gert/" target=3D"_blank">www.muc.de/~gert/</a><br>
Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 <a href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"mailto:ge=
rt@...1297...">gert@...1297...</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasio=
s Douitsis<br><br><br>

--047d7b6777f24ff63504d36586b0--

