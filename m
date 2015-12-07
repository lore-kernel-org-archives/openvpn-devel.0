MIME-Version: 1.0
In-Reply-To: <20151207071906.GS24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<1449446507-16654-2-git-send-email-selva.nair@...277...>
	<20151207071906.GS24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Dec 2015 10:10:55 -0500
Message-ID: <CAKuzo_irs7y+41FMM6i3T6Y1Xo-bA+DXgN7hxuS1TXvPFKWFwQ@...278...>
Content-Type: multipart/alternative; boundary=001a114b2a52a61c3b052650446a
Subject: Re: [Openvpn-devel] [PATCH 2.3] Add an autoconf macro to check
	WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b2a52a61c3b052650446a
Content-Type: text/plain; charset=UTF-8

Hi,


> On Sun, Dec 06, 2015 at 07:01:47PM -0500, Selva Nair wrote:
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>
> NAK for 2.3 - what we have there works well enough.
>

The reason for adding it to 2.3 was anticipating it will have to be built
for vista+ if the dns-leak patch goes in.

In fact I wrote it the intet_ntop issue showed up (fixed by commit
f96baabc6cf1.. in master)  -- had I seen that commit first, wouldn't have
though of this macro, probably.

As for how the macro works, will write separately.

Selva

--001a114b2a52a61c3b052650446a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>Hi,</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">
On Sun, Dec 06, 2015 at 07:01:47PM -0500, Selva Nair wrote:<br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
NAK for 2.3 - what we have there works well enough.<br></blockquote><div><b=
r></div><div>The reason for adding it to 2.3 was anticipating it will have =
to be built for vista+ if the dns-leak patch goes in.=C2=A0<br></div><div><=
br></div><div>In fact I wrote it the intet_ntop issue showed up (fixed by c=
ommit f96baabc6cf1.. in master) =C2=A0-- had I seen that commit first, woul=
dn&#39;t have though of this macro, probably.</div><div><br></div><div>As f=
or how the macro works, will write separately.</div><div><br></div><div>Sel=
va</div></div></div></div>

--001a114b2a52a61c3b052650446a--

