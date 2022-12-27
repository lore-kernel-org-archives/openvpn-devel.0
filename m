MIME-Version: 1.0
References: <20210907223614.8574-1-selva.nair@...277...>
 <202212270947.2BR9lTtc096710@...2054...>
In-Reply-To: <202212270947.2BR9lTtc096710@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 27 Dec 2022 12:20:52 -0500
Message-ID: <CAKuzo_jBBf39-8i2ezapYRAgeNW6ryOWGx2-DSFeagj-1sO9yg@...278...>
Content-Type: multipart/alternative; boundary="00000000000042a1dd05f0d27a50"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow skipping multple
 remotes via management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000042a1dd05f0d27a50
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Dec 27, 2022 at 4:47 AM Gert Doering <gert@...1296...> wrote:

> Looking at the code, I do wonder why we increase the unsuccessful_attempts
> by the number of entries *skipped*
>
> -                c->options.unsuccessful_attempts++;
> +                c->options.unsuccessful_attempts += advance_count;
>

I was not sure. In response to an old patch (now obsolete) where I had
removed skip to not count as a failure, Arne had this comment:

"Also I want skip to count a failure since a UI might have some knowledge
that certain remotes cannot work and skipping therefore should also
count as "have tried this remote""

But that was when SKIP always advanced by 1.

Selva

--00000000000042a1dd05f0d27a50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 27, 2022 at 4:47 AM Gert Do=
ering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1726...=
...</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Looking at the code, I do wonder why we increase the unsuccessful_attempts<=
br>
by the number of entries *skipped*<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;options.unsu=
ccessful_attempts++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;options.unsu=
ccessful_attempts +=3D advance_count;<br></blockquote><div><br></div><div>I=
 was not sure. In response to an old patch (now obsolete) where I had remov=
ed skip to not count as a failure, Arne had this comment:</div><div><br></d=
iv><div>&quot;Also I want skip to count a failure since a UI might have som=
e knowledge</div>that certain remotes cannot work and skipping therefore sh=
ould also<br>count as &quot;have tried this=C2=A0<span class=3D"gmail-il">r=
emote</span>&quot;&quot;</div><div class=3D"gmail_quote"><br></div><div cla=
ss=3D"gmail_quote">But that was when SKIP always advanced by 1.</div><div c=
lass=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Selva</div><div c=
lass=3D"gmail_quote"><br></div></div>

--00000000000042a1dd05f0d27a50--

