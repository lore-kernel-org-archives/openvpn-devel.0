MIME-Version: 1.0
References: <f40e6882-da83-ae0a-2230-ab1cbbe3d0c1@...2181...>
 <50df7743-5541-40dd-c2ea-f81e3ad9c29c@...1227...>
 <3ba00502-4919-b866-451f-0ae215e6a170@...2181...>
 <5a4c873d-5bc0-2852-0e9f-612031796919@...1227...>
 <24f1514f-c203-aebe-9e88-131cb7a6f594@...2181...>
 <835f099d-56ad-ee13-9c2b-431514402a71@...1227...>
 <e7bc92b4-4d73-3eaa-6ea6-da2f1dfc6de3@...2181...>
 <aad4f854-df53-dff3-28fc-6d3f81c679e0@...1227...>
 <7c805a15-5529-d86e-af7d-30ab5b693c8b@...2181...>
In-Reply-To: <7c805a15-5529-d86e-af7d-30ab5b693c8b@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 16 Jun 2021 14:06:47 -0400
Message-ID: <CAKuzo_hYGYrgYLE=HO56mTE-9b7LG3mHo1je5c8Z0FPo8epmEw@...278...>
Content-Type: multipart/alternative; boundary="000000000000784c0f05c4e5f77e"
Subject: Re: [Openvpn-devel] TLS Error: local/remote TLS keys are out of sync
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000784c0f05c4e5f77e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jun 14, 2021 at 10:30 AM Antonio Quartulli <a@...2181...> wrote:

> On 14/06/2021 16:26, Arne Schwabe wrote:
> > Put on the agenda for community meeting to decide if we want to
> > deprecate hand-window compeletely and reneg-sec under < 120?
> >
>
> Good idea! will do!
>

I used to have some remote clients on low bandwidth high latency (and often
erratic) satellite link for which the initial handshake was pretty taxing
on the network. Like 15 to 30 seconds to complete the handshake on good
days. But the tunnel stayed up most of the time once connected, even
through desert storms[1] that adversely affect the up link.  Renegotiation
seldom failed probably because tran-window is long by default. Since then I
generally set --hand-window to 120, though not sure such a large value was
ever really required or helped.

Saying this only to point out there may be some situations where an option
to increase the handshake timeout is useful. For reneg-sec I don't think
there is any strong reason to allow arbitrarily low values. Even 120 sec is
useful only for testing purposes.

Selva

[1] The client was in a remote mining site with harsh weather.

--000000000000784c0f05c4e5f77e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Jun 14, 2021 at 10:30 AM Antonio Quartulli=
 &lt;a@...2181...&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 14/06/2021 16:26, Arne Schwabe wrote:<br>
&gt; Put on the agenda for community meeting to decide if we want to<br>
&gt; deprecate hand-window compeletely and reneg-sec under &lt; 120?<br>
&gt; <br>
<br>
Good idea! will do!<br></blockquote><div><br></div><div>I used to have some=
 remote clients on low bandwidth high latency (and often erratic) satellite=
 link for which the initial handshake was pretty taxing on the network. Lik=
e 15 to 30 seconds to complete the handshake on good days. But the tunnel s=
tayed up most of the time once connected, even through desert storms[1] tha=
t adversely affect the up link.=C2=A0 Renegotiation seldom failed probably =
because tran-window is long by default. Since then I generally set --hand-w=
indow to 120, though not sure such a large value was ever really required o=
r helped.</div><div><br></div><div>Saying this only to point out there may =
be some situations where an option to increase the handshake timeout is use=
ful. For reneg-sec I don&#39;t think there is any strong reason to allow ar=
bitrarily low values. Even 120 sec is useful only for testing purposes.</di=
v><div><br></div><div>Selva=C2=A0</div><div><br></div><div>[1] The client w=
as in a remote mining site with harsh weather.</div></div></div>

--000000000000784c0f05c4e5f77e--

