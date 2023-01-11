MIME-Version: 1.0
References: <20230111062910.1846688-1-selva.nair@...277...>
In-Reply-To: <20230111062910.1846688-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 11 Jan 2023 01:41:21 -0500
Message-ID: <CAKuzo_hxBhGMOcaApSKJRgL1zC391Y7_wC-HcpKTT6KsmjcHag@...278...>
Content-Type: multipart/alternative; boundary="000000000000c48b6005f1f74a4e"
Subject: Re: [Openvpn-devel] [PATCH] Include CE_DISABLED status of remote in
 "remote-entry-get" response
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000c48b6005f1f74a4e
Content-Type: text/plain; charset="UTF-8"

Error in commit message:

  0,vpn.example.org,udp,enabled
>   2,vpn.example.net,tcp-client,disabled
>   1,vpn.example.com,udp,enabled
>

That should have been

  0,vpn.example.org,udp,enabled
  1,vpn.example.net,tcp-client,disabled
  2,vpn.example.com,udp,enabled

with indices 0, 1, 2 ordered.

--000000000000c48b6005f1f74a4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Error in commit message:</div><div dir=3D=
"ltr"><br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">=C2=A0 0,<a href=3D"http://vpn.example.org" rel=3D"norefe=
rrer" target=3D"_blank">vpn.example.org</a>,udp,enabled<br>
=C2=A0 2,<a href=3D"http://vpn.example.net" rel=3D"noreferrer" target=3D"_b=
lank">vpn.example.net</a>,tcp-client,disabled<br>
=C2=A0 1,<a href=3D"http://vpn.example.com" rel=3D"noreferrer" target=3D"_b=
lank">vpn.example.com</a>,udp,enabled<br></blockquote><div><br></div><div>T=
hat should have been=C2=A0</div><div><br></div><div>=C2=A0 0,<a href=3D"htt=
p://vpn.example.org/" rel=3D"noreferrer" target=3D"_blank">vpn.example.org<=
/a>,udp,enabled</div>=C2=A0 1,<a href=3D"http://vpn.example.net/" rel=3D"no=
referrer" target=3D"_blank">vpn.example.net</a>,tcp-client,disabled<br>=C2=
=A0 2,<a href=3D"http://vpn.example.com/" rel=3D"noreferrer" target=3D"_bla=
nk">vpn.example.com</a>,udp,enabled</div><div class=3D"gmail_quote"><br></d=
iv><div class=3D"gmail_quote">with indices 0, 1, 2 ordered.</div></div>

--000000000000c48b6005f1f74a4e--

