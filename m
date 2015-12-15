MIME-Version: 1.0
In-Reply-To: <CAKuzo_i9gn_0f0cvKAgp2t3Gi2UL5GcLJRrUiZDEZYLpHM=RWA@...278...>
References: <CAHSx_StWk=Es9qg9TSq6yXACPhTLneeeUWNDDaKqp06S0x6R=w@...278...>
	<1449766646-3519-1-git-send-email-wayne@...2099...>
	<CAHSx_SuDffEw7Ufn6ehXJpjLvh8HPtaTxVnnaMBcKMHA5qRuZA@...278...>
	<CAKuzo_i9gn_0f0cvKAgp2t3Gi2UL5GcLJRrUiZDEZYLpHM=RWA@...278...>
From: Wayne Davison <wayne@...2099...>
Date: Mon, 14 Dec 2015 23:01:57 -0800
Message-ID: <CAHSx_SuALAAmshBFD6WDy5c_pT9AD6TE2XUzoLjna-V3BTY_Yg@...278...>
Content-Type: multipart/alternative; boundary=089e013cba0eba8ef20526ea5e1a
Subject: Re: [Openvpn-devel] [PATCH] Improve stdin prompting section,
 fixing CR prompting.
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

--089e013cba0eba8ef20526ea5e1a
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 14, 2015 at 4:10 PM, Selva Nair <selva.nair@...277...> wrote:

> I took a quick look and it seems a simplified patch that addresses the
> most critical-sounding issue (challenge/reponse not prompted for
> from stdin) may be more useful.
>

That's exactly what that patch is.

From the cover-letter to the patches:
>

That's the older patch set.  The newer one (based on newer master changes
in misc.c) separates the fix from the feature.

If the response is unchanging, its a misuse of challenge/response.
>

It's only mostly unchanging.  The user can respond "push", "sms", "phone",
or enter a number from the generator app as they see fit. For me, I use
"push" most of the time.  I figure if the app is going to support reading
the prompts from a file, it should support all the prompts the same way for
consistency.

..wayne..

--089e013cba0eba8ef20526ea5e1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Dec 14, 2015 at 4:10 PM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><div>I took a quick look an=
d it seems a simplified patch that addresses the most critical-sounding iss=
ue (challenge/reponse not prompted for</div><div>from stdin) may be more us=
eful.<br></div></div></div></div></div></blockquote><div><br></div><div>Tha=
t&#39;s exactly what that patch is.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><div>From the cover-letter to the patches:<br></div></div>=
</div></div></div></blockquote><div><br></div><div>That&#39;s the older pat=
ch set.=C2=A0 The newer one (based on newer master changes in misc.c) separ=
ates the fix from the feature.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div dir=3D"ltr"><div><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><div>If the response is unchanging, its a misuse of challenge/respo=
nse.<br></div></div></div></div></div></blockquote><div><br></div><div>It&#=
39;s only mostly unchanging.=C2=A0 The user can respond &quot;push&quot;, &=
quot;sms&quot;, &quot;phone&quot;, or enter a number from the generator app=
 as they see fit. For me, I use &quot;push&quot; most of the time.=C2=A0 I =
figure if the app is going to support reading the prompts from a file, it s=
hould support all the prompts the same way for consistency.</div><div><br><=
/div><div>..wayne..</div></div></div></div>

--089e013cba0eba8ef20526ea5e1a--

