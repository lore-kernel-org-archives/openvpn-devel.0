MIME-Version: 1.0
In-Reply-To: <20170915161420.GN70062@...1296...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <20170915154011.GM70062@...1296...>
 <CAKuzo_iHmRi9t2fANHy+GBZsLPWZzgXyBBgmsF9hJeToOvAh0g@...278...>
 <20170915161420.GN70062@...1296...>
From: Selva <selva.nair@...277...>
Date: Fri, 15 Sep 2017 12:54:20 -0400
Message-ID: <CAKuzo_hsxAeoo1f8kPthxZd7hSi02_9cBaOZBVAdUJJM=Evm1g@...278...>
Content-Type: multipart/alternative; boundary="001a1134fd3eb99b6605593d3f6b"
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1134fd3eb99b6605593d3f6b
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Sep 15, 2017 at 12:14 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Sep 15, 2017 at 11:53:59AM -0400, Selva wrote:
> > No it doesn't change any functionality. By not including OPT_P_CONNECTION
> > in the mask sent to verify permission the previous connection blacks
> check
> > is disabled.  And this is done only when pull_mode is True.
>
> I was totally misreading the code, apologies :-) - now I read up
> on what OPT_P_CONNECTION *does*, and it's not a "normal" flag for
> "this is not an acceptable option in this mode" but a "warning if..."
> one.
>
> [..]
> > The key here is that check pull_mode to know that we are processing a
> > pushed option.
>
> What about moving the pull_mode check into verify_permission() so it
> applies to all pushed option that could trigger the warning (as Arne
> pointed out)?


I suppose Arne's statement is "theoretical"  -- I could not find any other
option that could be in a connection block and pushable. Are there any?

Anyway, the reason I did not add the check in verify_permission() is that
pull_mode is not as such defined there -- easily fixed at the expense of
code repetition and associated "risks.."

But pull_mode = allowed & OPT_P_PLL_MODE is probably never going to change,
so this may be its a lame excuse. I'll do a v2 if that's the preferred way.

Selva

--001a1134fd3eb99b6605593d3f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Fri, Sep 15, 2017 at 12:14 PM, G=
ert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Hi,<br>
<span><br>
On Fri, Sep 15, 2017 at 11:53:59AM -0400, Selva wrote:<br>
&gt; No it doesn&#39;t change any functionality. By not including OPT_P_CON=
NECTION<br>
&gt; in the mask sent to verify permission the previous connection blacks c=
heck<br>
&gt; is disabled.=C2=A0 And this is done only when pull_mode is True.<br>
<br>
</span>I was totally misreading the code, apologies :-) - now I read up<br>
on what OPT_P_CONNECTION *does*, and it&#39;s not a &quot;normal&quot; flag=
 for<br>
&quot;this is not an acceptable option in this mode&quot; but a &quot;warni=
ng if...&quot;<br>
one.<br>
<br>
[..]<br>
<span>&gt; The key here is that check pull_mode to know that we are process=
ing a<br>
&gt; pushed option.<br>
<br>
</span>What about moving the pull_mode check into verify_permission() so it=
<br>
applies to all pushed option that could trigger the warning (as Arne<br>
pointed out)?</blockquote><div><br></div><div>I suppose Arne&#39;s statemen=
t is &quot;theoretical&quot; =C2=A0-- I could not find any other</div><div>=
option that could be in a connection block and pushable. Are there any?</di=
v><div><br></div><div>Anyway, the reason I did not add the check in verify_=
permission() is that</div><div>pull_mode is not as such defined there -- ea=
sily fixed at the expense of=C2=A0</div><div>code repetition and associated=
 &quot;risks..&quot;=C2=A0</div><div><br></div><div>But pull_mode =3D allow=
ed &amp; OPT_P_PLL_MODE is probably never going to change,</div><div>so thi=
s may be its a lame excuse. I&#39;ll do a v2 if that&#39;s the preferred wa=
y.</div><div><br></div><div>Selva</div></div></div></div>

--001a1134fd3eb99b6605593d3f6b--

