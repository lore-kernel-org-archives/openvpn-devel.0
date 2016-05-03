MIME-Version: 1.0
In-Reply-To: <CAKuzo_hB4ASxbjXyujU0sCsKhdw+js-xKEzH-hL_XjJCjiJ4cA@...278...>
References: <CAKBOYXcP4hwNAAm2M_7EubbUmRpGe9G5-dLQKM=_pS4cOQmm1Q@...278...>
	<CAKuzo_hB4ASxbjXyujU0sCsKhdw+js-xKEzH-hL_XjJCjiJ4cA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 2 May 2016 20:04:35 -0400
Message-ID: <CAKuzo_hRhNzdLkCFkkJDfnm4qw5r_fGWu0DwmTFRyi7jaPC+2A@...278...>
Content-Type: multipart/alternative; boundary=047d7bd75984dcb1b20531e4db27
Subject: Re: [Openvpn-devel] [PATCH] Prompt for challenge properly
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joshua Deare <josh@...2133...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bd75984dcb1b20531e4db27
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 12, 2016 at 8:01 PM, Selva Nair <selva.nair@...277...> wrote:

>
>  http://article.gmane.org/gmane.network.openvpn.devel/10868
> On Tue, Apr 12, 2016 at 7:20 PM, Joshua Deare <josh@...2133...> wrote:
>
>> Currently, when a client provides a file to auth-user-pass OpenVPN
>> won't prompt for a challenge code if it is expecting a
>> static-challenge or dynamic-challenge.  This patch simply prompts for
>> the challenge token if an auth file is provided AND we need a
>> challenge token.
>>
>
> I have a patch on this waiting for review
>
>  http://article.gmane.org/gmane.network.openvpn.devel/10868
>
> Does it work for you? Could you please provide a review?
>

Just to complete this thread, the patch referred to above is now in master
and 2.3. It should take care of the bug reported here.

Selva

--047d7bd75984dcb1b20531e4db27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Apr 12, 2016 at 8:01 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><br><=
div class=3D"gmail_extra">=C2=A0<a href=3D"http://article.gmane.org/gmane.n=
etwork.openvpn.devel/10868" target=3D"_blank">http://article.gmane.org/gman=
e.network.openvpn.devel/10868</a><div class=3D"gmail_quote"><span class=3D"=
">On Tue, Apr 12, 2016 at 7:20 PM, Joshua Deare <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:josh@...2133..." target=3D"_blank">josh@...2133...</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Currently, =
when a client provides a file to auth-user-pass OpenVPN<br>
won&#39;t prompt for a challenge code if it is expecting a<br>
static-challenge or dynamic-challenge.=C2=A0 This patch simply prompts for<=
br>
the challenge token if an auth file is provided AND we need a<br>
challenge token.<br></blockquote><div><br></div></span><div>I have a patch =
on this waiting for review<br><br>=C2=A0<a href=3D"http://article.gmane.org=
/gmane.network.openvpn.devel/10868" target=3D"_blank">http://article.gmane.=
org/gmane.network.openvpn.devel/10868</a><br><br></div><div>Does it work fo=
r you? Could you please provide a review?<br></div></div></div></div></bloc=
kquote><div><br></div><div>Just to complete this thread, the patch referred=
 to above is now in master and 2.3. It should take care of the bug reported=
 here.<br><br></div><div>Selva <br></div></div><br></div></div>

--047d7bd75984dcb1b20531e4db27--

