From: Simon Rozman <simon@...2293...>
Date: Mon, 25 Nov 2019 09:44:19 +0000
Message-ID: <99D61A626FDA8A4B90A270669121BE10C9B08A55@...2294...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
 <CAGyAFMWEc0c_GRiphD+=zikh2BkMckxD4rjZXrmQfmLUejAkgA@...278...>
 <CAKuzo_howdUtX86vj9kTYga=r8Ce0rbnrSiciqfCNtVVVeFwbw@...278...>
 <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
In-Reply-To: <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=2.16.840.1.101.3.4.2.1;
 boundary="----=_NextPart_000_0025_01D5A37D.49D31F30"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0025_01D5A37D.49D31F30
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0026_01D5A37D.49D31F30"

------=_NextPart_001_0026_01D5A37D.49D31F30
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I know. The tap.c code needs an upgrade, not to evaluate all drivers, but j=
ust compatible drivers when creating a new adapter. This speeds things a lo=
t. There's a flag that needs to be changed. Somewhere deep on my TODO lists.

=20

I would suggest against temporary adapters on Windows. This is OK on Linux,=
 but Windows is not Linux. Apart from the time penalty you already discover=
ed, there are more annoying issues with temporary adapters: adapters always=
 get a new GUID on creation, making NLA think it's a new network each time.=
 This will keep resetting the firewall profile assigned to the adapter and =
piling up network IDs in user registry at each connection attempt. Also, ch=
anging bindings on adapters don't persist (vmWare, VirtualBox, Hyper-V bind=
ings comes to my mind)=E2=80=A6

=20

I am testing an intermediate approach to adapter management on Windows, ins=
pired by Microsoft's own way how Windows handle dial-up adapters:

1.	if adapter "My VPN Connection" doesn't exist, create it.
2.	else enable it
3.	use it
4.	disable it

=20

In my observation, this is the most streamlined approach on Windows. It avo=
ids adapter creation burden, while still (re)creates it on demand. Disablin=
g adapter when it is not in use releases the resources, removes the adapter=
 from the network stack, halts the adapter, unloads the driver when the las=
t of the adapters (of the same driver) is disabled=E2=80=A6 Like adapter wa=
s deleted, only its settings persist in registry.

=20

An annoyance here is, the adapters pile up over time. On multi-user compute=
rs, OpenVPN GUI don't have a complete overview which one are stale (no corr=
esponding .ovpn file exist anymore) to clean them. Cleaning requires elevat=
ion=E2=80=A6 An admin user may use Device manager to clean them, uninstalle=
r should clean them. Both are not ideal. On test computers with lots of con=
figuration fuss that might be a problem. On production computers this shoul=
dn't be a big issue. Mind that even Hyper-V doesn't clean up adapters if yo=
u install and uninstall it on Windows.

=20

Maybe we could save the absolute path to .ovpn file in the adapter registry=
 to assign it to a particular profile. Interactive service could periodical=
ly delete orphaned adapters. I'm not worried about .ovpn-less tunnels: user=
s running openvpn.exe specifying all settings in the command line know what=
 they're doing.

=20

Best regards,

Simon

=20

From: Lev Stipakov <lstipakov@...277...>=20
Sent: Monday, November 25, 2019 10:04 AM
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintu=
n device

=20

Hi,

=20

(cc:ed to -devel)

=20

I would vote for B and not the combination.

=20

With wintun there is no backwards compatibility requirements, so we could u=
se a cleaner, consistent and simpler approach (i.e B). Do not create any ad=
apter during installation and dynamically create a temporary adapter at con=
nection time.

=20

My main concern with creating tun adapter on demand is that it is far from =
instant:

=20

$ time ./tapctl.exe create --hwid wintun
{D9F56B7A-3054-4ADC-9457-61030F0B469D}

real    0m2,090s

=20

I don't think we want to add it to connection time.

=20

Creating one persistent adapter per profile (as viscosity does for tapwindo=
ws and wireguard seems to do for wintun)

=20

If I remember right, wireguard doesn't create persistent adapter, instead i=
t adds/removes it on demand.

=20

If --dev-node is specified, we open the named adapter which the user is sup=
posed to have created as we do for tapwindows.

=20

Yes, I plan to add support for --dev-node for wintun.=20

=20

--=20

-Lev


------=_NextPart_001_0026_01D5A37D.49D31F30
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
code
	{mso-style-priority:99;
	font-family:Consolas;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:276911230;
	mso-list-type:hybrid;
	mso-list-template-ids:-992851904 1004569982 69468163 69468165 69468161 694=
68163 69468165 69468161 69468163 69468165;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:781727577;
	mso-list-type:hybrid;
	mso-list-template-ids:165067786 69468175 69468163 69468165 69468161 694681=
63 69468165 69468161 69468163 69468165;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DSL link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal><span lang=
=3DEN-GB style=3D'mso-fareast-language:EN-US'>I know. The tap.c code needs =
an upgrade, not to evaluate all drivers, but just compatible drivers when c=
reating a new adapter. This speeds things a lot. There's a flag that needs =
to be changed. Somewhere deep on my TODO lists.<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'><o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'ms=
o-fareast-language:EN-US'>I would suggest against temporary adapters on Win=
dows. This is OK on Linux, but Windows is not Linux. Apart from the time pe=
nalty you already discovered, there are more annoying issues with temporary=
 adapters: adapters always get a new GUID on creation, making NLA think it'=
s a new network each time. This will keep resetting the firewall profile as=
signed to the adapter and piling up network IDs in user registry at each co=
nnection attempt. Also, changing bindings on adapters don't persist (vmWare=
, VirtualBox, Hyper-V bindings comes to my mind)=E2=80=A6<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:E=
N-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB s=
tyle=3D'mso-fareast-language:EN-US'>I am testing an intermediate approach t=
o adapter management on Windows, inspired by Microsoft's own way how Window=
s handle dial-up adapters:<o:p></o:p></span></p><ol style=3D'margin-top:0cm=
' start=3D1 type=3D1><li class=3DMsoListParagraph style=3D'margin-left:0cm;=
mso-list:l1 level1 lfo2'><span lang=3DEN-GB style=3D'mso-fareast-language:E=
N-US'>if adapter &quot;My VPN Connection&quot; doesn't exist, create it.<o:=
p></o:p></span></li><li class=3DMsoListParagraph style=3D'margin-left:0cm;m=
so-list:l1 level1 lfo2'><span lang=3DEN-GB style=3D'mso-fareast-language:EN=
-US'>else enable it<o:p></o:p></span></li><li class=3DMsoListParagraph styl=
e=3D'margin-left:0cm;mso-list:l1 level1 lfo2'><span lang=3DEN-GB style=3D'm=
so-fareast-language:EN-US'>use it<o:p></o:p></span></li><li class=3DMsoList=
Paragraph style=3D'margin-left:0cm;mso-list:l1 level1 lfo2'><span lang=3DEN=
-GB style=3D'mso-fareast-language:EN-US'>disable it<o:p></o:p></span></li><=
/ol><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language:E=
N-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB s=
tyle=3D'mso-fareast-language:EN-US'>In my observation, this is the most str=
eamlined approach on Windows. It avoids adapter creation burden, while stil=
l (re)creates it on demand. Disabling adapter when it is not in use release=
s the resources, removes the adapter from the network stack, halts the adap=
ter, unloads the driver when the last of the adapters (of the same driver) =
is disabled=E2=80=A6 Like adapter was deleted, only its settings persist in=
 registry.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-GB sty=
le=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-GB style=3D'mso-fareast-language:EN-US'>An annoyanc=
e here is, the adapters pile up over time. On multi-user computers, OpenVPN=
 GUI don't have a complete overview which one are stale (no corresponding .=
ovpn file exist anymore) to clean them. Cleaning requires elevation=E2=80=
=A6 An admin user may use Device manager to clean them, uninstaller should =
clean them. Both are not ideal. On test computers with lots of configuratio=
n fuss that might be a problem. On production computers this shouldn't be a=
 big issue. Mind that even Hyper-V doesn't clean up adapters if you install=
 and uninstall it on Windows.<o:p></o:p></span></p><p class=3DMsoNormal><sp=
an lang=3DEN-GB style=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-GB style=3D'mso-fareast-language=
:EN-US'>Maybe we could save the absolute path to .ovpn file in the adapter =
registry to assign it to a particular profile. Interactive service could pe=
riodically delete orphaned adapters. I'm not worried about .ovpn-less tunne=
ls: users running openvpn.exe specifying all settings in the command line k=
now what they're doing.<o:p></o:p></span></p><p class=3DMsoNormal><span sty=
le=3D'mso-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal>Best regards,<o:p></o:p></p><p class=3DMsoNormal>Simon<o:p></o:p></=
p><p class=3DMsoNormal><span style=3D'mso-fareast-language:EN-US'><o:p>&nbs=
p;</o:p></span></p><div style=3D'border:none;border-left:solid blue 1.5pt;p=
adding:0cm 0cm 0cm 4.0pt'><div><div style=3D'border:none;border-top:solid #=
E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span lang=
=3DEN-US>From:</span></b><span lang=3DEN-US> Lev Stipakov &lt;lstipakov@...493...=
277...&gt; <br><b>Sent:</b> Monday, November 25, 2019 10:04 AM<br><b>To:</b=
> Selva Nair &lt;selva.nair@...277...&gt;<br><b>Cc:</b> openvpn-devel &lt;o=
penvpn-devel@lists.sourceforge.net&gt;<br><b>Subject:</b> Re: [Openvpn-deve=
l] [PATCH v2 3/7] wintun: implement opening wintun device<o:p></o:p></span>=
</p></div></div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div><div><p=
 class=3DMsoNormal>Hi,<o:p></o:p></p></div><div><p class=3DMsoNormal><o:p>&=
nbsp;</o:p></p></div><div><p class=3DMsoNormal>(cc:ed to -devel)<o:p></o:p>=
</p></div><div><p class=3DMsoNormal>&nbsp;<o:p></o:p></p></div><blockquote =
style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.=
0pt;margin-left:4.8pt;margin-right:0cm'><div><div><div><p class=3DMsoNormal=
>I would vote for B and not the combination.<o:p></o:p></p></div><div><p cl=
ass=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>With w=
intun there is no backwards compatibility requirements, so we could use a c=
leaner, consistent and simpler approach (i.e B). Do not create any adapter =
during installation and dynamically create a temporary adapter at connectio=
n time.<o:p></o:p></p></div></div></div></blockquote><div><p class=3DMsoNor=
mal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>My main concern wi=
th creating tun adapter on demand is that it is far from instant:<o:p></o:p=
></p></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p cla=
ss=3DMsoNormal>$ time ./tapctl.exe create --hwid wintun<br>{D9F56B7A-3054-4=
ADC-9457-61030F0B469D}<br><br>real &nbsp; &nbsp;0m2,090s<o:p></o:p></p></di=
v><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoN=
ormal>I don't think we want to add it to connection time.<o:p></o:p></p></d=
iv><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><blockquote style=
=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;m=
argin-left:4.8pt;margin-right:0cm'><div><div><div><p class=3DMsoNormal>Crea=
ting one persistent adapter per profile (as viscosity does for tapwindows a=
nd wireguard seems to do for wintun)<o:p></o:p></p></div></div></div></bloc=
kquote><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=
=3DMsoNormal>If I remember right, wireguard doesn't create persistent adapt=
er, instead it adds/removes it on demand.<o:p></o:p></p></div><div><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p></div><blockquote style=3D'border:none;bo=
rder-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;m=
argin-right:0cm'><div><div><div><p class=3DMsoNormal>If --dev-node is speci=
fied, we open the named adapter which the user is supposed to have created =
as we do for tapwindows.<o:p></o:p></p></div></div></div></blockquote><div>=
<p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p class=3DMsoNormal>Y=
es, I plan to add support for --dev-node for wintun.&nbsp;<o:p></o:p></p></=
div></div><div><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><p class=3DM=
soNormal>-- <o:p></o:p></p><div><p class=3DMsoNormal>-Lev<o:p></o:p></p></d=
iv></div></div></div></body></html>=

------=_NextPart_001_0026_01D5A37D.49D31F30--

------=_NextPart_000_0025_01D5A37D.49D31F30
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwMwJzAlBggrBgEFBQcCARYZaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3BzLzAIBgYEAIswAQIwGAYI
KwYBBQUHAQMEDDAKMAgGBgQAjkYBATAaBgNVHREEEzARgQ9zaW1vbkByb3ptYW4uc2kwge4GA1Ud
HwSB5jCB4zBWoFSgUqRQME4xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJzdGF0ZS1pbnN0aXR1dGlv
bnMxETAPBgNVBAsTCHNpZ2VuLWNhMQ8wDQYDVQQDEwZDUkw0NTUwgYiggYWggYKGV2xkYXA6Ly94
NTAwLmdvdi5zaS9vdT1zaWdlbi1jYSxvPXN0YXRlLWluc3RpdHV0aW9ucyxjPXNpP2NlcnRpZmlj
YXRlUmV2b2NhdGlvbkxpc3Q/YmFzZYYnaHR0cDovL3d3dy5zaWdlbi1jYS5zaS9jcmwvc2lnZW4t
Y2EuY3JsMCsGA1UdEAQkMCKADzIwMTYwMjE5MTc1NDQxWoEPMjAyMTAyMTkyMTM4MTVaMB8GA1Ud
IwQYMBaAFHF7igYfMQVVq2ASd0cgHgOIGOyJMB0GA1UdDgQWBBS7/7AHyQYI0e8GOPmwTc1ZTNw5
lzAJBgNVHRMEAjAAMBkGCSqGSIb2fQdBAAQMMAobBFY4LjEDAgOoMA0GCSqGSIb3DQEBBQUAA4IB
AQBBUL4KG1Z1oBIIdKIZs9yJxnJg/LfEPVvzNH8+CCqegq0D6k48Doo72oVEiskjqggdbUGj30uA
H8PjCD5kLGVoDwh5a2atQ3qQzaYA/lj2Js2f4fdXNn60vRp7XzbGsQdwYYecIrKzO5x6XVAIRb+T
HZNjXL3VX6vOozwBQv/+dx1P9H/rMUn7d8ci7v4PeqShbWbWwi6ez19cZvSKSkz/lWf4tj8QbA0n
WeUBlk3Bx6/TRda7kwXzcFExt+ROGt0YJjbZCN3kd7swcRvRT6gEi9L6n1XLghwPSYhzZjaL5fXv
I11JuSoQCy13XWBkq35Moo4iY19wanS1W6UM8Yq0MIIF5TCCBE2gAwIBAgINAKZovVEAAAAAVx3Q
6DANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3Zl
bmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QwHhcN
MTYwNTI0MTE1ODI3WhcNMjEwNjI3MjIwMDAwWjA9MQswCQYDVQQGEwJzaTEbMBkGA1UEChMSc3Rh
dGUtaW5zdGl0dXRpb25zMREwDwYDVQQLEwhzaWdlbi1jYTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALDlZbLArGSW8ogbs+2e5ALGTyuIzi6KUYB1rxBb8ss4ZpuiDm00R5alkhGv9jVH
onciDM4WiGKq00luGLwuRNi+xp7CGhmsQY78MAcC8sZq1FsjAO9BNNikc2PfIpIzhAGljfODXPq4
1Ho13+z4bQ/gTO2tnDp9htalCJS+fXoRH/6FP1RaiGOHnKWxp07Nt0Rzr8+KSWsf483XSU1aKxfm
XHazu3K5byfSm4kViN8QX3YhAWrHFTEK0ZxY+CgWBW3ZTtmh1wcgy0smiU2Ssqe6lujjWI8inAGW
WsT3MU0LSbXheGHiVBgGu55UNH4MPuvutYAf3RaEHWg4Zmdz+JECAwEAAaOCAkMwggI/MBIGA1Ud
EwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEwLwYEVR0gADAnMCUGCCsG
AQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUFBwEBBF0wWzA2BggrBgEF
BQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJvb3QuY3J0MCEGCCsGAQUF
BzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwHQYDVR0OBBYEFHF7igYfMQVVq2ASd0cgHgOIGOyJ
MIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9zaS10
cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qsb3Jn
YW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zlbmlq
YSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJTSTEc
MBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcxFjAU
BgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4IAmMw
DQYJKoZIhvcNAQELBQADggGBAHuvNSPhY4qcirWJkTwkqaOPqOSV06J/ZepFQfUEJ87TlrGjp4XR
5FLktTAEY/7R4Sgeb2K8OWEl/Koc1BbH6+uyZYvfa+WnnJEWeWOmyPy/vooO7eZyOVvaORxurWOL
CCVDW2wBkbtUoKZaUyzgP+ZPPGRV8GFlbZLCzGmArMGXJXe8t/XNiJDLehGqSWT49NYjyYQdIgI+
qi9W+A6BSUQ9jsMdYJqKhXQcosfH51sc6gZVxTKMr3PsItsa8XFiNazECAAFr0ms7HB6zb8QvHRF
eBGk/CLrW4VkZEBN/JtuyhvgktQ2BvuGtauEvHZQAYpMSh35D7pwtavRMpmhaAsQb4yPqhIMcztw
RqsKPBhWoaFEVZ+Vn3wxap5h/oAhocifNzkWJTNWjxnoPM2eNz2uWFJsgsNhlwteUvnq7+bKTNte
SKWKr6pI+GUsZhmCh5URpUnqUanp0Uie0MD9f3tiOLOp711sNb0xwi+VdDuDB37IddOIsfhPBood
wpoFrTGCAyEwggMdAgEBMEUwPTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0
aW9uczERMA8GA1UECxMIc2lnZW4tY2ECBDtKDS4wDQYJYIZIAWUDBAIBBQCgggGtMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MTEyNTA5NDQxOFowLwYJKoZIhvcN
AQkEMSIEIAOLQN0Xy00Bb7P9plWQwZkYLmYW78JPwrxhtkuR2BbEMFQGCSsGAQQBgjcQBDFHMEUw
PTELMAkGA1UEBhMCc2kxGzAZBgNVBAoTEnN0YXRlLWluc3RpdHV0aW9uczERMA8GA1UECxMIc2ln
ZW4tY2ECBDtKDS4wVgYLKoZIhvcNAQkQAgsxR6BFMD0xCzAJBgNVBAYTAnNpMRswGQYDVQQKExJz
dGF0ZS1pbnN0aXR1dGlvbnMxETAPBgNVBAsTCHNpZ2VuLWNhAgQ7Sg0uMIGTBgkqhkiG9w0BCQ8x
gYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAcGBSsOAwIaMA0GCSqGSIb3DQEBAQUABIIBAGTufOAeNV+84zVWe+XcsliI
683ngEoFIBfFKeou9OnIPltijvnp4BhjOsgZGGz2n9sa/KNz2nh3xSl/TqCjjzQqGGiXHZmSOK17
HYqH7qBHbx4GQXlrSRqcsG5E2lnTtopoZ4MtXOGkqkxTsT4RifVyBJgXy9lYd/sG5wZ8KD+ITibk
L3wfQt8rZrd5J8hAhNz6SmuU4LeelOrjkWnTL41n/oOgzh0/c3oh7JRTriZ4gTFlp+9Vvxw8z5DP
rcoIly/+WcuSDlxnAfOAqdOy1FOrDRILdWDwsfE5f+Kv0uYNJ8rfBlY240ldYZwc6/Ybn+PCyM8s
Ew7r829qPJmi9TIAAAAAAAA=

------=_NextPart_000_0025_01D5A37D.49D31F30--

