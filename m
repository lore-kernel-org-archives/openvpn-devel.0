MIME-Version: 1.0
In-Reply-To: <58f2d393-0e3c-c4ec-1573-9ae58e420914@...515...>
References: <20171203211654.1044-1-simon@...2293...>
 <201712041759.vB4HxJaT048678@...2054...>
 <99D61A626FDA8A4B90A270669121BE1085B4B134@...2294...>
 <58f2d393-0e3c-c4ec-1573-9ae58e420914@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 5 Dec 2017 16:21:37 +0500
Message-ID: <CAFHpkQGSx5hjLhGYgUyqYCKZJ9MMWL1sYT2cSd5y5wy+=j6iAw@...278...>
Content-Type: multipart/alternative; boundary="001a11458a32cb1125055f960951"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Add support
 for multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Simon Rozman <simon@...2293...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11458a32cb1125055f960951
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-12-05 16:19 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 05/12/2017 13:01, Simon Rozman ha scritto:
> > Hi,
> >
> >> I've done a bit of staring at the code as well, and it seems to make
> sense (but
> >> thanks to Selva for a thorough review and actually testing this :-) ).
> >>
> >> Given the interaction with EduVPN 2.4, and the fairly well localized
> changes, I
> >> agree to Selva's suggestion of having it in 2.4 as well.
> >>
> >> Your patch has been applied to the master branch and release/2.4 branc=
h.
> >
> > This is excellent. This allows the eduVPN to switch to official
> openvpnserv.exe when 2.4.5 is released.
> >
> > Should we/I document how to setup secondary instance of Interactive
> service?
> > I am new here and I would appreciate some guidance where and how to
> document it. Before I forget. ;)
> >
>
> Hi,
>
> I think we should have that documentation somewhere. I think it would be
>  of interest mostly to developers. What about creating a new text file
> to the repository. For example:
>
>   doc/interactive-service-notes.txt
>

doc/interactive-service-notes.rst ?


>
> Thoughts?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11458a32cb1125055f960951
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-12-05 16:19 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=
=3D"gmail-">Il 05/12/2017 13:01, Simon Rozman ha scritto:<br>
&gt; Hi,<br>
&gt;<br>
&gt;&gt; I&#39;ve done a bit of staring at the code as well, and it seems t=
o make sense (but<br>
&gt;&gt; thanks to Selva for a thorough review and actually testing this :-=
) ).<br>
&gt;&gt;<br>
&gt;&gt; Given the interaction with EduVPN 2.4, and the fairly well localiz=
ed changes, I<br>
&gt;&gt; agree to Selva&#39;s suggestion of having it in 2.4 as well.<br>
&gt;&gt;<br>
&gt;&gt; Your patch has been applied to the master branch and release/2.4 b=
ranch.<br>
&gt;<br>
&gt; This is excellent. This allows the eduVPN to switch to official openvp=
nserv.exe when 2.4.5 is released.<br>
&gt;<br>
&gt; Should we/I document how to setup secondary instance of Interactive se=
rvice?<br>
&gt; I am new here and I would appreciate some guidance where and how to do=
cument it. Before I forget. ;)<br>
&gt;<br>
<br>
</span>Hi,<br>
<br>
I think we should have that documentation somewhere. I think it would be<br>
=C2=A0of interest mostly to developers. What about creating a new text file=
<br>
to the repository. For example:<br>
<br>
=C2=A0 doc/interactive-service-notes.<wbr>txt<br></blockquote><div><br>doc/=
interactive-service-notes.<wbr>rst ?<br>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Thoughts?<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--001a11458a32cb1125055f960951--

