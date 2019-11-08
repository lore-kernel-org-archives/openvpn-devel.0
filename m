MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-3-git-send-email-lstipakov@...277...>
 <4b355202-a6b4-698f-2a15-1b72a5c5b11a@...1856...>
In-Reply-To: <4b355202-a6b4-698f-2a15-1b72a5c5b11a@...1856...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 8 Nov 2019 19:34:33 +0200
Message-ID: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
Content-Type: multipart/alternative; boundary="000000000000aa42290596d93228"
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] wintun: add --windows-driver
 config option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000aa42290596d93228
Content-Type: text/plain; charset="UTF-8"

Hi,

Should there not be a manpage entry in this commit too?
>

Indeed. Added to manpage.

Why do we have to set c->c2.tuntap->wintun in both do_init_tun and
> do_open_tun? Should one of them not suffice?
>

Just to be sure that it is assigned :)

Removed unneeded second assignment.

Should this --windows-driver option not be inside the #ifdef _WIN32 ?
>

In fact it is already in _WIN32, but the next option has #ifdef _WIN32
again,
so I removed it.


> > +#ifdef _WIN32
> > +bool
> > +parse_windows_driver(const char *str, const int msglevel)
>
> I think this should be a static function. Also a short (doxygen) comment
> explaining what the return value means would be nice.
>

Done.


> > +    bool wintun;
>
> Did you consider using an enum instead? I think it would make the code
> easier to read.
>

Honestly I do not see to much value in converting bool to enum,
it is unlikely that we'll have more tun drivers in the near future. Also
changing it here would break follow-up patches.

As verbally agreed, I'll look into it afterwards.

v3 is on its way.

-- 
-Lev

--000000000000aa42290596d93228
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Should there not be a manpage entry in this commit too?<br></blockquote><di=
v><br></div><div>Indeed. Added to manpage.=C2=A0</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Why do we have to set c-&gt;c2.tuntap-&gt;wintun in both do_init_tun and<br>
do_open_tun? Should one of them not suffice?<br></blockquote><div><br></div=
><div>Just to be sure that it is assigned :)</div><div><br></div><div>Remov=
ed unneeded second assignment.=C2=A0</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Should this --windows-driver option not be inside the #ifdef _WIN32 ?<br></=
blockquote><div><br></div><div>In fact it is already in _WIN32, but the nex=
t option has #ifdef _WIN32 again,=C2=A0</div><div>so I removed it.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +#ifdef _WIN32<br>
&gt; +bool<br>
&gt; +parse_windows_driver(const char *str, const int msglevel)<br>
<br>
I think this should be a static function. Also a short (doxygen) comment<br>
explaining what the return value means would be nice.<br></blockquote><div>=
<br></div><div>Done.=C2=A0</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">&gt; +=C2=A0 =C2=A0 bool wintun;<br>
<br>
Did you consider using an enum instead? I think it would make the code<br>
easier to read.=C2=A0<br></blockquote><div><br></div><div>Honestly I do not=
 see to much value in converting bool to enum,</div><div>it is unlikely tha=
t we&#39;ll have more tun drivers in=C2=A0the near future. Also</div><div>c=
hanging it here would break follow-up patches.</div><div><br></div><div>As =
verbally agreed, I&#39;ll look into it afterwards.</div><div><br></div><div=
>v3 is on its way.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature">-Lev</div></div>

--000000000000aa42290596d93228--

