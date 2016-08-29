MIME-Version: 1.0
In-Reply-To: <c1738e6c-8d1d-a8b3-b167-3038fb3e43a2@...2080...>
References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
	<CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
	<5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
	<CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
	<c1738e6c-8d1d-a8b3-b167-3038fb3e43a2@...2080...>
From: Bojan Komazec <bojan.komazec@...277...>
Date: Mon, 29 Aug 2016 11:56:55 +0100
Message-ID: <CAHX+n4vL24UZOAByPXM5=bLy3oJOxoF478L3E3t2pJ6Z18_cFg@...278...>
Content-Type: multipart/alternative; boundary=20cf30563cf5564632053b33bb5d
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
 match openvpn-install-2.3.12-I601
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--20cf30563cf5564632053b33bb5d
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 29, 2016 at 10:38 AM, David Sommerseth <
openvpn@...2080...> wrote:

>
> On 29/08/16 11:10, Bojan Komazec wrote:
> > Thanks a lot Samuli.
> >
> > I cloned "openvpn-build" repo yesterday and created my patch branch
> > off the last commit on "release/2.3" but after reading your email I
> > checked it out again and saw that my "release/2.3" was actually 1
> > commit behind the origin. I am still trying to understand how this
> > difference happened but yeah, my patch is not necessary.
> >
> > Regarding the contribution process, I was reading
> > https://community.openvpn.net/openvpn/wiki/CodeRepositories page
> > which states: "All bug fixes should be developed against the
> > master branch, and where it is decided to include such fixes in a
> > minor release (2.1.x, 2.2.x, etc), it will be cherry-picked from
> > the master branch and into the suitable release branches.". This is
> > what made me thinking I should create a patch for "master" rather
> > than "release/2.3". Did you suggest using release branch as a
> > target because my patch was not a bug fix (but a simple build
> > parameter update)?
>
> We have a few different contribution processes, depending on which
> sub-project you contribute to.  The process described above is for the
> OpenVPN core; which is the part of OpenVPN which does all the crypto
> stuff, tunnelling and networking stuff.  As this project is security
> sensitive and a bad patch can truly compromise the security, we have
> quite a strict regime of reviewing patches before they get accepted
> and included.  In addition, with the OpenVPN core we want to have full
> transparency in what gets accepted and in a distributed way which
> keeps most of the important discussions preserved - even if GitHub
> disappears in the future.
>
> The openvpn-build project is more about building the OpenVPN core and
> related packages.  Even though funky stuff can be done to the build
> process, it is not considered as critical as other components by the
> openvpn-build team.  Hence as simpler approach for contributing.  But
> still, patches will be reviewed here too before they get merged; it's
> just that the mailing list isn't mandatory for this project.
>
> I hope this clarified a few things.
>
>
> - --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>

That completely makes sense. Thanks David for clarification.

Bojan

--20cf30563cf5564632053b33bb5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 29, 2016 at 10:38 AM, David Sommerseth <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
On 29/08/16 11:10, Bojan Komazec wrote:<br>
&gt; Thanks a lot Samuli.<br>
&gt;<br>
&gt; I cloned &quot;openvpn-build&quot; repo yesterday and created my patch=
 branch<br>
&gt; off the last commit on &quot;release/2.3&quot; but after reading your =
email I<br>
&gt; checked it out again and saw that my &quot;release/2.3&quot; was actua=
lly 1<br>
&gt; commit behind the origin. I am still trying to understand how this<br>
&gt; difference happened but yeah, my patch is not necessary.<br>
&gt;<br>
&gt; Regarding the contribution process, I was reading<br>
&gt; <a href=3D"https://community.openvpn.net/openvpn/wiki/CodeRepositories=
" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>o=
penvpn/wiki/CodeRepositories</a> page<br>
&gt; which states: &quot;All bug fixes should be developed against the<br>
&gt; master branch, and where it is decided to include such fixes in a<br>
&gt; minor release (2.1.x, 2.2.x, etc), it will be cherry-picked from<br>
&gt; the master branch and into the suitable release branches.&quot;. This =
is<br>
&gt; what made me thinking I should create a patch for &quot;master&quot; r=
ather<br>
&gt; than &quot;release/2.3&quot;. Did you suggest using release branch as =
a<br>
&gt; target because my patch was not a bug fix (but a simple build<br>
&gt; parameter update)?<br>
<br>
</span>We have a few different contribution processes, depending on which<b=
r>
sub-project you contribute to.=C2=A0 The process described above is for the=
<br>
OpenVPN core; which is the part of OpenVPN which does all the crypto<br>
stuff, tunnelling and networking stuff.=C2=A0 As this project is security<b=
r>
sensitive and a bad patch can truly compromise the security, we have<br>
quite a strict regime of reviewing patches before they get accepted<br>
and included.=C2=A0 In addition, with the OpenVPN core we want to have full=
<br>
transparency in what gets accepted and in a distributed way which<br>
keeps most of the important discussions preserved - even if GitHub<br>
disappears in the future.<br>
<br>
The openvpn-build project is more about building the OpenVPN core and<br>
related packages.=C2=A0 Even though funky stuff can be done to the build<br>
process, it is not considered as critical as other components by the<br>
openvpn-build team.=C2=A0 Hence as simpler approach for contributing.=C2=A0=
 But<br>
still, patches will be reviewed here too before they get merged; it&#39;s<b=
r>
just that the mailing list isn&#39;t mandatory for this project.<br>
<br>
I hope this clarified a few things.<br>
<br>
<br>
- --<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br></blockquote><div><br></div><div>That complete=
ly makes sense. Thanks David for clarification.</div><div><br></div><div>Bo=
jan</div><div>=C2=A0</div></div></div></div>

--20cf30563cf5564632053b33bb5d--

