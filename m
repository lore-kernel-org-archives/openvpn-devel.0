MIME-Version: 1.0
References: <20200205183841.1118-1-simon@...2293...>
In-Reply-To: <20200205183841.1118-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Feb 2020 21:37:57 +0200
Message-ID: <CAGyAFMX=RosZ7mddKEwwRgLTqF3uXL5qdaGQUE3tt_Z7Qm6o0Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000ddfa9d059dd94b2e"
Subject: Re: [Openvpn-devel] [PATCH] wintun: upgrade error message in case
 of ring registration failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ddfa9d059dd94b2e
Content-Type: text/plain; charset="UTF-8"

Hi,

-            msg(M_NONFATAL, "Failed to register ring buffers: %lu",
> GetLastError());
>
<skip>

> +            switch (GetLastError())
>
<skip>

> +                default:
> +                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring
> buffers");
>

I think it would make sense to print the error code / error message (with
strerror_win32) in the "default" case.

--000000000000ddfa9d059dd94b2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_NONFATAL, &quot;Failed t=
o register ring buffers: %lu&quot;, GetLastError());<br>
</blockquote><div>&lt;skip&gt;=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (GetLast=
Error())<br></blockquote><div>&lt;skip&gt;=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(=
M_NONFATAL | M_ERRNO, &quot;Failed to register ring buffers&quot;);<br></bl=
ockquote><div><br></div><div>I think it would make sense to print the error=
 code / error message (with strerror_win32) in the &quot;default&quot; case=
.</div></div></div></div>

--000000000000ddfa9d059dd94b2e--

