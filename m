MIME-Version: 1.0
In-Reply-To: <1464130427-25002-1-git-send-email-selva.nair@...277...>
References: <1464130427-25002-1-git-send-email-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 May 2016 13:14:54 -0400
Message-ID: <CAKuzo_hOQ5COpp=RuvpHSP3WjVH_45A6Mv0M6OTuyEzp8We9Rg@...278...>
Content-Type: multipart/alternative; boundary=001a114ac8f8206d400533add170
Subject: Re: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114ac8f8206d400533add170
Content-Type: text/plain; charset=UTF-8

On Tue, May 24, 2016 at 6:53 PM, Selva Nair <selva.nair@...277...> wrote:

> Do not mask input when echo is requested. Useful for username
> input and sometimes for challenge response.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>


Patch withdrawn in deference to David's pending patches that address this
among other things..
Also this one lacks a necessary version check to ensure --echo is supported
by systemd-ask-password

Selva

--001a114ac8f8206d400533add170
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, May 24, 2016 at 6:53 PM, Selva Nair <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Do not mask input wh=
en echo is requested. Useful for username<br>
input and sometimes for challenge response.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva=
.nair@...277...</a>&gt;</blockquote><div><br></div><div>Patch withdrawn in =
deference to David&#39;s pending patches that address this among other thin=
gs..=C2=A0</div><div>Also this one lacks a necessary version check to ensur=
e --echo is supported by systemd-ask-password</div><div><br></div><div>Selv=
a</div></div></div></div>

--001a114ac8f8206d400533add170--

