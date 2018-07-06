MIME-Version: 1.0
In-Reply-To: <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
References: <OpenVPN/openvpn-gui/issues/9@...1714...>
 <OpenVPN/openvpn-gui/issues/9/403117394@...1714...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 6 Jul 2018 15:24:11 -0400
Message-ID: <CAKuzo_jDCHm=VLc2wuKYJaf48Duy_4dHnbvHx4StVV6PjDausw@...278...>
Content-Type: multipart/alternative; boundary="00000000000005a4820570599d05"
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] UI showing green
 connected status despite not beeing able to create a route (#9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN/openvpn-gui <reply+003cc04f98905c5e675d15f3068c3450eb0294652810b25392cf0000000117577b8f92a169ce076aec9b@...1858...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000005a4820570599d05
Content-Type: text/plain; charset="UTF-8"

Hi,

Copying the devel list as a reminder that "we" have been asking for this
change for a long time :)

On Fri, Jul 6, 2018 at 2:48 PM, Gert Doering <notifications@...1714...>
wrote:

> Hi,
>
> On Fri, Jul 06, 2018 at 08:25:02AM -0700, Selva Nair wrote:
> > Can we do something about this in openvpn core, so that the GUI can be
> report route errors?

Currently when we get CONNECTED,SUCCESS we turn the icon green. If we get

CONENCTED,ERROR we keep it amber and the state as "connecting.." even if

the initialization sequence completes.
> >
> > So route errors can still be treated as non-fatal but we want to get
> CONNECTED,ERROR in such cases.
>
> I still wonder why IPv4 route addition failures are considered
> non-fatal...
>

As failure in test_routes is considered an error (waiting for TAP to come
up..,
though not fatal) and leads to CONNECTED,ERROR, I guess that
CONNECTED,SUCCESS would imply the TUN/TAP is up and has got its
on-link route to the vpn subnet.


>
> But this aside ("it has always been that way", before I got involved),
> I can have look into how this signalling is done.


To make all route errors propagate to initilaization_sequence_completed()
one needs to return errors back up from a deep call chain:

check_add_routes_dowork -> check_add_routes_action -> do_route->
add_routes->etc.. Each of those calls returns void right now..

Selva

--00000000000005a4820570599d05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Copying the devel list as a reminder that &quot=
;we&quot; have been asking for this change for a long time :)<br><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jul 6, 2018 at 2:48=
 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:notifications@...493...=
1714..." target=3D"_blank">notifications@...1714...</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Fri, Jul 06, 2018 at 08:25:02AM -0700, Selva Nair wrote:<br>
&gt; Can we do something about this in openvpn core, so that the GUI can be=
 report route errors?=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Currently when we get CONNECTED,SUCCESS we turn the icon gre=
en. If we get=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">CONENCTED,ERROR we keep it amber and the state as &quot;connecting..=
&quot; even if=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">the initialization sequence completes.<br>
&gt; <br>
&gt; So route errors can still be treated as non-fatal but we want to get C=
ONNECTED,ERROR in such cases.<br>
<br>
I still wonder why IPv4 route addition failures are considered <br>
non-fatal...<br></blockquote><div><br></div><div>As failure in test_routes =
is considered an error (waiting for TAP to come up.., <br>though not fatal)=
 and leads to CONNECTED,ERROR, I guess that<br>CONNECTED,SUCCESS would impl=
y the TUN/TAP is up and has got its<br>on-link route to the vpn subnet.<br>=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
But this aside (&quot;it has always been that way&quot;, before I got invol=
ved),<br>
I can have look into how this signalling is done.</blockquote><div><br></di=
v><div>To make all route errors propagate to initilaization_sequence_comple=
<wbr>ted()<br></div><div>one needs to return errors back up from a deep cal=
l chain:<br></div><div><br>check_add_routes_dowork -&gt; check_add_routes_a=
ction -&gt; do_route-&gt;<br></div><div>add_routes-&gt;etc.. Each of those =
calls returns void right now..<br><br></div><div>Selva<br></div></div></div=
></div>

--00000000000005a4820570599d05--

