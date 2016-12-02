MIME-Version: 1.0
In-Reply-To: <1480707729-19578-1-git-send-email-selva.nair@...277...>
References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 2 Dec 2016 17:28:39 -0500
Message-ID: <CAKuzo_gjEiaQkmcmc94877qerC2HswZDt1XCqTSx=+7LjSz1rA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c084cace230b10542b47639
Subject: Re: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
	address in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c084cace230b10542b47639
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, Dec 2, 2016 at 2:42 PM, Selva Nair <selva.nair@...277...> wrote:

> Also correct the default ifconfig-pool end in docs and comments
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
>

Not critical for 2.4, but posted it anyway because I was bitten by this
again today:  a new server with the last address .254 included the pool and
forgot to push "--ip-win32 dynamic 0" --- windows clients can't handle .254
without that.

Selva

--94eb2c084cace230b10542b47639
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Dec 2, 2016 at 2:42 PM, Selva Nair <span dir=3D"ltr">&lt;<a =
href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Also correct the d=
efault ifconfig-pool end in docs and comments<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br></blockquote><div><br></div><d=
iv>Not critical for 2.4, but posted it anyway because I was bitten by this =
again today: =C2=A0a new server with the last address .254 included the poo=
l and forgot to push &quot;--ip-win32 dynamic 0&quot; --- windows clients c=
an&#39;t handle .254 without that.</div><div><br></div><div>Selva =C2=A0</d=
iv></div></div></div>

--94eb2c084cace230b10542b47639--

