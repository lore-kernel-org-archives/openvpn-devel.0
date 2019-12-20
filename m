MIME-Version: 1.0
References: <CAGyAFMUQqDSR7UwaofiGGhL9vhHKE6YzNw+CObyEahsyBdw7-A@...278...>
 <20191220161117.1434-4-simon@...2293...>
In-Reply-To: <20191220161117.1434-4-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 20:33:34 +0200
Message-ID: <CAGyAFMXxKQaroPRMFNFU7pATm7=t7RiQQ5aspUEWiK9FQ=iDuQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000f6e27d059a26eaab"
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] wintun: register ring buffers
 when iterating adapters
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

--000000000000f6e27d059a26eaab
Content-Type: text/plain; charset="UTF-8"

Hi,

+        /* Wintun adapter may be considered "open" after ring buffers are
> successfuly registered. */
> +        if (!wintun_register_ring_buffer(tt))
> +        {
>

Here we pass incorrect handle to wintun_register_ring_buffer - tt->hand is
0 at that point,
since CreateFile value was assigned to h.

-- 
-Lev

--000000000000f6e27d059a26eaab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div dir=3D"ltr"><br></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* Wintun adapter may be considered &quot;open&quot; after ri=
ng buffers are successfuly registered. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wintun_register_ring_buffer(tt))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br></blockquote><div><br></div><div>Here we =
pass incorrect=C2=A0handle to wintun_register_ring_buffer - tt-&gt;hand is =
0 at that point,</div><div>since CreateFile value was assigned to h.</div><=
div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev<=
/div></div>

--000000000000f6e27d059a26eaab--

