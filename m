MIME-Version: 1.0
In-Reply-To: <20180412082603.GT69387@...1296...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 12 Apr 2018 10:27:08 -0400
Message-ID: <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
Content-Type: multipart/alternative; boundary="0000000000003308190569a78e6c"
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver (was: Summary of
 the community meeting) 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Eric Thorpe <eric@...1918...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003308190569a78e6c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Apr 12, 2018 at 4:26 AM, Gert Doering <gert@...1296...> wrote:

> Hi Eric,
>
> On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
> > One of the Viscosity developers here. The TAP driver used by Viscosity
> > is based on the OpenVPN TAP-Windows driver. We're surprised to hear of
> > any performance differences, as the changes we've made are very minimal.
> >
> > Besides a name and version number change, the only other modification is
> > a change to the reported network adapter speed, which has Windows report
> > the driver as 1000 Mbit instead of 100 Mbit.
> >
> > This change was made not because of any actual performance gains, but
> > because of user reports that certain firewall or AV software tries to
> > QoS the adapter based on its reported adapter speed, which is of course
> > a problem if the VPN connection is capable of more than 100 Mbit.
> >
> > Please find a patch file of the changes attached.
>
> I think it would make sense for us to merge that patch - for two reasons,
> one is "the change could indeed help performance in high-bandwidth
> situtions", and the more important one is "another patch to tap-windows6
> is forthcoming, and that way we can keep the version numbers aligned
> so people can know what is inside".
>

One can get > 100 Mbits/s from the stock TAP driver, so that parameter does
not appear to affect the actual "speed". With 100Mbit setting, Windows will
classify the device as fast ethernet for heuristics like choosing the
default metric. But now we do have code for setting a custom metric isn't
it? Or is it only used when --block-outside-dns is in use?

Or am I mistaken -- does this setting really affect the max throughput?

Selva

--0000000000003308190569a78e6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Apr 12, 2018 at 4:26 AM, Gert Doering <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Eric,<br>
<br>
On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:<br>
&gt; One of the Viscosity developers here. The TAP driver used by Viscosity=
<br>
&gt; is based on the OpenVPN TAP-Windows driver. We&#39;re surprised to hea=
r of<br>
&gt; any performance differences, as the changes we&#39;ve made are very mi=
nimal.<br>
&gt;<br>
&gt; Besides a name and version number change, the only other modification =
is<br>
&gt; a change to the reported network adapter speed, which has Windows repo=
rt<br>
&gt; the driver as 1000 Mbit instead of 100 Mbit.<br>
&gt;<br>
&gt; This change was made not because of any actual performance gains, but<=
br>
&gt; because of user reports that certain firewall or AV software tries to<=
br>
&gt; QoS the adapter based on its reported adapter speed, which is of cours=
e<br>
&gt; a problem if the VPN connection is capable of more than 100 Mbit.<br>
&gt;<br>
&gt; Please find a patch file of the changes attached.<br>
<br>
I think it would make sense for us to merge that patch - for two reasons,<b=
r>
one is &quot;the change could indeed help performance in high-bandwidth<br>
situtions&quot;, and the more important one is &quot;another patch to tap-w=
indows6<br>
is forthcoming, and that way we can keep the version numbers aligned<br>
so people can know what is inside&quot;.<br></blockquote><div><br></div><di=
v>One can get &gt; 100 Mbits/s from the stock TAP driver, so that parameter=
 does not appear to affect the actual &quot;speed&quot;. With 100Mbit setti=
ng, Windows will classify the device as fast ethernet for heuristics like c=
hoosing the default metric. But now we do have code for setting a custom me=
tric isn&#39;t it? Or is it only used when --block-outside-dns is in use?</=
div><div><br></div><div>Or am I mistaken -- does this setting really affect=
 the max throughput?</div><div><br></div><div>Selva</div></div></div></div>

--0000000000003308190569a78e6c--

