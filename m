MIME-Version: 1.0
References: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
 <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
 <b75c0d30-f98d-6457-10d4-9b78a02261a7@...2080...>
In-Reply-To: <b75c0d30-f98d-6457-10d4-9b78a02261a7@...2080...>
From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Mon, 10 Sep 2018 13:51:46 +0200
Message-ID: <CAATJJ0+PaCbVEVaWtOr4e5UrYOZZWafP4oRjwk+QdYY2OYDBSw@...278...>
Content-Type: multipart/alternative; boundary="000000000000e20060057582fcdd"
Subject: Re: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000e20060057582fcdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 7, 2018 at 12:24 PM David Sommerseth <
openvpn@...2080...> wrote:

> On 06/09/18 14:25, Samuli Sepp=C3=A4nen wrote:
> > Hi,
> >
> > I maintain the Debian/Ubuntu packages for OpenVPN.
> >
> > Il 03/09/2018 12:24, Christian Ehrhardt ha scritto:
> >> Hi,
> >> the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its service
> >> file from [2] which is outdated.
> >> This makes the upstream Repos [3] not being in sync
> >> I'd ask you to follow the main repo [4] on that to eliminate some Delt=
a.
> >>
> >> In general I think that some of the packaging is outdated and
> >> sbuild_wrapper could fetch some more from Debian [5] and Ubuntu [6]
> >> (which match among each other on this)
> >
> > I've generally reused packaging files in OpenVPN packages provided by
> > the Ubuntu and Debian projects. In some cases, though, the packaging
> > files may be from a package meant for a (slightly) older operating
> > system version.
> >
> > Do you happen to have a diff at hand? I would not mind updating the
> > service files if the changes are fairly minor or fix a bug. But I don't
> > want to break setups that depend on the behavior of the outdated service
> > files.
>
> This is the location of the unit files which we really should use.
>
> <https://github.com/OpenVPN/openvpn/tree/master/distro/systemd>
>

Ack to that, this is also the place where we committed the fix to the
problem that made me aware of all this.

It should break anything if you have the openvpn-{client,server}@.service
> files packaged.  It would actually fix a few bugs instead.
>
> I haven't checked the current state of what's in our .deb packages, but we
> should really ship the very latest at any time.


That is exactly what my report here is about, it currently ships very old
service files.
Not from the repo, nor the last ones from Debian/Ubuntu - older than both
actually


> And DO NOT ship the
> brokenness of openvpn.service and openvpn@...1685... ... those are not
> maintained by us and will make things work even worse;


Yep, I must admit I just "came by" and have no history on this.
But I'd assume we only have them around still for compatibility to old
things.
For anything new we also have
  /lib/systemd/system/openvpn-client@...1685...
  /lib/systemd/system/openvpn-server@...1685...
which are generated right out of the upstream source on build.

especially since
> openvpn 2.4.x and newer is systemd aware and integrates much better.
>
> > Also, we don't have packages for Ubuntu 18.04 yet. So using the
> > packaging files from Ubuntu's repositories makes perfect sense there and
> > can't break anything.
>
> Yes!  Latest and greatest from our own sources.  Always.  ;-)  And do not
> ship
> openvpn.service and openvpn@...2450...
>

I'd totally agree that an upstream .deb does not need to consider the
Distributions past and could go without any of the old services.

To get much more recent packaging (with many fixes on that side) you could
start with what you find at
  https://salsa.debian.org/debian/openvpn

And then drop the old debian/openvpn.install and debian/openvpn-generator
That should give you an otherwise up-to-date packaging with systemd
services purely from upstream sources.


IMHO You can use that for current/next Debian and Ubuntu alike.
The only Ubuntu difference is a (also historical) compat to set
--script-security 2 by default.
But just as above, this history doesn't matter to your .deb packages.


> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd

--000000000000e20060057582fcdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr">On Fri, Sep 7, 2018 at 12:24 PM David Sommerset=
h &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 06/09/18 1=
4:25, Samuli Sepp=C3=A4nen wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I maintain the Debian/Ubuntu packages for OpenVPN.<br>
&gt; <br>
&gt; Il 03/09/2018 12:24, Christian Ehrhardt ha scritto:<br>
&gt;&gt; Hi,<br>
&gt;&gt; the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its ser=
vice<br>
&gt;&gt; file from [2] which is outdated.<br>
&gt;&gt; This makes the upstream Repos [3] not being in sync <br>
&gt;&gt; I&#39;d ask you to follow the main repo [4] on that to eliminate s=
ome Delta.<br>
&gt;&gt;<br>
&gt;&gt; In general I think that some of the packaging is outdated and<br>
&gt;&gt; sbuild_wrapper could fetch some more from Debian [5] and Ubuntu [6=
]<br>
&gt;&gt; (which match among each other on this)<br>
&gt; <br>
&gt; I&#39;ve generally reused packaging files in OpenVPN packages provided=
 by<br>
&gt; the Ubuntu and Debian projects. In some cases, though, the packaging<b=
r>
&gt; files may be from a package meant for a (slightly) older operating<br>
&gt; system version.<br>
&gt; <br>
&gt; Do you happen to have a diff at hand? I would not mind updating the<br>
&gt; service files if the changes are fairly minor or fix a bug. But I don&=
#39;t<br>
&gt; want to break setups that depend on the behavior of the outdated servi=
ce<br>
&gt; files.<br>
<br>
This is the location of the unit files which we really should use.<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn/tree/master/distro/system=
d" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/=
tree/master/distro/systemd</a>&gt;<br></blockquote><div>=C2=A0</div><div>Ac=
k to that, this is also the place where we committed the fix to the problem=
 that made me aware of all this.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
It should break anything if you have the openvpn-{client,server}@.service<b=
r>
files packaged.=C2=A0 It would actually fix a few bugs instead.<br>
<br>
I haven&#39;t checked the current state of what&#39;s in our .deb packages,=
 but we<br>
should really ship the very latest at any time.</blockquote><div><br></div>=
<div>That is exactly what my report here is about, it currently ships very =
old service files.</div><div>Not from the repo, nor the last ones from Debi=
an/Ubuntu - older than both actually</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">And DO NOT ship the<br>
brokenness of openvpn.service and openvpn@...1685... ... those are not<br>
maintained by us and will make things work even worse;</blockquote><div><br=
></div><div>Yep, I must admit I just &quot;came by&quot; and have no histor=
y on this.</div><div>But I&#39;d assume we only have them around still for =
compatibility to old things.</div><div>For anything new we also have</div>=
=C2=A0 /lib/systemd/system/openvpn-client@...1685...<br>=C2=A0 /lib/systemd=
/system/openvpn-server@...1685...<div>which are generated right out of the =
upstream source on build.<br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">especially since<br>
openvpn 2.4.x and newer is systemd aware and integrates much better.<br>
<br>
&gt; Also, we don&#39;t have packages for Ubuntu 18.04 yet. So using the<br>
&gt; packaging files from Ubuntu&#39;s repositories makes perfect sense the=
re and<br>
&gt; can&#39;t break anything.<br>
<br>
Yes!=C2=A0 Latest and greatest from our own sources.=C2=A0 Always.=C2=A0 ;-=
)=C2=A0 And do not ship<br>
openvpn.service and openvpn@...2450...<br></blockquote><div><br></div><div>=
I&#39;d totally agree that an upstream .deb does not need to consider the D=
istributions past and could go without any of the old services.</div><div><=
br></div><div>To get much more recent packaging (with many fixes on that si=
de) you could start with what you find at<br></div><div>=C2=A0 <a href=3D"h=
ttps://salsa.debian.org/debian/openvpn">https://salsa.debian.org/debian/ope=
nvpn</a><br></div><div><br></div><div>And then drop the old debian/openvpn.=
install and debian/openvpn-generator</div><div>That should give you an othe=
rwise up-to-date packaging with systemd services purely from upstream sourc=
es.</div><div><br></div><div><br></div><div>IMHO You can use that for curre=
nt/next Debian and Ubuntu alike.</div><div>The only Ubuntu difference is a =
(also historical) compat to=C2=A0set --script-security 2 by default.</div><=
div>But just as above, this history doesn&#39;t matter to your .deb package=
s.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a>_____________=
__________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span sty=
le=3D"color:rgb(136,136,136);font-size:12.8px">Christian Ehrhardt</span><di=
v style=3D"color:rgb(136,136,136);font-size:12.8px">Software Engineer, Ubun=
tu Server</div><div style=3D"color:rgb(136,136,136);font-size:12.8px">Canon=
ical Ltd</div></div></div></div></div></div></div></div>

--000000000000e20060057582fcdd--

