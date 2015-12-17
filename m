MIME-Version: 1.0
In-Reply-To: <CAKuzo_gSB_9ET=LEJmrJpbhzzhLNCm3xFeUsgwR5HYtFH7FNqA@...278...>
References: <CAHSx_SuB8wu8_RWcfTfDhFQhrek89-Wu-pBo1FXbBNfHxRUTYg@...278...>
	<1450217793-17974-1-git-send-email-wayne@...2099...>
	<CAKuzo_gSB_9ET=LEJmrJpbhzzhLNCm3xFeUsgwR5HYtFH7FNqA@...278...>
From: Wayne Davison <wayne@...2099...>
Date: Wed, 16 Dec 2015 16:16:39 -0800
Message-ID: <CAHSx_SsSrmdcv8Ae-wnZKNSe5gNp_PmBhe=1GTadbOyOh2CSOw@...278...>
Content-Type: multipart/alternative; boundary=089e013cba0ee88bc005270cf010
Subject: Re: [Openvpn-devel] [PATCH 1/3] Fix CR prompting when user & pass
 are read from a file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013cba0ee88bc005270cf010
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 15, 2015 at 7:09 PM, Selva Nair <selva.nair@...277...> wrote:

> This doesn't work: it messes up any response already read from the
> management interface.
>

Given what options? I tested --management with --management-query-passwords
without issue.  Are you combining that with --auth-user-pass FILENAME? I
can't get that combo to work even without my changes.  I guess I'll let you
guys fix it up the right way.

..wayne..

--089e013cba0ee88bc005270cf010
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 15, 2015 at 7:09 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div>This doesn&#39;t work: it messe=
s up any response already read from the management interface.<br></div><div=
></div></blockquote></div><br>Given what options? I tested --management wit=
h --management-query-passwords without issue.=C2=A0 Are you combining that =
with=C2=A0--auth-user-pass FILENAME? I can&#39;t get that combo to work eve=
n without my changes.=C2=A0 I guess I&#39;ll let you guys fix it up the rig=
ht way.<br><br clear=3D"all"><div><div class=3D"gmail_signature">..wayne..<=
/div></div>
</div></div>

--089e013cba0ee88bc005270cf010--

