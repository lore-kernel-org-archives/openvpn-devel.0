MIME-Version: 1.0
References: <20230201041831.2259419-1-selva.nair@...277...>
 <CAGyAFMVw=QzQDaBo6RE9Juh5+SObuCmAptT+yh1X44DL2g7bBQ@...278...>
 <CAKuzo_jAfKrpRpi2YHRwwXSGVz_NSy8gYwybLajFt4ZJyJ=MVg@...278...>
 <CAGyAFMU74M8k7EaVoWQ4H1w9XStFBWmqFKucebQ9wid-hmLgYg@...278...>
In-Reply-To: <CAGyAFMU74M8k7EaVoWQ4H1w9XStFBWmqFKucebQ9wid-hmLgYg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 1 Feb 2023 11:54:37 -0500
Message-ID: <CAKuzo_j_HeHFQH8rXNUtMzjPD8DWAgKobM5v5wdW-qGb4LdP0w@...278...>
Content-Type: multipart/alternative; boundary="000000000000a52ec705f3a64ede"
Subject: Re: [Openvpn-devel] [PATCH] block-dns using iservice: fix a
 potential double free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000a52ec705f3a64ede
Content-Type: text/plain; charset="UTF-8"

>
>
> Also I replaced 0x%x with %u in win_block_dns_service() for
> consistency. You may want to do it in your patch too :)
>

We have at least another place where it's %x, so will leave that for
another day. btw, shouldn't it be %d?

Selva

--000000000000a52ec705f3a64ede
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
Also I replaced 0x%x with %u in win_block_dns_service() for<br>
consistency. You may want to do it in your patch too :)<br></blockquote><di=
v><br></div><div>We have at least another place where it&#39;s %x, so will =
leave that for<br></div><div>another day. btw, shouldn&#39;t it be %d?</div=
><div><br></div><div>Selva</div></div></div>

--000000000000a52ec705f3a64ede--

