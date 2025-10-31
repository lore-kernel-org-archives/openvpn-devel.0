MIME-Version: 1.0
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
 <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
 <CAKuzo_gpF7Tzx85O023M-sMqA7VJ0RZYvMnmEPDPccK3+gNfBQ@...278...>
 <aQOqhNumTK_4xu_9@...1296...>
 <CAGyAFMVbQHx1RLVnPA8Tjdu5sLeYWnbwv-0Uos+aWA7=oi1Wvg@...278...>
 <CAKuzo_iCGXKUqxyjX6jXkmoDQSQO8ES=UmNbq8EgHpLur+X9pA@...278...>
In-Reply-To: <CAKuzo_iCGXKUqxyjX6jXkmoDQSQO8ES=UmNbq8EgHpLur+X9pA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 31 Oct 2025 11:23:08 -0400
Message-ID: <CAKuzo_jGWL3oTrjD8NTHueVdwBo6XMaXs0cuqSABiFMYF1c6yw@...278...>
Content-Type: multipart/alternative; boundary="0000000000006a61f6064275f2d1"
Subject: [Openvpn-devel] Fwd: [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000006a61f6064275f2d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: the list

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Thu, Oct 30, 2025 at 6:06=E2=80=AFPM
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
validate openvpn-gui process path
To: Lev Stipakov <lstipakov@...277...>


On Thu, Oct 30, 2025, 17:16 Lev Stipakov <lstipakov@...277...> wrote:

> Indeed, this is to allow only programs under openvpn/bin talk to
> interactive service.
>
> Are there any valid use cases where any other processes are supposed
> to talk to the service?


I can think of a few:
- use a powershell script to start openvpn for testing or otherwise
- run openvpn from task scheduler
- use a third party GUI with the service (like eduVPN)

In fact we already use it to start openvpn through the automatic service:
though that will continue to work with this patch.

Anyway, iircc, it was a deliberate decision to leave interactive service as
a generic way for running openvpn without admin access, not just as a
helper for OpenVPN-GUI.  With this change, anyone wanting to write a new UI
leveraging the service will have to fork it, or install their program under
OpenVPN\bin.

In any case what exactly is achieved by locking down the service this way?

It's necessary for the service to start a valid openvpn.exe and we do check
that. It's also necessary for the GUI to be sure that it's talking to a
legitimate openvpn.exe -- we did enforce that the other day. But I fail to
see a strong reason to restrict service clients in this manner.

What am I missing?

Selva

--0000000000006a61f6064275f2d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Cc: the list=C2=A0<br><br><div><div class=3D"gmail_quo=
te gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">---------- =
Forwarded message ---------<br>From: <strong class=3D"gmail_sendername" dir=
=3D"auto">Selva Nair</strong> <span dir=3D"auto">&lt;<a href=3D"mailto:selv=
a.nair@...277...">selva.nair@...277...</a>&gt;</span><br>Date: Thu, Oct 30,=
 2025 at 6:06=E2=80=AFPM<br>Subject: Re: [Openvpn-devel] [M] Change in open=
vpn[master]: openvpnserv: validate openvpn-gui process path<br>To: Lev Stip=
akov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;=
<br></div><br><br><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div d=
ir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Oct 30, 2025, 17:16 Lev Stipakov &lt;<a href=3D"mailto:lstip=
akov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Indeed, this is to all=
ow only programs under openvpn/bin talk to<br>
interactive service.<br>
<br>
Are there any valid use cases where any other processes are supposed<br>
to talk to the service?</blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">I can think of a few:=C2=A0</div><div dir=3D"auto">- use=
 a powershell script to start openvpn for testing or otherwise=C2=A0</div><=
div dir=3D"auto">- run openvpn from task scheduler</div><div>- use a third =
party GUI with the service (like eduVPN)<br><br></div><div dir=3D"auto">In =
fact we already use it to start openvpn through the automatic service: thou=
gh that will continue to work with this patch.</div><div dir=3D"auto"><div>=
<br></div></div><div dir=3D"auto">Anyway, iircc, it was a deliberate decisi=
on to leave interactive service as a generic way for running openvpn withou=
t admin access, not just as a helper=C2=A0for OpenVPN-GUI.=C2=A0 With this =
change, anyone wanting to write a new UI leveraging the service will have t=
o fork it, or install their program under OpenVPN\bin.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">In any case what exactly is achieved by lock=
ing down the service this way?</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">It&#39;s necessary for the service to start a valid openvpn.exe and =
we do check that. It&#39;s also necessary for the GUI to be sure that it&#3=
9;s talking to a legitimate openvpn.exe -- we did enforce that the other da=
y. But I fail to see a strong reason to restrict service clients in this ma=
nner.<br><br></div><div dir=3D"auto">What am I missing?</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Selva</div><div dir=3D"auto"></div></div>
</div>
</div>
</div>
</div></div></div>

--0000000000006a61f6064275f2d1--

