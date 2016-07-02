MIME-Version: 1.0
In-Reply-To: <cb9a91ab-452e-cf22-9152-a659979f032e@...1227...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<ab01dda4-e7fe-2c9b-c41f-26c7f8f92cd5@...1227...>
	<94cf2582-6f60-4b3f-0675-c362f2d91238@...1227...>
	<CAKuzo_iVWZVxUm9x_FHVaP9bWUVdzNjb+P-sK9OTx1H7UutvWA@...278...>
	<cb9a91ab-452e-cf22-9152-a659979f032e@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Jul 2016 19:50:38 -0400
Message-ID: <CAKuzo_hWbhhTMMTeEuQp8G189m=CVMcVSq9MLtzF43QCZPTmmA@...278...>
Content-Type: multipart/alternative; boundary=001a1148a342518a960536afc62a
Subject: Re: [Openvpn-devel] [PATCH] Exponentially backoff on repeated
	connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148a342518a960536afc62a
Content-Type: text/plain; charset=UTF-8

On Sat, Jul 2, 2016 at 6:38 PM, Arne Schwabe <arne@...1227...> wrote:

> >     connect-retry 5 1800, which would mean "scale back up to 1800s" and
> >     maybe default that option to connect-retry 5 300. That also allows
> >     specifying larger connect-retry values without backoff. E.g.
> >     connect-retry 60 60
> >
> >
> > Good idea.
> >
> > Agreed, triggering SIGHUP is not ideal. The only reason for it was to
> > reset the counters so that the backoff time doesn't get stuck at the
> > highest value for ever. If we reduce the max backoff interval that's
> > less of a concern.
> >
> > One motivation for this patch is to avoid logs filling up. For a client
> > stuck in a restart loop with verb=3 and 5 minutes max pause, the logs
> > grow by about 1 M per  day --  may be not too bad.
> >
> > Selva
>
> Do you want to propose a new patch or should I do it. I would propose
> still a exponential backoff but starting a 2s. so we get 2s 4s 8s ... or
> as default conect-retry 2 256. It would then just stay at the 256s
> interval until a sucessful connection is established. That simplifies
> the logic and gives predictable (from a user perspective) results.
>
> Iirc the logic of connect-retry was changed by me in master so changing
> the logic again should not be a problem



Just sent off v2 before checking for new mails... If you want to change the
default wait time to 2s, it can be easily done in an independent patch. Was
there a reason fro changing it from 2s in 2.3 to the current 5s in the
first place?

In any case my v2 would use 5, 5, 5, 5, 5, 10, 20,... ,160 and then jump to
300 instead of 320 and stay there which is pretty ok in my opinion. As the
user can now specify any combination of the base wait interval and the max
value, the last interval before capping will have an odd value in general
-- we can avoid it for the default values but it will only stay so until
someone changes the default again one day.. In case it matters, the
intervals are still predictable although it doesn't have to be in a true
backoff logic.

Selva

--001a1148a342518a960536afc62a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jul 2, 2016 at 6:38 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt;=C2=A0 =C2=
=A0 =C2=A0connect-retry 5 1800, which would mean &quot;scale back up to 180=
0s&quot; and<br>
&gt;=C2=A0 =C2=A0 =C2=A0maybe default that option to connect-retry 5 300. T=
hat also allows<br>
&gt;=C2=A0 =C2=A0 =C2=A0specifying larger connect-retry values without back=
off. E.g.<br>
&gt;=C2=A0 =C2=A0 =C2=A0connect-retry 60 60<br>
&gt;<br>
&gt;<br>
&gt; Good idea.<br>
&gt;<br>
&gt; Agreed, triggering SIGHUP is not ideal. The only reason for it was to<=
br>
&gt; reset the counters so that the backoff time doesn&#39;t get stuck at t=
he<br>
&gt; highest value for ever. If we reduce the max backoff interval that&#39=
;s<br>
&gt; less of a concern.<br>
&gt;<br>
&gt; One motivation for this patch is to avoid logs filling up. For a clien=
t<br>
&gt; stuck in a restart loop with verb=3D3 and 5 minutes max pause, the log=
s<br>
&gt; grow by about 1 M per=C2=A0 day --=C2=A0 may be not too bad.<br>
&gt;<br>
&gt; Selva<br>
<br>
</span>Do you want to propose a new patch or should I do it. I would propos=
e<br>
still a exponential backoff but starting a 2s. so we get 2s 4s 8s ... or<br>
as default conect-retry 2 256. It would then just stay at the 256s<br>
interval until a sucessful connection is established. That simplifies<br>
the logic and gives predictable (from a user perspective) results.<br>
<br>
Iirc the logic of connect-retry was changed by me in master so changing<br>
the logic again should not be a problem</blockquote></div><br><br></div><di=
v class=3D"gmail_extra">Just sent off v2 before checking for new mails... I=
f you want to change the default wait time to 2s, it can be easily done in =
an independent patch. Was there a reason fro changing it from 2s in 2.3 to =
the current 5s in the first place?<br><br></div><div class=3D"gmail_extra">=
In any case my v2 would use 5, 5, 5, 5, 5, 10, 20,... ,160 and then jump to=
 300 instead of 320 and stay there which is pretty ok in my opinion. As the=
 user can now specify any combination of the base wait interval and the max=
 value, the last interval before capping will have an odd value in general =
-- we can avoid it for the default values but it will only stay so until so=
meone changes the default again one day.. In case it matters, the intervals=
 are still predictable although it doesn&#39;t have to be in a true backoff=
 logic.<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a1148a342518a960536afc62a--

