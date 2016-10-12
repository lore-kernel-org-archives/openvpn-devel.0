MIME-Version: 1.0
In-Reply-To: <1184387968.3914907.1476271754068@...2084...>
References: <3572b3e5-8830-3418-87d7-725d611bb04a@...515...>
	<1184387968.3914907.1476271754068@...2084...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 12 Oct 2016 10:12:28 -0400
Message-ID: <CAKuzo_h8c9R_jCHMFVsHV8OF3YpXh2NF2fU1YnN5=xGnMhcvJw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05d03080a894053eab968d
Subject: Re: [Openvpn-devel] [Openvpn-users] Help testing OpenVPN 2.4-alpha1
	preview installers?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jose Alf." <josealf@...1237...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--94eb2c05d03080a894053eab968d
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed, Oct 12, 2016 at 7:29 AM, Jose Alf. <josealf@...1237...> wrote:

> I tested the 64 bit installer on Windows 7 Enterprise using default
> settings. It ran smoothly. I notice that now there are 3 services - OpenVPN
> Interactive Service (appears started automatic)
> - OpenVPN Legacy Service (manual)
> - OpenVPNService (manual)
>
> Any pointers to documentation about this?
>

> I use OpenVPN-MI-GUI. I had to start OpenVPNService to connect to my
> server. Other than that, it worked fine.


To add to what Samuli wrote:

With MI-GUI, all you have to do is just start OpenVPNService (same as
previous previous versions) -- under the hood the service has changed, but
the functionality is the same.

That said, if the reason for using MI-GUI is to avoid running the GUI as
admin, now there is a better way. Do not run OpenVPNService and start
OpenVPN GUI included in the distribution as normal user. It will start
openvpn as normal user assisted by the interactive service (which is
automatically started). The main advantage is that both the GUI and
openvpn.exe will run as normal user minimizing code run as admin.

Also there are a number of improvements in the GUI including ability to
store config files in user profile, menu to import the config file to the
right location, optionally remember passwords,  support for prompting
static challenge, configuration menu for all options (no need to edit the
registry) etc.

Selva

--94eb2c05d03080a894053eab968d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Oct 12, 2016 at 7:29 AM, Jose A=
lf. <span dir=3D"ltr">&lt;<a href=3D"mailto:josealf@...1237..." target=3D"_=
blank">josealf@...1237...</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div di=
r=3D"ltr">I tested the 64 bit installer on Windows 7 Enterprise using defau=
lt settings. It ran smoothly. I notice that now there are 3 services - Open=
VPN Interactive Service (appears started automatic)<br></div><div id=3D"m_-=
3728245094485473427gmail-m_7715264781134700546yui_3_16_0_ym19_1_14762699975=
50_4126" dir=3D"ltr">- OpenVPN Legacy Service (manual)<br></div><div id=3D"=
m_-3728245094485473427gmail-m_7715264781134700546yui_3_16_0_ym19_1_14762699=
97550_4068" dir=3D"ltr">- OpenVPNService (manual)<br></div><div id=3D"m_-37=
28245094485473427gmail-m_7715264781134700546yui_3_16_0_ym19_1_1476269997550=
_4070"><br> </div><div id=3D"m_-3728245094485473427gmail-m_7715264781134700=
546yui_3_16_0_ym19_1_1476269997550_3820"><span id=3D"m_-3728245094485473427=
gmail-m_7715264781134700546yui_3_16_0_ym19_1_1476269997550_4252">Any pointe=
rs to documentation about this?</span></div></blockquote></div><blockquote =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex" class=3D"gmail_qu=
ote"><span id=3D"m_-3728245094485473427gmail-m_7715264781134700546yui_3_16_=
0_ym19_1_1476269997550_4258"><br class=3D"m_-3728245094485473427gmail-Apple=
-interchange-newline"></span><span id=3D"m_-3728245094485473427gmail-m_7715=
264781134700546yui_3_16_0_ym19_1_1476269997550_4258">I use OpenVPN-MI-GUI. =
I had to start=C2=A0</span>OpenVPNService to connect to my server. Other th=
an that, it worked fine.</blockquote><div id=3D"m_-3728245094485473427gmail=
-m_7715264781134700546yui_3_16_0_ym19_1_1476269997550_3821" class=3D"m_-372=
8245094485473427gmail-m_7715264781134700546qtdSeparateBR" style=3D"color:rg=
b(0,0,0);font-family:helveticaneue,&#39;helvetica neue&#39;,helvetica,arial=
,&#39;lucida grande&#39;,sans-serif;font-size:16px"></div><br></div><div cl=
ass=3D"gmail_extra">To add to what Samuli wrote:<br></div><div class=3D"gma=
il_extra"><br></div><div class=3D"gmail_extra">With MI-GUI, all you have to=
 do is just start OpenVPNService (same as previous previous versions) -- un=
der the hood the service has changed, but the functionality is the same.</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">That sai=
d, if the reason for using MI-GUI is to avoid running the GUI as admin, now=
 there is a better way. Do not run OpenVPNService and start OpenVPN GUI inc=
luded in the distribution as normal user. It will start openvpn as normal u=
ser assisted by the interactive service (which is automatically started). T=
he main advantage is that both the GUI and openvpn.exe will run as normal u=
ser minimizing code run as admin.</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">Also there are a number of improvements in the =
GUI including ability to store config files in user profile, menu to import=
 the config file to the right location, optionally remember passwords, =C2=
=A0support for prompting static challenge, configuration menu for all optio=
ns (no need to edit the registry) etc.</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br>=
</div></div>

--94eb2c05d03080a894053eab968d--

