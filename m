MIME-Version: 1.0
In-Reply-To: <1c0c2d48-a68d-a7ab-5d5b-7975d11946b9@...2406...>
References: <CAAEV3TywmcYYidTfa6oWaex-24rjeqh7iJZ28p1rQONS3Ev0ag@...278...>
 <20180606071031.GX57262@...1296...>
 <1c0c2d48-a68d-a7ab-5d5b-7975d11946b9@...2406...>
From: Rafael Herrera <rafael.herrera@...2405...>
Date: Wed, 6 Jun 2018 19:49:26 -0300
Message-ID: <CAAEV3TxJqYp-syhUoMySR2L4OFLCZe+tTPS94qV0DZ=t1WwF_g@...278...>
Content-Type: multipart/alternative; boundary="0000000000009b7d3b056e00faf3"
Subject: Re: [Openvpn-devel] OpenVPN Custom Client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rogier Spoor <Rogier.Spoor@...321...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--0000000000009b7d3b056e00faf3
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you all for the responses, since I was looking for a specific client
implementation (iOS), I am going to test the PIA framework, as kindly
pointed by Rogier.

Gert, since I was also mapping the whole protocol, if PIA framework is
capable of meet my specific requirements then I will use it instead of
creating another lib by my own. Anyway thanks for telling me your point of
view.

Best Regards.

2018-06-06 17:14 GMT-03:00 Rogier Spoor <Rogier.Spoor@...321...>:

> Hi all,
>
> > On Tue, Jun 05, 2018 at 05:54:05PM -0300, Rafael Herrera wrote:
> >> We are developing a custom client for OpenVPN 2.4.x and it would be
> nice to
> >> have some support from experienced community developers.
>
> It seems PIA has created an OpenVPN compatible client for iOS which
> could save some time.
> https://github.com/pia-foss/tunnel-apple
>
> This was probably done because you can't release 'regular' OpenVPN 2.x
> or 3.x in the Apple appstore due to a GPL license problem.
>
> The PIA implementation looks pretty nice.
> >> Is there anybody here available to help us with a consultancy regarding
> to
> >> network protocols and its required state machines?
> >
> > David was working on an RFC to document the protocol - no idea if that
> > has progressed to "readable first draft" status already, but it might
> > be a good test for the document.
> >
> > Besides this, I wonder why you're not basing your work on the existing
> > (2.x or 3.x) client, possibly with a new GUI wrapped on top -
> duplicating
> > all the code and logic inside OpenVPN is a fairly big task, especially
> > in the "this is not really very well defined, it just happens to be
> > this way today" areas.
>
> This would certainly be the most preferred way 2 go. Makes no sense to
> have multiple implementations; this will fork the community. However for
> iOS it seems 2.x and 3.x can't be used if you like to release your own
> client in the appstore.
>
> cheers,
> Rogier
> >
> > Also, you'll have to end up following all developments that we do on
> > the 2.x and 3.x clients - like, right now we're working on making the
> > client work in an IPv6-only environment.  We test against 2.x and 3.x,
> > but if we break "other implementations that we do not know about", it
> > is not something we can avoid.
> >
> > gert
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
>
>


-- 
Rafael de Paula Herrera

--0000000000009b7d3b056e00faf3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thank you all for the responses, si=
nce I was looking for a specific client implementation (iOS), I am going to=
 test the PIA framework, as kindly pointed by Rogier.</div><div><br></div><=
div>Gert, since I was also mapping the whole protocol, if PIA framework is =
capable of meet my specific requirements then I will use it instead of crea=
ting another lib by my own. Anyway thanks for telling me your point of view=
.</div><div><br></div><div>Best Regards.</div></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">2018-06-06 17:14 GMT-03:00 Rogier Spoor =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Rogier.Spoor@...321..." target=3D"_=
blank">Rogier.Spoor@...321...</a>&gt;</span>:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Hi all,<br>
<span class=3D""><br>
&gt; On Tue, Jun 05, 2018 at 05:54:05PM -0300, Rafael Herrera wrote:<br>
&gt;&gt; We are developing a custom client for OpenVPN 2.4.x and it would b=
e nice to<br>
&gt;&gt; have some support from experienced community developers.<br>
<br>
</span>It seems PIA has created an OpenVPN compatible client for iOS which<=
br>
could save some time.<br>
<a href=3D"https://github.com/pia-foss/tunnel-apple" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/pia-foss/<wbr>tunnel-apple</a><br>
<br>
This was probably done because you can&#39;t release &#39;regular&#39; Open=
VPN 2.x<br>
or 3.x in the Apple appstore due to a GPL license problem.<br>
<br>
The PIA implementation looks pretty nice.<br>
<span class=3D"">&gt;&gt; Is there anybody here available to help us with a=
 consultancy regarding to<br>
&gt;&gt; network protocols and its required state machines?<br>
&gt; <br>
&gt; David was working on an RFC to document the protocol - no idea if that=
<br>
&gt; has progressed to &quot;readable first draft&quot; status already, but=
 it might<br>
&gt; be a good test for the document.<br>
&gt; <br>
&gt; Besides this, I wonder why you&#39;re not basing your work on the exis=
ting<br>
&gt; (2.x or 3.x) client, possibly with a new GUI wrapped on top - duplicat=
ing <br>
&gt; all the code and logic inside OpenVPN is a fairly big task, especially=
 <br>
&gt; in the &quot;this is not really very well defined, it just happens to =
be <br>
&gt; this way today&quot; areas.<br>
<br>
</span>This would certainly be the most preferred way 2 go. Makes no sense =
to<br>
have multiple implementations; this will fork the community. However for<br>
iOS it seems 2.x and 3.x can&#39;t be used if you like to release your own<=
br>
client in the appstore.<br>
<br>
cheers,<br>
Rogier<br>
<span class=3D"">&gt; <br>
&gt; Also, you&#39;ll have to end up following all developments that we do =
on<br>
&gt; the 2.x and 3.x clients - like, right now we&#39;re working on making =
the<br>
&gt; client work in an IPv6-only environment.=C2=A0 We test against 2.x and=
 3.x,<br>
&gt; but if we break &quot;other implementations that we do not know about&=
quot;, it<br>
&gt; is not something we can avoid.<br>
&gt; <br>
&gt; gert<br>
&gt; <br>
&gt; <br>
&gt; <br>
</span><span class=3D"">&gt; ------------------------------<wbr>-----------=
-------------------<wbr>------------------<br>
&gt; Check out the vibrant tech community on one of the world&#39;s most<br>
&gt; engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot=
" rel=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ______________________________<wbr>_________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...220...=
..1199...<wbr>sourceforge.net</a><br>
</span>&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn=
-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
<wbr>lists/listinfo/openvpn-devel</a><br>
&gt; <br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Ra=
fael de Paula Herrera</div></div>
</div>

--0000000000009b7d3b056e00faf3--

