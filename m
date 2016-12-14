MIME-Version: 1.0
In-Reply-To: <8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
References: <eb2eddfe-cfaa-a1d3-0a55-7457418b2645@...2080...>
	<1481705478-29735-1-git-send-email-lstipakov@...277...>
	<20161214090932.GC78624@...1296...>
	<8f5c0822-e2a2-7b34-ca8a-5a2a2b2ef1e9@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2016 10:53:04 -0500
Message-ID: <CAKuzo_j3BPNqVPyn1oCbHB+k_587t9o-=CvEN-J1-3xGzfQppg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c1254224ef9240543a05612
Subject: Re: [Openvpn-devel] [PATCH v2] Disable async_push if plugins are
	disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c1254224ef9240543a05612
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 14, 2016 at 10:39 AM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> > That one gets a NAK from me, for the reasons given.
> >
> > As long as we *have* --enable/--disable options in configure, they
> > should be validated *there* and not silently ignored.
> >
> > David's argument about "configure is for finding system dependent
> > things and compiler settings" has some merits, but then we should
> > get rid of all compile-time --enable/--disable settings.
>
> By this logic should we enforce users to add --disable-def-auth if
> - --disable-plugin is set?  If so, then we should probably also do
> something with --disable-plugin-auth-pam and
> - --disable-plugin-down-root.  And with --disable-plugin-auth-pam, we
> need to look at --enable-pam-dlopen as well.
>
> And to put things in context of the async-push stuff.  In the C code
> we already check if --disable-def-auth is enabled or not.
>
> If we truly start to look into this for the other options, we will
> have quite a good job ahead of us.  Otherwise we end up with even more
> mess where we are not even consistent.
>
> I say it again, configure.ac is *NOT* the place to do sanity checks on
> which openvpn features depends on each-other.  We have not done that
> before, and we should not do it now.  It just provides far more
> non-production code to maintain, and more places to look for issues
> when code we expect to to be compiled in isn't being compiled in.
> This way leads is a rats nest and will cause much more maintenance
> burden in the future, which I will not accept lightly.
>
> Yes, I see the short-term convenience to solve that specific Trac
> ticket.  But it really isn't the right long-term solution.


I agree with the spirit of this argument, though I do not know the details
of all those options.

But:

When I do
./configure --enable-xyz
I expect the feature to be either enabled or spew out an error saying
'inconsistent options, check configure --help' at the very least.

The build process silently changing the option behind my back and producing
a package with no xyz is not good.

Selva

--94eb2c1254224ef9240543a05612
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Dec 14, 2016 at 10:39 AM, David Sommerseth <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2142...<wb=
r>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<span>&gt; That one gets a NAK from me, for the reasons given.<br>
&gt;<br>
&gt; As long as we *have* --enable/--disable options in configure, they<br>
&gt; should be validated *there* and not silently ignored.<br>
&gt;<br>
&gt; David&#39;s argument about &quot;configure is for finding system depen=
dent<br>
&gt; things and compiler settings&quot; has some merits, but then we should=
<br>
&gt; get rid of all compile-time --enable/--disable settings.<br>
<br>
</span>By this logic should we enforce users to add --disable-def-auth if<b=
r>
- --disable-plugin is set?=C2=A0 If so, then we should probably also do<br>
something with --disable-plugin-auth-pam and<br>
- --disable-plugin-down-root.=C2=A0 And with --disable-plugin-auth-pam, we<=
br>
need to look at --enable-pam-dlopen as well.<br>
<br>
And to put things in context of the async-push stuff.=C2=A0 In the C code<b=
r>
we already check if --disable-def-auth is enabled or not.<br>
<br>
If we truly start to look into this for the other options, we will<br>
have quite a good job ahead of us.=C2=A0 Otherwise we end up with even more=
<br>
mess where we are not even consistent.<br>
<br>
I say it again, <a href=3D"http://configure.ac" rel=3D"noreferrer" target=
=3D"_blank">configure.ac</a> is *NOT* the place to do sanity checks on<br>
which openvpn features depends on each-other.=C2=A0 We have not done that<b=
r>
before, and we should not do it now.=C2=A0 It just provides far more<br>
non-production code to maintain, and more places to look for issues<br>
when code we expect to to be compiled in isn&#39;t being compiled in.<br>
This way leads is a rats nest and will cause much more maintenance<br>
burden in the future, which I will not accept lightly.<br>
<br>
Yes, I see the short-term convenience to solve that specific Trac<br>
ticket.=C2=A0 But it really isn&#39;t the right long-term solution.</blockq=
uote></div><br>I agree with the spirit of this argument, though I do not kn=
ow the details</div><div class=3D"gmail_extra">of all those options.</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">But:</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">When I do=C2=
=A0</div><div class=3D"gmail_extra">./configure --enable-xyz=C2=A0</div><di=
v class=3D"gmail_extra">I expect the feature to be either enabled or spew o=
ut an error saying &#39;inconsistent options, check configure --help&#39; a=
t the very least.=C2=A0</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">The build process silently changing the option behind my =
back and producing a package with no xyz is not good.</div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c1254224ef9240543a05612--

