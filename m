MIME-Version: 1.0
References: <20200814080619.2108-1-arne@...1227...>
 <CAAWBBYM2+4FqN-HyV9W19fJfAHKd9K4KHhnQFz2_5f3tzdvMFA@...278...>
 <56fd8e74-c44e-f0d7-1b43-0f8c6c141af3@...277...>
In-Reply-To: <56fd8e74-c44e-f0d7-1b43-0f8c6c141af3@...277...>
From: Rafael Gava <gava100@...277...>
Date: Sat, 29 Aug 2020 21:49:55 -0300
Message-ID: <CAAWBBYOGditSahvt2q3QuRFisGsk=9fPzEuv1Wg-VADMnDr_vg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c8ac3505ae0daa0a"
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c8ac3505ae0daa0a
Content-Type: text/plain; charset="UTF-8"

Hello  tincanteksup,

Thanks for sharing. I didn't know that wiki. I'll double check and see if
I'm missing something.

Actually, I haven't compiled the code, I was just trying the installer from
the link below:

https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I601-amd64.msi


Anyway, I'll pull the code, build it and see what happens.

BR

Gava

On Sat, Aug 29, 2020 at 4:28 PM tincanteksup <tincanteksup@...277...> wrote:

> Hi,
>
> sorry to interrupt, Rafael could you please confirm if you find this
> document to be correct/incorrect for your use case:
> https://community.openvpn.net/openvpn/wiki/CipherNegotiation
>
> Also note, this patch has been merged so make sure your binary has been
> compiled with it.
>
>
> On 29/08/2020 20:19, Rafael Gava wrote:
> > Hi Arne,
> >
> > This thread has a could days but I'm testing the version 2.5-beta2 and
> I'm
> > getting the following error:
> >
> > 2020-08-29 16:02:53 us=643016 OPTIONS ERROR: failed to negotiate cipher
> > with server.  Add the server's cipher ('BF-CBC') to --data-ciphers
> > (currently 'BF-CBC') if you want to connect to this server.
> >
> > I have added the data-ciphers and also the data-ciphers-fallback to the
> > client's config file and in all attempts I'm getting the same error
> message.
> >
> > data-ciphers BF-CBC
> > data-ciphers-fallback BF-CBC
> >
> > I know that you guys are trying to get rid of the BF-CBC but my question
> > is, should it still work if we set these parameters in the config file or
> > am I missing or doing something wrong? :-)
> >
> > BR
> >
> > Gava
> >
> >
> >
> >
> > On Fri, Aug 14, 2020 at 5:06 AM Arne Schwabe <arne@...1227...> wrote:
> >
> >> OpenVPN 2.5 clients do not correctly do a fallback to the server server.
> >> This commit fixes that logic and also fixes --data-ciphers-fallback to
> >> be used in situations other than no OCC cipher.
> >>
> >> To reproduce the error use a client with only --data-ciphers set against
> >> a server without NCP.
> >>
> >>          OPTIONS ERROR: failed to negotiate cipher with server.
> >>          Add the server's cipher  ('AES-256-CBC') to --data-ciphers
> >>          (currently 'AES-256-CBC') if you want to connect to this
> server.
> >>
> >> Reported by: Richard Bonhomme <tincanteksup@...277...>
> >>
> >> Signed-off-by: Arne Schwabe <arne@...1227...>
> >> ---
> >>   src/openvpn/ssl_ncp.c | 9 +++++----
> >>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> >> index f522b8f0..c9ab85ce 100644
> >> --- a/src/openvpn/ssl_ncp.c
> >> +++ b/src/openvpn/ssl_ncp.c
> >> @@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, const int
> >> found)
> >>       }
> >>       /* If the server did not push a --cipher, we will switch to the
> >>        * remote cipher if it is in our ncp-ciphers list */
> >> -    bool useremotecipher = tls_poor_mans_ncp(&c->options,
> >> -
> >>   c->c2.tls_multi->remote_ciphername);
> >> -
> >> +    if(tls_poor_mans_ncp(&c->options,
> c->c2.tls_multi->remote_ciphername))
> >> +    {
> >> +        return true;
> >> +    }
> >>
> >>       /* We could not figure out the peer's cipher but we have fallback
> >>        * enabled */
> >> -    if (!useremotecipher && c->options.enable_ncp_fallback)
> >> +    if (!c->c2.tls_multi->remote_ciphername &&
> >> c->options.enable_ncp_fallback)
> >>       {
> >>           return true;
> >>       }
> >> --
> >> 2.26.2
> >>
> >>
> >>
> >> _______________________________________________
> >> Openvpn-devel mailing list
> >> Openvpn-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
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
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c8ac3505ae0daa0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello=C2=A0

tincanteksup,</div><div><br></div><div>Thanks for sharing. I didn&#39;t kno=
w that wiki. I&#39;ll double=C2=A0check and see if I&#39;m missing somethin=
g.</div><div><br></div><div>Actually, I haven&#39;t compiled the code, I wa=
s just trying the installer from the link below:</div><div><br></div><div><=
a href=3D"https://build.openvpn.net/downloads/releases/OpenVPN-2.5-beta2-I6=
01-amd64.msi" rel=3D"noreferrer" target=3D"_blank">https://build.openvpn.ne=
t/downloads/releases/OpenVPN-2.5-beta2-I601-amd64.msi</a>=C2=A0=C2=A0<br></=
div><div><br></div><div>Anyway, I&#39;ll pull the code, build it and see wh=
at=C2=A0happens.</div><div><br></div><div>BR</div><div><br></div><div>Gava<=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Sat, Aug 29, 2020 at 4:28 PM tincanteksup &lt;<a href=3D"mailto:tincantek=
sup@...277...">tincanteksup@...277...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
sorry to interrupt, Rafael could you please confirm if you find this <br>
document to be correct/incorrect for your use case:<br>
<a href=3D"https://community.openvpn.net/openvpn/wiki/CipherNegotiation" re=
l=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/openvpn/wi=
ki/CipherNegotiation</a><br>
<br>
Also note, this patch has been merged so make sure your binary has been <br>
compiled with it.<br>
<br>
<br>
On 29/08/2020 20:19, Rafael Gava wrote:<br>
&gt; Hi Arne,<br>
&gt; <br>
&gt; This thread has a could days but I&#39;m testing the version 2.5-beta2=
 and I&#39;m<br>
&gt; getting the following error:<br>
&gt; <br>
&gt; 2020-08-29 16:02:53 us=3D643016 OPTIONS ERROR: failed to negotiate cip=
her<br>
&gt; with server.=C2=A0 Add the server&#39;s cipher (&#39;BF-CBC&#39;) to -=
-data-ciphers<br>
&gt; (currently &#39;BF-CBC&#39;) if you want to connect to this server.<br>
&gt; <br>
&gt; I have added the data-ciphers and also the data-ciphers-fallback to th=
e<br>
&gt; client&#39;s config file and in all attempts I&#39;m getting the same =
error message.<br>
&gt; <br>
&gt; data-ciphers BF-CBC<br>
&gt; data-ciphers-fallback BF-CBC<br>
&gt; <br>
&gt; I know that you guys are trying to get rid of the BF-CBC but my questi=
on<br>
&gt; is, should it still work if we set these parameters in the config file=
 or<br>
&gt; am I missing or doing something wrong? :-)<br>
&gt; <br>
&gt; BR<br>
&gt; <br>
&gt; Gava<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Fri, Aug 14, 2020 at 5:06 AM Arne Schwabe &lt;<a href=3D"mailto:arn=
e@...1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; OpenVPN 2.5 clients do not correctly do a fallback to the server s=
erver.<br>
&gt;&gt; This commit fixes that logic and also fixes --data-ciphers-fallbac=
k to<br>
&gt;&gt; be used in situations other than no OCC cipher.<br>
&gt;&gt;<br>
&gt;&gt; To reproduce the error use a client with only --data-ciphers set a=
gainst<br>
&gt;&gt; a server without NCP.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPTIONS ERROR: failed to negotia=
te cipher with server.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Add the server&#39;s cipher=C2=
=A0 (&#39;AES-256-CBC&#39;) to --data-ciphers<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (currently &#39;AES-256-CBC&#39;=
) if you want to connect to this server.<br>
&gt;&gt;<br>
&gt;&gt; Reported by: Richard Bonhomme &lt;<a href=3D"mailto:tincanteksup@...220...=
..277..." target=3D"_blank">tincanteksup@...277...</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..."=
 target=3D"_blank">arne@...1227...</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0src/openvpn/ssl_ncp.c | 9 +++++----<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c<br>
&gt;&gt; index f522b8f0..c9ab85ce 100644<br>
&gt;&gt; --- a/src/openvpn/ssl_ncp.c<br>
&gt;&gt; +++ b/src/openvpn/ssl_ncp.c<br>
&gt;&gt; @@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, con=
st int<br>
&gt;&gt; found)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the server did not push a --cipher=
, we will switch to the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * remote cipher if it is in our ncp-cip=
hers list */<br>
&gt;&gt; -=C2=A0 =C2=A0 bool useremotecipher =3D tls_poor_mans_ncp(&amp;c-&=
gt;options,<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 =C2=A0c-&gt;c2.tls_multi-&gt;remote_ciphername);<br>
&gt;&gt; -<br>
&gt;&gt; +=C2=A0 =C2=A0 if(tls_poor_mans_ncp(&amp;c-&gt;options, c-&gt;c2.t=
ls_multi-&gt;remote_ciphername))<br>
&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* We could not figure out the peer&#39;=
s cipher but we have fallback<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * enabled */<br>
&gt;&gt; -=C2=A0 =C2=A0 if (!useremotecipher &amp;&amp; c-&gt;options.enabl=
e_ncp_fallback)<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!c-&gt;c2.tls_multi-&gt;remote_ciphername &amp;=
&amp;<br>
&gt;&gt; c-&gt;options.enable_ncp_fallback)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; --<br>
&gt;&gt; 2.26.2<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Openvpn-devel mailing list<br>
&gt;&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_=
blank">Openvpn-devel@lists.sourceforge.net</a><br>
&gt;&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-de=
vel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel</a><br>
&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
&gt; <br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000c8ac3505ae0daa0a--

