MIME-Version: 1.0
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-3-a@...2181...>
In-Reply-To: <20220812130657.29899-3-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 12 Aug 2022 19:30:18 +0300
Message-ID: <CAGyAFMWpvk-+RfG1ebeH8A+0thLzqLRuQ8tFENzonxkYumfN9w@...278...>
Content-Type: multipart/alternative; boundary="000000000000d34c9a05e60dcc10"
Subject: Re: [Openvpn-devel] [PATCH v100 02/10] dco-win: introduce low-level
 code for handling ovpn-dco-win in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000d34c9a05e60dcc10
Content-Type: text/plain; charset="UTF-8"

Hi,

General note - this commit has no commit message and introduces a set of
functions which are not yet called. Does it really make sense to split
dco-win support into two commits?


 src/openvpn/ovpn-dco-win.h          | 108 ++++++++
>

We have ovpn_dco_linux.h and ovpn-dco-win.h. Should we unify the naming?


+
> +int
> +dco_do_read(dco_context_t *dco)
> +{
> +    /* no-op on windows */
> +    return 0;
> +}
> +
> +int
> +dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
> +{
> +    /* no-op on windows */
> +    return 0;
> +}
> +
> +void
> +dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
> +{
> +    /* no-op on windows */
> +}
>

Those are not supposed to be called on Windows. Shall we assert?



> +struct dco_context {
> +    bool real_tun_init;
> +    struct tuntap *tt;
> +};
>

Hm.. we add "real_tun_init" in this commit and remove in the
follow-up("dco-win: implement ovpn-dco support in P2P Windows code path")
commit.

-Lev

--000000000000d34c9a05e60dcc10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div>=
General note - this commit has no commit message and introduces a set of fu=
nctions which are not yet called. Does it really make sense to split dco-wi=
n support into two commits?</div><div><br></div><div><br></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0src/openvpn/ovpn-dco-win.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 108 ++=
++++++<br>
</blockquote><div><br></div><div>We have ovpn_dco_linux.h and ovpn-dco-win.=
h. Should we unify the naming?</div><div><br></div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">+<br>
+int<br>
+dco_do_read(dco_context_t *dco)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int<br>
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+void<br>
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)<br>
+{<br>
+=C2=A0 =C2=A0 /* no-op on windows */<br>
+}<br></blockquote><div><br></div><div>Those are not supposed to be called =
on Windows. Shall we assert?</div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+struct dco_context {<br>
+=C2=A0 =C2=A0 bool real_tun_init;<br>
+=C2=A0 =C2=A0 struct tuntap *tt;<br>
+};<br></blockquote><div><br></div><div>Hm.. we add &quot;real_tun_init&quo=
t; in this commit and remove in the follow-up(&quot;dco-win: implement ovpn=
-dco support in P2P Windows code path&quot;) commit.=C2=A0=C2=A0</div><div>=
<br></div><div>-Lev</div></div></div>

--000000000000d34c9a05e60dcc10--

