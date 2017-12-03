MIME-Version: 1.0
In-Reply-To: <52012840-b1b5-10a5-89d3-01252f784b7e@...2181...>
References: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>
 <52012840-b1b5-10a5-89d3-01252f784b7e@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 3 Dec 2017 15:22:06 +0500
Message-ID: <CAFHpkQG5YzoGkLwHbTjv9OYXVZhpMypUsuTs1inWnwis64fG0g@...278...>
Content-Type: multipart/alternative; boundary="001a114fcda64dbfad055f6cf9f5"
Subject: Re: [Openvpn-devel] strange behaviour of "auth-token"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114fcda64dbfad055f6cf9f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-12-03 15:06 GMT+05:00 Antonio Quartulli <a@...2181...>:

>
>
> On 03/12/17 17:57, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > Hello,
> >
> > I noticed strange "TLS Auth Error: Auth Username/Password verification
> > failed for peer" when I restarted openvpn server.
> >
> > deeper digging into that discovered the following flow
> >
> > 1) client is authenticated via login/password --> auth token is assigned
> > 2) reauth is done via username/token (token is kept in server memory)
> > 3) server is restarted
> > 4) username/token is passed to auth program --> auth failed
> >
> > so..
>
> shouldn't the client re-start its session after the server has been
> restarted and so restart with auth/pass right away instead of trying the
> token?
>

it should (I meant that by "1)"), however it does not.

I tried openvpn-server from git master and openvpn 2.4.4 from official
windows installer.
(I'll try linux later)

does it restart in your case ?


>
> >
> > 1) shouldn't client retry auth with username/password if username/token
> is
> > failed ?
> > 2) shouldn't server just fail token and not pass it to "extrenla script"
> ?
> >
> > Cheers,
> > Ilya Shipitsin
> >
> >
> >
> > ------------------------------------------------------------
> ------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
> --
> Antonio Quartulli
>
>

--001a114fcda64dbfad055f6cf9f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-12-03 15:06 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 03/12/17 17:57, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I noticed strange &quot;TLS Auth Error: Auth Username/Password verific=
ation<br>
&gt; failed for peer&quot; when I restarted openvpn server.<br>
&gt;<br>
&gt; deeper digging into that discovered the following flow<br>
&gt;<br>
&gt; 1) client is authenticated via login/password --&gt; auth token is ass=
igned<br>
&gt; 2) reauth is done via username/token (token is kept in server memory)<=
br>
&gt; 3) server is restarted<br>
&gt; 4) username/token is passed to auth program --&gt; auth failed<br>
&gt;<br>
&gt; so..<br>
<br>
</span>shouldn&#39;t the client re-start its session after the server has b=
een<br>
restarted and so restart with auth/pass right away instead of trying the<br>
token?<br></blockquote><div><br></div><div>it should (I meant that by &quot=
;1)&quot;), however it does not.<br><br></div><div>I tried openvpn-server f=
rom git master and openvpn 2.4.4 from official windows installer.<br></div>=
<div>(I&#39;ll try linux later)<br><br></div><div>does it restart in your c=
ase ?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;<br>
&gt; 1) shouldn&#39;t client retry auth with username/password if username/=
token is<br>
&gt; failed ?<br>
&gt; 2) shouldn&#39;t server just fail token and not pass it to &quot;extre=
nla script&quot; ?<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Ilya Shipitsin<br>
&gt;<br>
&gt;<br>
&gt;<br>
</span>&gt; ------------------------------<wbr>----------------------------=
--<wbr>------------------<br>
&gt; Check out the vibrant tech community on one of the world&#39;s most<br>
&gt; engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot=
" rel=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...220...=
..1199...<wbr>sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>li=
sts/listinfo/openvpn-devel</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Antonio Quartulli<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a114fcda64dbfad055f6cf9f5--

