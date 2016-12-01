MIME-Version: 1.0
In-Reply-To: <1480545687-19365-1-git-send-email-davids@...515...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 30 Nov 2016 21:51:10 -0500
Message-ID: <CAKuzo_jqKiXA9iObC0MOvYjGhn6o6wuqw2p=xfbfvdLKTzj61g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c1254220627fe05428fe67a
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c1254220627fe05428fe67a
Content-Type: text/plain; charset=UTF-8

Hi,

Some nitpicking on the eleventh hour...

The comment does not agree with the code:


> +++ b/src/openvpn/push.c
> @@ -333,6 +333,16 @@ prepare_push_reply (struct context *c, struct
> gc_arena *gc,
>                        print_in_addr_t (ifconfig_local, 0, gc),
>                        print_in_addr_t (c->c2.push_ifconfig_remote_
> netmask,
>                                         0, gc));
> +
> +      /* Warn if ifconfig_remote_netmask does not contain
> +       * subnet mask in subnet topology */
>

If we go by the code this should be subnet and net30 topology.
By the way, style alert -- we want the ending */ on a line by itself, don't
we?


> +      if ((c->options.topology == TOP_SUBNET || c->options.topology ==
> TOP_NET30)
> +          && (c->c2.push_ifconfig_remote_netmask & 0xff000000) !=
> 0xff000000)
> +        {
> +          msg(M_WARN, "WARNING: When --topology is subnet or net30, the
> second argument "
> +              "to --ifconfig-push MUST be a subnet mask.  This client
> will not be able "
> +              "to connect.");

+        }
>      }
>

I don't know the code path well enough, so cant say anything technical...

Selva

--94eb2c1254220627fe05428fe67a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>Hi,</div><div><br></div><div>Some nitpicking on the eleventh hour...</div>=
<div><br></div><div>The comment does not agree with the code:</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
+++ b/src/openvpn/push.c<br>
@@ -333,6 +333,16 @@ prepare_push_reply (struct context *c, struct gc_arena=
 *gc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0print_in_addr_t (ifconfig_local, 0, gc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0print_in_addr_t (c-&gt;c2.push_ifconfig_remote_<wbr>netmask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, gc));=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 /* Warn if ifconfig_remote_netmask does not contain<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0* subnet mask in subnet topology */<br>
</blockquote><div><br></div><div>If we go by the code this should be subnet=
 and net30 topology.</div><div>By the way, style alert -- we want the endin=
g */ on a line by itself, don&#39;t we?</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 if ((c-&gt;options.topology =3D=3D =
TOP_SUBNET || c-&gt;options.topology =3D=3D TOP_NET30)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (c-&gt;c2.push_ifconfig_remo=
te_<wbr>netmask &amp; 0xff000000) !=3D 0xff000000)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;WARNING: When --topol=
ogy is subnet or net30, the second argument &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;to --ifconfig-push =
MUST be a subnet mask.=C2=A0 This client will not be able &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;to connect.&quot;);=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>I don&#39;t know =
the code path well enough, so cant say anything technical...</div><div><br>=
</div><div>Selva=C2=A0</div></div></div></div>

--94eb2c1254220627fe05428fe67a--

