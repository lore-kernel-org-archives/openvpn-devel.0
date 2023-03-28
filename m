MIME-Version: 1.0
References: <20230327171236.51771-1-selva.nair@...277...>
 <202303280725.32S7PC7q076380@...2054...>
In-Reply-To: <202303280725.32S7PC7q076380@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 28 Mar 2023 09:34:58 -0400
Message-ID: <CAKuzo_g-Zuob_vyBP9-odEUS5=yR0nq17z_hXkWskC=CMFKZWQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000e5cb9105f7f5edb7"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Bug-fix: segfault in
 dco_get_peer_stats()
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

--000000000000e5cb9105f7f5edb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 3:25=E2=80=AFAM Gert Doering <gert@...1296...> wrot=
e:

> Acked-by: Antonio Quartulli <a@...2181...>
>
> Thanks for the good find.  Since I could reproduce the crash yesterday
> (and I do need management for it) I can verify that it does no longer
> crash with the patch.
>
> (For whatever reason, --tls-version-max 1.0 did not suffice to trigger
> the error this morning, but --tls-version-min 1.3 + management + bytecount
> still did)
>

Since then I've found this can be triggered quite simply by adding
"--status /dev/stdout" or some file to the client options.

Which means this should also fix #301

Selva

--000000000000e5cb9105f7f5edb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 28, 2023 at 3:25=E2=80=AF=
AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">ge=
rt@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Acked-by: Antonio Quartulli &lt;<a href=3D"mailto:a@...2181...=
" target=3D"_blank">a@...2181...</a>&gt;<br>
<br>
Thanks for the good find.=C2=A0 Since I could reproduce the crash yesterday=
<br>
(and I do need management for it) I can verify that it does no longer<br>
crash with the patch.<br>
<br>
(For whatever reason, --tls-version-max 1.0 did not suffice to trigger<br>
the error this morning, but --tls-version-min 1.3 + management + bytecount<=
br>
still did)<br></blockquote><div><br></div><div>Since then I&#39;ve found th=
is can be triggered quite simply by adding &quot;--status /dev/stdout&quot;=
 or some file to the client options.</div><div><br></div><div>Which means t=
his should also fix #301</div><div><br></div><div>Selva</div></div></div>

--000000000000e5cb9105f7f5edb7--

