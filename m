MIME-Version: 1.0
In-Reply-To: <031e4c73-3317-585d-38af-30ac9fede8ff@...515...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
 <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
 <023dbb4e-47b6-bceb-8913-40d5bf4ae76e@...515...>
 <99D61A626FDA8A4B90A270669121BE1085877307@...2294...>
 <031e4c73-3317-585d-38af-30ac9fede8ff@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 2 Nov 2017 14:35:56 +0500
Message-ID: <CAFHpkQHvAg7y=UeSPL4tvn17r0_NT6ySYx5Cb3YObBxz2aNvAw@...278...>
Content-Type: multipart/alternative; boundary="001a114a91be1e6b83055cfcb78a"
Subject: Re: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Simon Rozman <simon@...2293...>, Selva Nair <selva.nair@...277...>, "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>, "eduvpn@...321..." <eduvpn@...321...>

--001a114a91be1e6b83055cfcb78a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Simon has achieved a great progress in building on Windows. WIX perfectly
integrates into visual studio SLN, and than perfectly builds on app veyor))
no more cross builds:)

On Nov 2, 2017 1:32 PM, "Samuli Sepp=C3=A4nen" <samuli@...515...> wrote:

> On 01/11/2017 20:46, Simon Rozman wrote:
> > Hi,
> >
> >>
> >> Hi Simon,
> >>
> >> Speaking of MSIs... we are planning on moving from NSIS to MSI due to
> >> security issues like the one we fixed in previous release. At the
> moment four
> >> (other) people who have expressed interest in taking part in the
> "create MSI
> >> installers for OpenVPN" project. One of these people is me.
> >>
> >> Would you be interested in joining forces in this task?
> >
> > I'd love to. Count me in!
>
> Excellent!
>
> > I have been in the MSI packaging for about 10 years now - automated
> builds from command line, developed DLL custom actions in C/C++,
> localization, GUI, WiX etc.
>
> As you probably know, right now we produce Windows executables and
> installers on Linux using openvpn-build:
>
> <https://github.com/OpenVPN/openvpn-build>
>
> It seems that WiX which you mention would probably be our tool of
> choice, given it is open source (MS-RL):
>
> <https://github.com/wixtoolset/wix3>
> <https://opensource.org/licenses/MS-RL>
>
> Do you know if WiX runs in Mono? That would allow us to produce
> installers directly from openvpn-build without having to have a separate
> Windows packaging computer in the build chain.
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

--001a114a91be1e6b83055cfcb78a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Simon has achieved a great progress in building on Window=
s. WIX perfectly integrates into visual studio SLN, and than perfectly buil=
ds on app veyor)) no more cross builds:)</div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Nov 2, 2017 1:32 PM, &quot;Samuli Sepp=C3=
=A4nen&quot; &lt;<a href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 01/11=
/2017 20:46, Simon Rozman wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Simon,<br>
&gt;&gt;<br>
&gt;&gt; Speaking of MSIs... we are planning on moving from NSIS to MSI due=
 to<br>
&gt;&gt; security issues like the one we fixed in previous release. At the =
moment four<br>
&gt;&gt; (other) people who have expressed interest in taking part in the &=
quot;create MSI<br>
&gt;&gt; installers for OpenVPN&quot; project. One of these people is me.<b=
r>
&gt;&gt;<br>
&gt;&gt; Would you be interested in joining forces in this task?<br>
&gt;<br>
&gt; I&#39;d love to. Count me in!<br>
<br>
Excellent!<br>
<br>
&gt; I have been in the MSI packaging for about 10 years now - automated bu=
ilds from command line, developed DLL custom actions in C/C++, localization=
, GUI, WiX etc.<br>
<br>
As you probably know, right now we produce Windows executables and<br>
installers on Linux using openvpn-build:<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn-build" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/OpenVPN/<wbr>openvpn-build</a>&gt;<br>
<br>
It seems that WiX which you mention would probably be our tool of<br>
choice, given it is open source (MS-RL):<br>
<br>
&lt;<a href=3D"https://github.com/wixtoolset/wix3" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/<wbr>wixtoolset/wix3</a>&gt;<br>
&lt;<a href=3D"https://opensource.org/licenses/MS-RL" rel=3D"noreferrer" ta=
rget=3D"_blank">https://opensource.org/<wbr>licenses/MS-RL</a>&gt;<br>
<br>
Do you know if WiX runs in Mono? That would allow us to produce<br>
installers directly from openvpn-build without having to have a separate<br>
Windows packaging computer in the build chain.<br>
<br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
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
</blockquote></div></div>

--001a114a91be1e6b83055cfcb78a--

