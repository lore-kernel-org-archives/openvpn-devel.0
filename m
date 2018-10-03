MIME-Version: 1.0
References: <1538229228-10620-1-git-send-email-selva.nair@...277...>
 <1538510474-27602-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1538510474-27602-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 3 Oct 2018 11:53:54 +0300
Message-ID: <CAGyAFMXt9U1gruw3ox7Kr1-VXZ4mAGi3n+RM-sH62tkEXKnT-w@...278...>
Content-Type: multipart/alternative; boundary="0000000000003f80d705774f2e4b"
Subject: Re: [Openvpn-devel] [PATCH 1/3] Move get system directory to a
 separate function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000003f80d705774f2e4b
Content-Type: text/plain; charset="UTF-8"

Hi,


> +    if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_path)))
> +    {
> +        wcsncpy(win_sys_path, default_sys_path, _countof(win_sys_path));
> +        win_sys_path[_countof(win_sys_path) - 1] = L'\0';
> +    }
>

Is there need in adding null terminator to win_sys_path?

Since it is static, it will be initialized with zeroes at startup. Besides,
wcsncpy also adds null terminator.

-- 
-Lev

--0000000000003f80d705774f2e4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_quote"><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
+=C2=A0 =C2=A0 if (!GetSystemDirectoryW(win_sys_path, _countof(win_sys_path=
)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wcsncpy(win_sys_path, default_sys_path, _count=
of(win_sys_path));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 win_sys_path[_countof(win_sys_path) - 1] =3D L=
&#39;\0&#39;;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Is there need in addin=
g null terminator to win_sys_path?</div><div><br></div><div>Since it is sta=
tic, it will be initialized with zeroes at startup. Besides, wcsncpy also a=
dds null terminator.</div></div><div><br></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div></div></=
div>

--0000000000003f80d705774f2e4b--

