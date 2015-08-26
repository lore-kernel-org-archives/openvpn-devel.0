MIME-Version: 1.0
In-Reply-To: <55DD7A68.5060603@...1227...>
References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
	<55DD7A68.5060603@...1227...>
Date: Wed, 26 Aug 2015 09:48:11 -0300
Message-ID: <CAAWBBYMf1tEa5Q5DaAnB6-sNv2ZiU-ti1m_65UORx-Y0ODAsLw@...278...>
From: Rafael Gava <gava100@...277...>
Content-Type: multipart/alternative; boundary=089e0122fa0e69e700051e364390
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
	Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--089e0122fa0e69e700051e364390
Content-Type: text/plain; charset=UTF-8

Hi Arne, thanks for the prompt feedback.

please see comments in-line:

Thanks in advance,

Rafael

On Wed, Aug 26, 2015 at 5:35 AM, Arne Schwabe <arne@...1227...> wrote:

>
>
> Am 26.08.15 um 03:43 schrieb Rafael Gava:
>
> Hi,
>
> this is my first submission to the list and I hope that I'm doing in the
> right way. :-)
>
> Yes submitting patches to the list is the preferred way. I haven't looked
> in the patch yet. I am first trying to understand the goal of the patches.
>
>
> Well, the features added to Network Address Translator are:
>
> 1) Allow the user to use the string "localhost" on the client-nat network
> configuration in a way that is not necessary to inform the IP address
> beforehand. Openvpn will set the dynamic received IP from DHCP.
> Example:
>
> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
> 'localhost' string with the DHCP address received from openvpn server.
>
>
> I am not sure what you trying to achieve here? Forward all packets
> intended for this host to another?
>

RafaelGava: yes, exactly!!! Today we have hundreds of boxes on the field,
including PCs (Windows) and also embedded devices, all running openvpn with
NAT in a way that these boxes work as a kind of router for another bigger
equipments. So, the reason for the NAT is that we can establish another
virtual network on top of the vpn one and then reach these bigger
equipments without changing its local network infrastructure.

Let me give an example. Suppose that we have 2 equippments and one openvpn
box on the same LAN. The configuration that we are setting on the openvpn
client is as showed below:

client-nat snat localhost 255.255.255.255 172.20.1.15               # vpn
box. Note that with the localhost string, we don't need to worry which IP
it will get from openvpn server.
client-nat snat 10.10.10.132 255.255.255.255 172.20.1.16         #
Equipment 1
client-nat snat 10.10.10.134 255.255.255.255 172.20.1.17         #
Equipment 2

So, with this configuration it's possible to reach these 2 equipments
through the 172.20.1 network. In general, a subnet is set for each openvpn
box.


> 2) Allow the user to enable the FTP NAT support through the
> --enable-nat-ftp-support option.
> This is useful for systems that don't have conntrack-tools support, for
> example on Windows systems. On windows this feature is enabled by default.
>
> enable-nat-ftp-support (yes | no)
>
> Okay yes. Active FTP is broken by our simple nat implementation. But I
> think FTP, let alone active FTP is dead. I am not sure if we should support
> this in our simple NAT implementation.
>


RafaelGava: I agree with you but unfortunately there are a huge legacy of
proprietary equipments on the field that still use Active FTP and we have
no control over them.

So, based on these items and difficulties that the patch was written.




>
>
> Arne
>

--089e0122fa0e69e700051e364390
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne, thanks for the prompt feedback.<div><br></div><di=
v>please see comments in-line:</div><div><br></div><div>Thanks in advance,<=
/div><div><br></div><div>Rafael<br><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Wed, Aug 26, 2015 at 5:35 AM, Arne Schwabe <span dir=
=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1386...=
227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    <br>
    <div>Am 26.08.15 um 03:43 schrieb Rafael
      Gava:<br>
    </div><span class=3D"">
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>Hi,=C2=A0</div>
        <div><br>
        </div>
        <div>this is my first submission to the list and I hope that I&#39;m
          doing in the right way. :-)</div>
        <div><br>
        </div>
      </div>
    </blockquote></span>
    Yes submitting patches to the list is the preferred way. I haven&#39;t
    looked in the patch yet. I am first trying to understand the goal of
    the patches.<span class=3D""><br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>Well, the features added to Network Address Translator are:</d=
iv>
        <div><br>
        </div>
        <div>1) Allow the user to use the string &quot;localhost&quot; on t=
he
          client-nat network configuration in a way that is not
          necessary to inform the IP address beforehand. Openvpn will
          set the dynamic received IP from DHCP.=C2=A0</div>
        <div>Example:<br>
        </div>
        <div><br>
        </div>
        <div><span style=3D"white-space:pre-wrap">	</span>client-nat
          snat localhost 255.255.255.255 172.20.1.15 # replaces the
          &#39;localhost&#39; string with the DHCP address received from op=
envpn
          server.</div>
      </div>
    </blockquote>
    <br></span>
    I am not sure what you trying to achieve here? Forward all packets
    intended for this host to another?</div></blockquote><div><br></div><di=
v>RafaelGava: yes, exactly!!! Today we have hundreds of boxes on the field,=
 including PCs (Windows) and also embedded devices, all running openvpn wit=
h NAT in a way that these boxes work as a kind of router for another bigger=
 equipments. So, the reason for the NAT is that we can establish another vi=
rtual network on top of the vpn one and then reach these bigger equipments =
without changing its local network infrastructure.</div><div><br></div><div=
>Let me give an example. Suppose that we have 2 equippments and one openvpn=
 box on the same LAN. The configuration that we are setting on the openvpn =
client is as showed below:</div><div><br></div><div><blockquote type=3D"cit=
e"><div dir=3D"ltr">client-nat snat localhost 255.255.255.255 172.20.1.15 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # vpn box. Note that with =
the localhost string, we don&#39;t need to worry which IP it will get from =
openvpn server.</div><div>client-nat snat 10.10.10.132 255.255.255.255 172.=
20.1.16 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Equipment 1</div><div>client-nat snat=
 10.10.10.134 255.255.255.255 172.20.1.17 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Equ=
ipment 2</div><div><br></div></blockquote></div><div>So, with this configur=
ation it&#39;s possible to reach these 2 equipments through the 172.20.1 ne=
twork. In general, a subnet is set for each openvpn box.</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid=
;padding-left:1ex"><div bgcolor=3D"#FFFFFF" text=3D"#000000"><span class=3D=
""><br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>2) Allow the user to enable the FTP NAT support through the
          --enable-nat-ftp-support option.=C2=A0</div>
        <div>This is useful for systems that don&#39;t have conntrack-tools
          support, for example on Windows systems. On windows this
          feature is enabled by default.</div>
        <div><br>
        </div>
        <div><span style=3D"white-space:pre-wrap">	</span>enable-nat-ftp-su=
pport
          (yes | no)</div>
        <br>
      </div>
    </blockquote></span>
    Okay yes. Active FTP is broken by our simple nat implementation. But
    I think FTP, let alone active FTP is dead. I am not sure if we
    should support this in our simple NAT implementation.</div></blockquote=
><div><br></div><div><br></div><div>RafaelGava: I agree with you but unfort=
unately there are a huge legacy of proprietary equipments on the field that=
 still use Active FTP and we have no control over them.</div><div><br></div=
><div>So, based on these items and difficulties that the patch was written.=
=C2=A0</div><div><br></div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div bgcolor=3D"#FFFFFF" text=3D"#000000"><span class=3D""><font color=3D"=
#888888"><br>
    <br>
    Arne<br>
  </font></span></div>

</blockquote></div><br></div></div></div>

--089e0122fa0e69e700051e364390--

