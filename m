MIME-Version: 1.0
In-Reply-To: <1447807884-3734-1-git-send-email-fukawi2@...277...>
References: <1447807884-3734-1-git-send-email-fukawi2@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 26 Nov 2015 21:35:40 -0500
Message-ID: <CAKuzo_gvAwmnT5jzgSgqgr30uM-eNpfrMtD=YOPsy+Uu2NMowQ@...278...>
Content-Type: multipart/alternative; boundary=001a1130cd464d34c305257c8ded
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Phillip Smith <fukawi2@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1130cd464d34c305257c8ded
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Nov 17, 2015 at 7:51 PM, Phillip Smith <fukawi2@...277...> wrote:

> The example.com domain is set aside defined by IANA for use as
> documentation
> examples.


Replacing references to "june.kg" etc., which could one day become
someone's private domain, is not a bad move. Though, not sure
why choose example.com over example.net or example.org, or even tlds like
.example, .test etc. which are also reserved for docs.

That apart, this is not a carefully constructed patch. It misses several
occurrences of "may" and "june" -- even the patch context shows some:

@@ -6626,11 +6626,11 @@ you will get a weird feedback loop.
>  .LP
>

see this one:


>  On may:


> -.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1
> 10.4.0.2 \-\-verb 9
> +.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig
> 10.4.0.1 10.4.0.2 \-\-verb 9
>  .LP
>  On june:


and there again, to list a few..

[..]

>
> @@ -6888,3 +6888,4 @@ as published by the Free Software Foundation.
>  .\"*********************************************************
>  .SH AUTHORS
>  James Yonan <jim@...41...>
> +Phillip Smith <fukawi2@...277...>

Finally,  the AUTHORS section in manpage is a place to document the
principal AUTHOR(S) of the program that it describes. Traditionally the
original author goes there, sometimes with a pointer to full credits.

For all those reasons NAK from me.

Selva

--001a1130cd464d34c305257c8ded
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br>On Tue, Nov 17, 2015 at 7:51 PM, Phillip Smith &lt;<a href=3D"mail=
to:fukawi2@...277..." target=3D"_blank">fukawi2@...277...</a>&gt; wrote:</d=
iv><div class=3D"gmail_extra"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">The <a href=3D"http://exampl=
e.com" target=3D"_blank">example.com</a> domain is set aside defined by IAN=
A for use as documentation<br>examples.=C2=A0</blockquote><div><br></div><d=
iv>Replacing references to &quot;<a href=3D"http://june.kg" target=3D"_blan=
k">june.kg</a>&quot; etc., which could one day become someone&#39;s private=
 domain, is not a bad move. Though, not sure</div><div>why choose <a href=
=3D"http://example.com" target=3D"_blank">example.com</a> over <a href=3D"h=
ttp://example.net" target=3D"_blank">example.net</a> or <a href=3D"http://e=
xample.org" target=3D"_blank">example.org</a>, or even tlds like .example, =
.test etc. which are also reserved for docs.</div></div><div class=3D"gmail=
_extra"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Tha=
t apart, this is not a carefully constructed patch. It misses several occur=
rences of &quot;may&quot; and &quot;june&quot; -- even the patch context sh=
ows some:</div><div class=3D"gmail_extra"><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">@@ -66=
26,11 +6626,11 @@ you will get a weird feedback loop.<br>=C2=A0.LP<br></blo=
ckquote><div><br></div><div>see this one:</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex">=C2=A0On may:</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><br>-.B openvpn \-\-remote=
 <a href=3D"http://june.kg" target=3D"_blank">june.kg</a> \-\-dev tun1 \-\-=
ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9<br>+.B openvpn \-\-remote <a href=3D"=
http://host2.example.com" target=3D"_blank">host2.example.com</a> \-\-dev t=
un1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9<br>=C2=A0.LP<br>=C2=A0On june=
:</blockquote><div><br></div><div>and there again, to list a few..</div><di=
v><br></div><div class=3D"gmail_extra">[..]</div><div class=3D"gmail_extra"=
><br></div>&gt;<br>&gt; @@ -6888,3 +6888,4 @@ as published by the Free Soft=
ware Foundation.<br>&gt; =C2=A0.\&quot;************************************=
*********************<br>&gt; =C2=A0.SH AUTHORS<br>&gt; =C2=A0James Yonan &=
lt;<a href=3D"mailto:jim@...41..." target=3D"_blank">jim@...41...</a>&gt;<b=
r>&gt; +Phillip Smith &lt;<a href=3D"mailto:fukawi2@...277..." target=3D"_b=
lank">fukawi2@...277...</a>&gt;</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">Finally, =C2=A0the AUTHORS section in manpage is =
a place to document the principal AUTHOR(S) of the program that it describe=
s. Traditionally the original author goes there, sometimes with a pointer t=
o full credits.</div><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra">For all those reasons NAK from me.</div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a1130cd464d34c305257c8ded--

