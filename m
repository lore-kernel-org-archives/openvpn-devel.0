MIME-Version: 1.0
In-Reply-To: <20170613193756.GY97029@...1296...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f910a64e-235f-56ad-52b4-aff5dae46acf@...277...>
	<CAKuzo_hUiYVxZSEnB=8=ijO86_VbiZep2mR=1_FCi2pFJYLYmg@...278...>
	<20170613192559.GX97029@...1296...>
	<CAKuzo_gGy8xWAwBCzrxshHBPyzV=iMA=17vxnfSngfZ_b5MUrQ@...278...>
	<20170613193756.GY97029@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Jun 2017 16:15:15 -0400
Message-ID: <CAKuzo_ig=HFtgzxc3qSzFWZ5H4pGi_JKjiL50DRc3GRdFL1Yaw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c03d46831d2780551dd199a"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
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

--94eb2c03d46831d2780551dd199a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 3:37 PM, Gert Doering <gert@...1296...> wrote:

> On Tue, Jun 13, 2017 at 03:33:35PM -0400, Selva Nair wrote:
> > Right :)  But we could probably do better using Set instead of Add while
> > the address is set using the service. I'm not that familiar with ipapi,
> but
> > looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntry
> > may be the right thing.
> >
> > The netsh command used when service is not in use does correctly do a s=
et
> > not add.
>
> Good point.  Wouldn't solve the first problem, but at least a subsequent
> run would "magically fix it", provided the same tap interface is used
> (which, I think, is the case in the great majority of windows
> installations)


Okay, I can say that the issue is indeed the service effectively doing an
"add address" instead
of "set address". Reproduced this without using an admin run:

1. Connect to server 1 using GUI/iservice
2. Kill iservice using taskmanager or taskkill (do not do sc stop
service-name.. as that will do a graceful stop)
3. Start the service again
4. Disconnect  from server 1
At this point "netsh int ipv6 show addr" will show that v6 addres is
retained although the connection is down
4. connect to server 2 using GUI/iservice

Now the adapter will have two ipv6 addresses.

On Tue, Jun 13, 2017 at 3:50 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> I encountered the issue with the Powershell test suite
> (openvpn-windows-test) which ran through a bunch of t_client test
> configs and forcibly killed the OpenVPN process at the end of each test.
> All ping6 tests except the first one would then fail, because adding a
> default IPv6 route failed as one existed already.


Probably the same issue. The real culprit here is force-killing without
impunity. I'll be posting a PR to the GUI that allows sending connect,
disconnect and exit commands to the running GUI, so we could use that in
the script. That said using "set address" in the service will mitigate this
to some extent -- looks easy to do a patch..

Selva

--94eb2c03d46831d2780551dd199a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jun 13, 2017 at 3:37 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><span>On Tue, Jun 13, 2017 at 03:33:35PM -0400=
, Selva Nair wrote:<br>
&gt; Right :)=C2=A0 But we could probably do better using Set instead of Ad=
d while<br>
&gt; the address is set using the service. I&#39;m not that familiar with i=
papi, but<br>
&gt; looks like SetUnicastIpAddressEnrty instead of AddUnicastIpAddressEntr=
y<br>
&gt; may be the right thing.<br>
&gt;<br>
&gt; The netsh command used when service is not in use does correctly do a =
set<br>
&gt; not add.<br>
<br>
</span>Good point.=C2=A0 Wouldn&#39;t solve the first problem, but at least=
 a subsequent<br>
run would &quot;magically fix it&quot;, provided the same tap interface is =
used<br>
(which, I think, is the case in the great majority of windows installations=
)</blockquote></div><br>Okay, I can say that the issue is indeed the servic=
e effectively doing an &quot;add address&quot; instead</div><div class=3D"g=
mail_extra">of &quot;set address&quot;. Reproduced this without using an ad=
min run:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a">1. Connect to server 1 using GUI/iservice</div><div class=3D"gmail_extra=
">2. Kill iservice using taskmanager or taskkill (do not do sc stop service=
-name.. as that will do a graceful stop)</div><div class=3D"gmail_extra">3.=
 Start the service again</div><div class=3D"gmail_extra">4. Disconnect =C2=
=A0from server 1</div><div class=3D"gmail_extra">At this point &quot;netsh =
int ipv6 show addr&quot; will show that v6 addres is retained although the =
connection is down</div><div class=3D"gmail_extra">4. connect to server 2 u=
sing GUI/iservice</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Now the adapter will have two ipv6 addresses.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_e=
xtra">On Tue, Jun 13, 2017 at 3:50 PM, Samuli Sepp=C3=A4nen &lt;<a href=3D"=
mailto:samuli@...515...">samuli@...515...</a>&gt; wrote:</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex">I encountered the issue with the Powershell test suite<br>(openvpn-wind=
ows-test) which ran through a bunch of t_client test<br>configs and forcibl=
y killed the OpenVPN process at the end of each test.<br>All ping6 tests ex=
cept the first one would then fail, because adding a<br>default IPv6 route =
failed as one existed already.</blockquote></div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Probably the same issue. The real cul=
prit here is force-killing without impunity. I&#39;ll be posting a PR to th=
e GUI that allows sending connect, disconnect and exit commands to the runn=
ing GUI, so we could use that in the script. That said using &quot;set addr=
ess&quot; in the service will mitigate this to some extent -- looks easy to=
 do a patch..</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">Selva</div></div>

--94eb2c03d46831d2780551dd199a--

