MIME-Version: 1.0
References: <1563442503-11119-1-git-send-email-lstipakov@...277...>
 <f5a58db3-8469-1577-155f-db2255e1d78c@...2181...>
In-Reply-To: <f5a58db3-8469-1577-155f-db2255e1d78c@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 Jul 2019 15:20:52 +0300
Message-ID: <CAGyAFMXsktWkyyyoPvWjVor-18o41C8O3ScMdACXS3vCMbz26Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000008bbaa6058df3a4c1"
Subject: Re: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000008bbaa6058df3a4c1
Content-Type: text/plain; charset="UTF-8"

Hi,


> Are we sure we can't call this function with 'len' longer than the
> available space in 'key' ?


Yep, because we get available space here:

> +    const int len = BCAP(key);
>

and then pass it to rand_bytes:


> > +    if (!rand_bytes(BEND(key), len))


-- 
-Lev

--0000000000008bbaa6058df3a4c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Are we sure we can&#39;t call this function with &#3=
9;len&#39; longer than the<br>available space in &#39;key&#39; ?=C2=A0=C2=
=A0</blockquote><div><br></div><div>Yep, because we get available space her=
e:</div><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">&gt; +=C2=A0 =C2=A0 const int len =3D =
BCAP(key);<br></blockquote><div><br></div><div>and then pass it to rand_byt=
es:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 if (!rand_bytes(BEND(key), len))</blockquote><div>=C2=
=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div>=
</div>

--0000000000008bbaa6058df3a4c1--

