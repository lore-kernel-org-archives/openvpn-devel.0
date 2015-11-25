MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 11:37:36 -0500
Message-ID: <CAKuzo_iO98eF9LGuVjo=cMAeHEzWtanq3DmqZq2PVJbg=PfV-g@...278...>
Content-Type: multipart/alternative; boundary=001a1144424e8cc50d0525601449
Subject: Re: [Openvpn-devel] [PATCH retract] Unbreak reading
	username-password from management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144424e8cc50d0525601449
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Nov 25, 2015 at 1:34 AM, Selva Nair <selva.nair@...277...> wrote:

> Fix a bug introduced by commit 6e9373c84639382c16d9eb8f1f78f60079bb89df
>
>
My patch was DOA. While it fixes management-query-passwords it does so by
crippling the "username-only auth-file" feature. Sorry about that.

Will post another patch after more testing.

Selva

--001a1144424e8cc50d0525601449
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Wed=
, Nov 25, 2015 at 1:34 AM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mail=
to:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Fix a bug introduced by commit=
 6e9373c84639382c16d9eb8f1f78f60079bb89df<br>
<br></blockquote><div><br></div><div>My patch was DOA. While it fixes manag=
ement-query-passwords it does so by crippling the &quot;username-only auth-=
file&quot; feature. Sorry about that.</div><div><br></div><div>Will post an=
other patch after more testing.</div><div><br></div><div>Selva</div></div><=
/div></div>

--001a1144424e8cc50d0525601449--

