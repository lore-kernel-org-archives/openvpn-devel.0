MIME-Version: 1.0
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
 <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
 <ZxkNPBAus8JGMehg@...1296...>
 <babedac6-d487-4df6-b054-b961209be459@...277...>
In-Reply-To: <babedac6-d487-4df6-b054-b961209be459@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Oct 2024 11:25:34 -0400
Message-ID: <CAKuzo_ifn6ma288DdFNm_=AURyU+uneuxo5HWuB6FHXTCDpVrQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000038602c062526808c"
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Razvan Cojocaru <rzvncj@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--00000000000038602c062526808c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:03=E2=80=AFAM Razvan Cojocaru <rzvncj@...277...>=
 wrote:

> On 10/23/24 17:50, Gert Doering wrote:
> > OK, so I see what is happening - you're sending an AUTH_FAILED "out of
> > the blue", not in response to a client handshake, right?
>
> Exactly. In response to a client handshake there's no problem.
>
> > OpenVPN 2 *should* invalidate the token upon the reconnect (and then
> > getting an AUTH_FAILED)... so what happens in this case if you let it
> > reconnect?
>
> If we let it reconnect, the first re-connection attempt will fail at the
> handshake stage as expected.
>

> But OpenVPN GUI tools will tend to show _two_ failed connections (the
> first "out of the blue" AUTH_FAILED one, and the second actual one),
> which is confusing for clients.
>

Wouldn't pushing "HALT" instead of "AUTH_FAILED" work in this case?
As in the management command "client-kill {cid} HALT" which calls
send_restart() with kill_msg =3D "HALT".

Selva

--00000000000038602c062526808c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 23, 2024=
 at 11:03=E2=80=AFAM Razvan Cojocaru &lt;<a href=3D"mailto:rzvncj@...277...=
" target=3D"_blank">rzvncj@...277...</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 10/23/24 17:50, Gert Doering wrote:<=
br>
&gt; OK, so I see what is happening - you&#39;re sending an AUTH_FAILED &qu=
ot;out of<br>
&gt; the blue&quot;, not in response to a client handshake, right?<br>
<br>
Exactly. In response to a client handshake there&#39;s no problem.<br>
<br>
&gt; OpenVPN 2 *should* invalidate the token upon the reconnect (and then<b=
r>
&gt; getting an AUTH_FAILED)... so what happens in this case if you let it<=
br>
&gt; reconnect?<br>
<br>
If we let it reconnect, the first re-connection attempt will fail at the <b=
r>
handshake stage as expected.<br></blockquote><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><br>
But OpenVPN GUI tools will tend to show _two_ failed connections (the <br>
first &quot;out of the blue&quot; AUTH_FAILED one, and the second actual on=
e), <br>
which is confusing for clients.<br></blockquote><div><br></div><div>Wouldn&=
#39;t pushing &quot;HALT&quot; instead of &quot;AUTH_FAILED&quot; work in t=
his case?=C2=A0</div><div>As in the management=C2=A0command &quot;client-ki=
ll {cid} HALT&quot; which calls</div><div>send_restart() with kill_msg =3D =
&quot;HALT&quot;.</div><div><br></div><div>Selva</div></div></div>
</div>

--00000000000038602c062526808c--

