MIME-Version: 1.0
In-Reply-To: <CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
	<943c0ce1-501c-df5a-fb47-53ab7a689d36@...2080...>
	<bfcaa197-893f-afba-7554-07edcde483a2@...2080...>
	<CAA1AbxLXh_AOuHFBt0Om=eDOLH-WHM_C6OnGgHLnO+iAYP7dEw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 9 Dec 2016 15:43:37 -0500
Message-ID: <CAKuzo_gH8UNruspCDOTeAa-wU9YsDB8nGGponvkCrVWnPR7SKw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c084cac23774505433fd060
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c084cac23774505433fd060
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 9, 2016 at 8:41 AM, Steffan Karger <steffan@...1856...> wrote:

>
> On 9 December 2016 at 00:14, David Sommerseth
> <openvpn@...2080...> wrote:
> > I just spotted in ssl.c that we need sp_assign=add.
> >
> > [ ssl.c, tls1_PRF() ]
> >     len = slen/2;
> >     S1 = sec;
> >     S2 = &(sec[len]);
> >     len += (slen&1); /* add for odd, make longer */
> >
> > I believe we've agreed on spaces around assignments.
>
> Hm, I'd be fine with that, but I'm afraid there are too many such
> details to bikeshed about.  Once we've fixed the curious newlines
> Selva mentionded (sorry, not sure when I can look at that), I think we
> should stop the discussion and move forward.  Just 5 more days until
> rc2 (where the reformatting should be done).



Agreed.  I'll make no more noise :)

To troubleshoot the extra newlines in places like line 130 of the file you
uploaded
https://paste.fedoraproject.org/502063/36953148
I ran uncrustify using the options listed at our CodeStyle page and all
look good and nice. No such extra newlines. By the way sp_between_byref is
not a valid option.

Selva

--94eb2c084cac23774505433fd060
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 9, 2016 at 8:41 AM, Steffan Karger <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 9 December 2016 at 00:14, David Sommerseth<br>
<span class=3D"m_3948313627506509513gmail-">&lt;<a href=3D"mailto:openvpn@...220...=
..2080..." target=3D"_blank">openvpn@...2156...<wbr>.net</a>&gt; wrote:<br>
&gt; I just spotted in ssl.c that we need sp_assign=3Dadd.<br>
&gt;<br>
&gt; [ ssl.c, tls1_PRF() ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0len =3D slen/2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0S1 =3D sec;<br>
&gt;=C2=A0 =C2=A0 =C2=A0S2 =3D &amp;(sec[len]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0len +=3D (slen&amp;1); /* add for odd, make longer =
*/<br>
&gt;<br>
&gt; I believe we&#39;ve agreed on spaces around assignments.<br>
<br>
</span>Hm, I&#39;d be fine with that, but I&#39;m afraid there are too many=
 such<br>
details to bikeshed about.=C2=A0 Once we&#39;ve fixed the curious newlines<=
br>
Selva mentionded (sorry, not sure when I can look at that), I think we<br>
should stop the discussion and move forward.=C2=A0 Just 5 more days until<b=
r>
rc2 (where the reformatting should be done).</blockquote></div><br><br></di=
v><div class=3D"gmail_extra">Agreed.=C2=A0 I&#39;ll make no more noise :)<b=
r><br></div><div class=3D"gmail_extra"><span class=3D"m_3948313627506509513=
gmail-im"></span>To troubleshoot the extra newlines in places like line 130=
 of the file you uploaded <br></div><div class=3D"gmail_extra"><span class=
=3D"m_3948313627506509513gmail-im"><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">
<a href=3D"https://paste.fedoraproject.org/502063/36953148/" rel=3D"norefer=
rer" target=3D"_blank">https://paste.fedoraproject.or<wbr>g/502063/36953148=
</a></div></div></span>I ran uncrustify using the options listed at our Cod=
eStyle page and all look good and nice. No such extra newlines. By the way =
sp_between_byref is not a valid option.<br><br><div class=3D"m_394831362750=
6509513gmail-yj6qo m_3948313627506509513gmail-ajU"><div id=3D"m_39483136275=
06509513gmail-:2gw" class=3D"m_3948313627506509513gmail-ajR">Selva<br></div=
></div></div><div class=3D"gmail_extra"><br></div></div>

--94eb2c084cac23774505433fd060--

