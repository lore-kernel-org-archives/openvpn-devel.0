MIME-Version: 1.0
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
 <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
 <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
 <20181017120745.GB962@...1296...>
In-Reply-To: <20181017120745.GB962@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Oct 2018 10:08:35 -0400
Message-ID: <CAKuzo_gNwMbQqm8YTMXHgJX3n1+FSwGjts8gVS_+azS1mfUSzQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000fafbac05786d3593"
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix
 length when configuring address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000fafbac05786d3593
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Oct 17, 2018 at 8:07 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Oct 16, 2018 at 05:48:29PM -0400, Selva Nair wrote:
> > Going through patchworks noticed this.
> >
> > Thankfully this never got committed so here goes a retraction.
> >
> > On Sun, Jan 21, 2018 at 1:45 PM Selva Nair <selva.nair@...277...> wrote:
> >
> > > Hi,
> > >
> > > I'm on a reviewing spree (doing my penance), so here goes..
> > >
> > > Thanks for the patch
> > >
> > > On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger <eyal.birger@...277...>
> wrote:
> > > > Address prefix length defaults to /64 on Windows. This change allows
> > > using
> > > > Windows clients in setups that use a different prefix length.
>
> I had this on "I need to do more testing with this", which is why it
> never proceeded - there might be unintended side effects, so I wanted
> to do more detailed testing with "netsh" and with "iservice" backends,
> and different prefix lengths etc.
>
> Also, I had the suspicion that if we actually set a prefix length, it
> will lead to local ND traffic which the tap driver won't answer (it
> will only answer fe80::8) thus causing a "black hole route" for the
> tap subnet...
>

Aha, that explains why it lingered in that state for long :)

However, we do currently set the prefix-length while using the
service (that->netbits_ipv6 is passed as prefix_len to the ip helper API),
don't we?

Selva

--000000000000fafbac05786d3593
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr">On Wed, Oct 17, 2018 at 8:07 AM Gert Doering &lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Oct 16, 2018 at 05:48:29PM -0400, Selva Nair wrote:<br>
&gt; Going through patchworks noticed this.<br>
&gt; <br>
&gt; Thankfully this never got committed so here goes a retraction.<br>
&gt; <br>
&gt; On Sun, Jan 21, 2018 at 1:45 PM Selva Nair &lt;<a href=3D"mailto:selva=
.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m on a reviewing spree (doing my penance), so here goes..<b=
r>
&gt; &gt;<br>
&gt; &gt; Thanks for the patch<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger &lt;<a href=3D"mailto=
:eyal.birger@...277..." target=3D"_blank">eyal.birger@...277...</a>&gt; wro=
te:<br>
&gt; &gt; &gt; Address prefix length defaults to /64 on Windows. This chang=
e allows<br>
&gt; &gt; using<br>
&gt; &gt; &gt; Windows clients in setups that use a different prefix length=
.<br>
<br>
I had this on &quot;I need to do more testing with this&quot;, which is why=
 it<br>
never proceeded - there might be unintended side effects, so I wanted<br>
to do more detailed testing with &quot;netsh&quot; and with &quot;iservice&=
quot; backends,<br>
and different prefix lengths etc.<br>
<br>
Also, I had the suspicion that if we actually set a prefix length, it<br>
will lead to local ND traffic which the tap driver won&#39;t answer (it<br>
will only answer fe80::8) thus causing a &quot;black hole route&quot; for t=
he<br>
tap subnet...<br></blockquote><div><br></div><div>Aha, that explains why it=
 lingered in that state for long :)<br><br></div><div>However, we do curren=
tly set the prefix-length while using the<br></div><div>service (that-&gt;n=
etbits_ipv6 is passed as prefix_len to the ip helper API),<br>don&#39;t we?=
 <br><br></div><div>Selva<br></div></div></div></div></div>

--000000000000fafbac05786d3593--

