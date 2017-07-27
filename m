MIME-Version: 1.0
In-Reply-To: <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
 <20170726143612.GJ70062@...1296...>
 <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 27 Jul 2017 13:14:09 -0400
Message-ID: <CAKuzo_iwaB2cAWqd8xFuod5fLnDS8tUrSm-5SoEmz6F83-sMXg@...278...>
Content-Type: multipart/alternative; boundary="001a11408b7693159705554fb27a"
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Karl Mueller <ewiley@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11408b7693159705554fb27a
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Jul 26, 2017 at 1:28 PM, Karl Mueller <ewiley@...277...> wrote:

>
> >
> > I have no idea what the effect would be ("will it stop doing ethernet
> > framing?  no more ARP?"), but it's an interesting idea to try.
> >
>
> Thanks, seems OpenVPN is not the only VPN client that may recognize this
> as an issue and change their iftype. https://quickview.cloudapps.
> cisco.com/quickview/bug/CSCut51057 The Cisco adapter previously used 0x6
> judging by an old Cisco VPN installation I had access to.
>
> Is it possible to have someone create a signed test build of the TAP
> adapter with iftype 131 in the oemvista.inf?
>

This should be easy to test by editing the installed OemVista.inf  (in
C:\Program Files\Tap-Windows\driver\ by default) and running addtap to
create a new adapter with the required iftype. The resulting interface will
most likely not show up in the adapter list in control panel, but should
show in 'openvpn --show-adapters'

But I do not think it will work: with iftype = 0x83 (131) the interface
will not get a physical address (MAC) etc. Further, the tap-windows driver
source sets the iftype as IF_TYPE_ETHERNET_CSMACD (=0x06) which is supposed
to match the value in the inf file.

I have a couple of wifi only win10 machines on which I have not seen this
disconnection behaviour.  Is it because I do not use redirect-gateway? Does
the wifi disconnection happen only when default route is overwritten or is
even "--redirect-gateway def1" not immune to it?

Selva

--001a11408b7693159705554fb27a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Wed, Jul 26, 2017 at 1:28 PM, Karl Mueller <span dir=3D"ltr">&lt;=
<a href=3D"mailto:ewiley@...277..." target=3D"_blank">ewiley@...277...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><spa=
n class=3D"gmail-"><br>
&gt;<br>
&gt; I have no idea what the effect would be (&quot;will it stop doing ethe=
rnet<br>
&gt; framing?=C2=A0 no more ARP?&quot;), but it&#39;s an interesting idea t=
o try.<br>
&gt;<br>
<br>
</span>Thanks, seems OpenVPN is not the only VPN client that may recognize =
this as an issue and change their iftype. <a href=3D"https://quickview.clou=
dapps.cisco.com/quickview/bug/CSCut51057" rel=3D"noreferrer" target=3D"_bla=
nk">https://quickview.cloudapps.<wbr>cisco.com/quickview/bug/<wbr>CSCut5105=
7</a> The Cisco adapter previously used 0x6 judging by an old Cisco VPN ins=
tallation I had access to.<br>
<br>
Is it possible to have someone create a signed test build of the TAP adapte=
r with iftype 131 in the oemvista.inf?<br></blockquote><div><br></div><div>=
This should be easy to test by editing the installed OemVista.inf =C2=A0(in=
 C:\Program Files\Tap-Windows\driver\ by default) and running addtap to cre=
ate a new adapter with the required iftype. The resulting interface will mo=
st likely not show up in the adapter list in control panel, but should show=
 in &#39;openvpn --show-adapters&#39;</div><div><br></div><div>But I do not=
 think it will work: with iftype =3D 0x83 (131) the interface will not get =
a physical address (MAC) etc. Further, the tap-windows driver source sets t=
he iftype as IF_TYPE_ETHERNET_CSMACD (=3D0x06) which is supposed to match t=
he value in the inf file.</div><div><br></div><div>I have a couple of wifi =
only win10 machines on which I have not seen this disconnection behaviour.=
=C2=A0 Is it because I do not use redirect-gateway? Does the wifi disconnec=
tion happen only when default route is overwritten or is even &quot;--redir=
ect-gateway def1&quot; not immune to it?</div><div><br></div><div>Selva</di=
v></div></div></div>

--001a11408b7693159705554fb27a--

