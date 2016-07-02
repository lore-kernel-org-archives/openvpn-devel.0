MIME-Version: 1.0
In-Reply-To: <94cf2582-6f60-4b3f-0675-c362f2d91238@...1227...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<ab01dda4-e7fe-2c9b-c41f-26c7f8f92cd5@...1227...>
	<94cf2582-6f60-4b3f-0675-c362f2d91238@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Jul 2016 12:56:58 -0400
Message-ID: <CAKuzo_iVWZVxUm9x_FHVaP9bWUVdzNjb+P-sK9OTx1H7UutvWA@...278...>
Content-Type: multipart/alternative; boundary=001a114e710ae981610536a9fe0d
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

--001a114e710ae981610536a9fe0d
Content-Type: text/plain; charset=UTF-8

On Sat, Jul 2, 2016 at 11:32 AM, Arne Schwabe <arne@...1227...> wrote:

> > And why sighup? Shouldn't just limiting sec be enought. SIGHUP has many
> > side effects. I don't think we should trigger these for connection time.
> >
> >
> > With default setting this results in a SIGHUP after some hours and also
> > the last intervals with 5120s are too big for default settings. I would
> > aim for something lower like five or ten minutes.
>
> I think a bit about that and I think a good way to specify exponential
> back is something like
>
> connect-retry 5 1800, which would mean "scale back up to 1800s" and
> maybe default that option to connect-retry 5 300. That also allows
> specifying larger connect-retry values without backoff. E.g.
> connect-retry 60 60


Good idea.

Agreed, triggering SIGHUP is not ideal. The only reason for it was to reset
the counters so that the backoff time doesn't get stuck at the highest
value for ever. If we reduce the max backoff interval that's less of a
concern.

One motivation for this patch is to avoid logs filling up. For a client
stuck in a restart loop with verb=3 and 5 minutes max pause, the logs grow
by about 1 M per  day --  may be not too bad.

Selva

--001a114e710ae981610536a9fe0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jul 2, 2016 at 11:32 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>&gt; And why sighup? Shoul=
dn&#39;t just limiting sec be enought. SIGHUP has many<br>
&gt; side effects. I don&#39;t think we should trigger these for connection=
 time.<br>
&gt;<br>
&gt;<br>
&gt; With default setting this results in a SIGHUP after some hours and als=
o<br>
&gt; the last intervals with 5120s are too big for default settings. I woul=
d<br>
&gt; aim for something lower like five or ten minutes.<br>
<br>
</span>I think a bit about that and I think a good way to specify exponenti=
al<br>
back is something like<br>
<br>
connect-retry 5 1800, which would mean &quot;scale back up to 1800s&quot; a=
nd<br>
maybe default that option to connect-retry 5 300. That also allows<br>
specifying larger connect-retry values without backoff. E.g.<br>
connect-retry 60 60</blockquote><div><br></div><div>Good idea. <br><br>Agre=
ed, triggering SIGHUP is not ideal. The only reason for it was to reset the=
 counters so that the backoff time doesn&#39;t get stuck at the highest val=
ue for ever. If we reduce the max backoff interval that&#39;s less of a con=
cern.<br><br>One motivation for this patch is to avoid logs filling up. For=
 a client stuck in a restart loop with verb=3D3 and 5 minutes max pause, th=
e logs grow by about 1 M per=C2=A0 day --=C2=A0 may be not too bad.<br></di=
v><div><br></div><div>Selva<br></div></div></div></div>

--001a114e710ae981610536a9fe0d--

