MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-4-simon@...2293...>
In-Reply-To: <20191219223917.1614-4-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 13:43:08 +0200
Message-ID: <CAGyAFMUQqDSR7UwaofiGGhL9vhHKE6YzNw+CObyEahsyBdw7-A@...278...>
Content-Type: multipart/alternative; boundary="0000000000002a03bd059a212f37"
Subject: Re: [Openvpn-devel] [PATCH 4/7] wintun: register ring buffers when
 iterating adapters
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

--0000000000002a03bd059a212f37
Content-Type: text/plain; charset="UTF-8"

Hi,

Compiled and tested, works as expected. One thing:


> +            if (tun_try_open_device(tt, *device_guid,
> device_instance_id_interface))
>              {
>                  break;
>              }
>

We leak tt->hand here if we don't break - in the next loop iteration we
overwrite tt->hand
and previous value left unclosed.

Maybe add

    CloseHandle(tt->hand)
    tt->hand = NULL;

after "if" statement and before "next" label ?

-- 
-Lev

--0000000000002a03bd059a212f37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Compiled and tested, wor=
ks as expected. One thing:</div><div class=3D"gmail_quote"><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tun_try_open_device(tt, *dev=
ice_guid, device_instance_id_interface))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br>=
</div><div class=3D"gmail_quote"><div>We leak tt-&gt;hand here if we don&#3=
9;t break - in the next loop iteration we overwrite tt-&gt;hand</div><div>a=
nd previous value left unclosed.=C2=A0</div></div><div><br></div><div>Maybe=
 add=C2=A0</div><div><br></div><div>=C2=A0 =C2=A0 CloseHandle(tt-&gt;hand)<=
/div><div>=C2=A0 =C2=A0 tt-&gt;hand =3D NULL;=C2=A0</div><div><br></div><di=
v>after &quot;if&quot; statement and before &quot;next&quot; label ?</div><=
div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Le=
v</div></div>

--0000000000002a03bd059a212f37--

