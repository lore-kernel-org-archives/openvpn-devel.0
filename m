MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-22-arne@...1227...>
In-Reply-To: <20211019183127.614175-22-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Oct 2021 18:08:06 -0400
Message-ID: <CAKuzo_gMDkpBHresSESzGcZLGQJofu_FMNz_A8NPhYJk9T_buQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000447d9b05ced00482"
Subject: Re: [Openvpn-devel] [PATCH v3 21/21] Always use 8192 bytes for
 ERR_BUF_SIZE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000447d9b05ced00482
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> The signature messages required by external key managed also break
> the 1280 limit. To also avoid this surprise of different behaviour
> with PKCS11 enabled/disable, always use the larger size.
>

This may be enough in most cases, but to be safer, shall we increase it to
10240? I have seen up to 6 K handshake messages when undigested messages
are to be passed to the management interface and that's already 8K with
base64 overhead.

That said, I think we need a better solution. As it stands it's a bit silly
that we keep allocating required buffers dynamically at the origination
point, a number of places in manage.c, all the way up to x_msg_va() in
error.c where it gets silently truncated to a hard-coded size.

Can we use the return value of vsnprintf() in x_msg_va() to determine the
size of the buffer required? Not sure whether that is reliable on all
platforms. Only the size of m1 has to be determined as m2 has a
more-or-less predictable overhead on top of that.

Selva

--000000000000447d9b05ced00482
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">The signature messages req=
uired by external key managed also break<br>
the 1280 limit. To also avoid this surprise of different behaviour<br>
with PKCS11 enabled/disable, always use the larger size.<br></blockquote><d=
iv><br></div><div>This may be enough in most cases, but to be safer, shall =
we increase it to 10240? I have seen up to 6 K handshake=C2=A0messages when=
 undigested messages are to be passed to the management interface and that&=
#39;s already 8K with base64 overhead.</div><div><br></div><div>That said, =
I think we need a better solution. As it stands it&#39;s a bit silly that w=
e keep allocating required buffers dynamically at the origination point, a =
number of=C2=A0places in manage.c, all the way up to=C2=A0x_msg_va() in err=
or.c where it gets silently truncated to a hard-coded size.=C2=A0</div><div=
><br></div><div>Can we use the return value of vsnprintf() in x_msg_va() to=
 determine the size of the buffer required? Not sure whether that is reliab=
le on all platforms. Only the size of m1 has to be determined as m2 has a m=
ore-or-less predictable overhead on top of that.</div><div><br></div><div>S=
elva</div></div></div>

--000000000000447d9b05ced00482--

