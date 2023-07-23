MIME-Version: 1.0
References: <20230128215901.2207208-1-selva.nair@...277...>
 <202307230928.36N9SIIB029241@...2054...>
In-Reply-To: <202307230928.36N9SIIB029241@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 23 Jul 2023 10:46:17 -0400
Message-ID: <CAKuzo_gLqfih_Y4_G3P_wLus63f5o1OFXux_rYL=_J7ufxiQXQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000006ebf79060128903a"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Improve signal handling
 using POSIX sigaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000006ebf79060128903a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 23, 2023 at 5:28=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

>
> The actual "change to POSIX ways" part of this is fairly trivial
> and easy to understand :-) - though I do wonder why you're using
> an extra variable for block_mask -> sa.sa_mask, and not using
> sigfillset(&sa.sa_mask) - at least on BSD on Linux, both are sigset_t,
> so it should do the same thing in a slightly more direct way.
>

I can't recall any particular reason for having that intermediate variable.
It does look redundant.

Now I wish someone could review 2/2 of this patch-set. That's where further
potential
loss of signal during signal-reset is avoided.

Selva

--0000000000006ebf79060128903a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 23, 2023 at 5:28=E2=80=AF=
AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ge=
rt@...1296...</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
The actual &quot;change to POSIX ways&quot; part of this is fairly trivial<=
br>
and easy to understand :-) - though I do wonder why you&#39;re using<br>
an extra variable for block_mask -&gt; sa.sa_mask, and not using<br>
sigfillset(&amp;sa.sa_mask) - at least on BSD on Linux, both are sigset_t,<=
br>
so it should do the same thing in a slightly more direct way.<br></blockquo=
te><div><br></div><div>I can&#39;t recall any particular reason for=C2=A0ha=
ving that intermediate variable.</div><div>It does look redundant.=C2=A0</d=
iv><div><br></div><div>Now I wish someone=C2=A0could review 2/2 of this pat=
ch-set. That&#39;s where further potential</div><div>loss of signal during =
signal-reset is avoided.</div><div><br></div><div>Selva</div></div></div>

--0000000000006ebf79060128903a--

