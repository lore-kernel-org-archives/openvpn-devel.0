MIME-Version: 1.0
In-Reply-To: <CAA1AbxKVxTqAD9W5NdgvQuJezO550EMMbghn-P=m2v_3ap8jyQ@...278...>
References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
	<CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
	<7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
	<CAA1AbxKVxTqAD9W5NdgvQuJezO550EMMbghn-P=m2v_3ap8jyQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Oct 2016 11:49:09 -0400
Message-ID: <CAKuzo_iu7u=C2+Oj2WV_pbnQh0QRJLgObsf73N+ZYoQzHjKsBA@...278...>
Content-Type: multipart/alternative; boundary=001a1147a1cc250b2b053f39c1b9
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147a1cc250b2b053f39c1b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 11:17 AM, Steffan Karger <steffan@...1856...> wrote:

> On 19 October 2016 at 17:14, Samuli Sepp=C3=A4nen <samuli@...515...> wrot=
e:
> > SviMik had a very good point against using %APPDATA%: it is a hidden
> > folder. At least on Windows 7 it seems to be hidden at the filesystem
> > level, because no tools seem to see it. However, doing a
> >
> >    cd $HOME\Appdata
> >
> > in Powershell will work, so the directory _is_ there even though it is
> > invisble.
> >
> > I don't think we should put the configuration files into folder people
> > will not find without extra tinkering.
>
> Maybe add an 'open config folder' button/link to openvpn-gui?


I think this is hard to do for hidden folders without tinkering with users
preferences for showing hidden files/folders.

Selva

--001a1147a1cc250b2b053f39c1b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Oct 19, 2016 at 11:17 AM, Steffan Karger <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 19 October 201=
6 at 17:14, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515..." ta=
rget=3D"_blank">samuli@...515...</a>&gt; wrote:<br>
&gt; SviMik had a very good point against using %APPDATA%: it is a hidden<b=
r>
&gt; folder. At least on Windows 7 it seems to be hidden at the filesystem<=
br>
&gt; level, because no tools seem to see it. However, doing a<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 cd $HOME\Appdata<br>
&gt;<br>
&gt; in Powershell will work, so the directory _is_ there even though it is=
<br>
&gt; invisble.<br>
&gt;<br>
&gt; I don&#39;t think we should put the configuration files into folder pe=
ople<br>
&gt; will not find without extra tinkering.<br>
<br>
</span>Maybe add an &#39;open config folder&#39; button/link to openvpn-gui=
?</blockquote></div><br>I think this is hard to do for hidden folders witho=
ut tinkering with users preferences for showing hidden files/folders.</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div>=
</div>

--001a1147a1cc250b2b053f39c1b9--

