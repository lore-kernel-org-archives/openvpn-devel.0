MIME-Version: 1.0
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
 <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
 <ZxkNPBAus8JGMehg@...1296...>
 <babedac6-d487-4df6-b054-b961209be459@...277...>
 <CAKuzo_ifn6ma288DdFNm_=AURyU+uneuxo5HWuB6FHXTCDpVrQ@...278...>
 <56038512-a84a-4bb7-a1e0-38a0d4f99b70@...277...>
In-Reply-To: <56038512-a84a-4bb7-a1e0-38a0d4f99b70@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Oct 2024 12:27:10 -0400
Message-ID: <CAKuzo_jRr3cDGpPv3B2-CSah8x92VN1stqEtRjSEcMCXFLcv-A@...278...>
Content-Type: multipart/alternative; boundary="0000000000008fdfbb0625275cc5"
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

--0000000000008fdfbb0625275cc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:47=E2=80=AFAM Razvan Cojocaru <rzvncj@...277...>=
 wrote:

> On 10/23/24 18:25, Selva Nair wrote:
> > Wouldn't pushing "HALT" instead of "AUTH_FAILED" work in this case?
> > As in the management command "client-kill {cid} HALT" which calls
> > send_restart() with kill_msg =3D "HALT".
>
> Possibly, however the intent has always been to use this feature to
> reject (authorize) clients (so this is a corner case of that, just that
> we can retract authorization at a later time), and in addition
> considerable work has already been done that relies on the AUTH_FAILED
> code paths.
>
>
Looks like a misuse of AUTH_FAILED to me. To kill a client while not in the
authentication phase, use code paths meant for that purpose.

Selva

--0000000000008fdfbb0625275cc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 23, 2024=
 at 11:47=E2=80=AFAM Razvan Cojocaru &lt;<a href=3D"mailto:rzvncj@...277...=
" target=3D"_blank">rzvncj@...277...</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 10/23/24 18:25, Selva Nair wrote:<br>
&gt; Wouldn&#39;t pushing &quot;HALT&quot; instead of &quot;AUTH_FAILED&quo=
t; work in this case?<br>
&gt; As in the management=C2=A0command &quot;client-kill {cid} HALT&quot; w=
hich calls<br>
&gt; send_restart() with kill_msg =3D &quot;HALT&quot;.<br>
<br>
Possibly, however the intent has always been to use this feature to <br>
reject (authorize) clients (so this is a corner case of that, just that <br>
we can retract authorization at a later time), and in addition <br>
considerable work has already been done that relies on the AUTH_FAILED <br>
code paths.<br>
<br></blockquote><div><br></div><div>Looks like a=C2=A0misuse of AUTH_FAILE=
D to me. To kill a client while not in the</div><div>authentication phase, =
use code paths meant for that purpose.=C2=A0</div><div><br></div><div>Selva=
</div></div></div>
</div>

--0000000000008fdfbb0625275cc5--

