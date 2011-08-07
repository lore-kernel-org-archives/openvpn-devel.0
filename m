From: Russell Morris <openvpn@...1315...>
Date: Sun, 07 Aug 2011 18:15:02 -0500
Message-id: <1312758902759591500@...1315...>
In-reply-to: <1311721403985112500@...1315...>
References: <1311649077083710500@...1315...> <4E2E3AC5.2030005@...1299...>
	<1311721403985112500@...1315...>
MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="===axigen=8467581074534554896133085534841835275798=axigen==="
Subject: Re: [Openvpn-devel] Windows Auto-Proxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason.Haar@...1299...>, openvpn-devel@lists.sourceforge.net

This is a MIME message. You may need a MIME compliant mail user agent.
--===axigen=8467581074534554896133085534841835275798=axigen===
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=20

Has anyone had any luck with the auto-proxy function, in particular with PA=
C files? It really doesn't seem to be working for me ... :-(.

=20

Also, does anyone have a proxy server that requires authentication? I curre=
ntly use a text file (which does work!), but there are also Windows functio=
ns that should send domain login information automatically. It would be nic=
e to to that ... :-).

=20

Thoughts?

=20

Thanks!

=20

... Russell

=20



On Tue, 07/26/2011 06:03 PM, Russell Morris <openvpn@...1315...> wrote:


>=20



Hi,

=20

I admit, I didn't know about that option - guess I missed that ... :-(.

=20

When you mentioned it though, I was very happy to see it - so I decided to =
give it a try. It doesn't seem to work for me though (perhaps because of pr=
oxy PAC files?). Is there a way to see what proxy OpenVPN detected (to try =
to debug this)?

=20

Thanks,

... Russell

=20


>=20
> On Mon, 07/25/2011 10:55 PM, Jason Haar <Jason.Haar@...1299...> wrote:
>=20

>=20

On 26/07/11 14:57, Russell Morris wrote:=20
>=20


>=20





 *=20
 *=20
 *=20



I use OpenVPN with a Windows client, and I tend to be on one network one mi=
nute, another the next. One time with a proxy, the next time without =E2=80=
=A6 so I really want OpenVPN to automatically detect the proxy (if there is=
 one), and apply it =E2=80=A6 for every connection restart, client open, et=
c. My thinking is to add a new option, say something like =E2=80=9Cauto-pro=
xy=E2=80=9D (so this won=E2=80=99t break anything that is already working!)=
. The idea being that if this option is enabled, then on every connection /=
 reconnection attempt OpenVPN will first check the proxy, and then apply it=
 for the actual connection back to the server. Hopefully this makes sense s=
o far =E2=80=A6 J.

...isn't that already done by "--auto-proxy"? Been part of openvpn since 2.=
1(ish?)

BTW: I totally agree this is a big deal. For openvpn to be truly brilliant,=
 it needs

1. one config to handle both udp and tcp-based "<connection>" profiles [sor=
ta supported]
2. "fragment", "mss-fix" and proxy support within profiles  [not currently =
supported - which effectively makes "1." never work in practice]
3. dynamically figure out if a proxy is available and use that for TCP-base=
d profiles [I thought that was supported by "--auto-proxy"]

With such features and a properly ordered config, you'd have a VPN client t=
hat would tunnel out over UDP if it can, TCP if it can't, and TCP-via-proxy=
 if it has to. Basically, you'd be guaranteed a working VPN session on any =
network that you're meant to be able to do such things on (with one config).


--=20
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1

---------------------------------------------------------------------------=
---
Magic Quadrant for Content-Aware Data Loss Prevention
Research study explores the data loss prevention market. Includes in-depth
analysis on the changes within the DLP market, and the criteria used to
evaluate the strengths and weaknesses of these DLP solutions.
http://www.accelacomm.com/jaw/sfnl/114/51385063/ __________________________=
_____________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
---------------------------------------------------------------------------=
---
Got Input? Slashdot Needs You.
Take our quick survey online. Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey _______________________________________=
________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===axigen=8467581074534554896133085534841835275798=axigen===
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html><head><style id=3D"axi-htmleditor-style" type=3D"text/css">p { margin=
: 0px; }</style></head><body style=3D"font-size: 10pt; font-family: Arial; =
background-image: none; background-repeat: repeat; background-attachment: f=
ixed;"><P>Hi,</P>
<P>&nbsp;</P>
<P>Has anyone had any luck with the auto-proxy function, in particular with=
 PAC files? It really doesn't seem to be working for me ... :-(.</P>
<P>&nbsp;</P>
<P>Also, does anyone have a proxy server that requires authentication? I cu=
rrently use a text file (which does work!), but there are also Windows func=
tions that should send domain login information automatically. It would be =
nice to to that ... :-).</P>
<P>&nbsp;</P>
<P>Thoughts?</P>
<P>&nbsp;</P>
<P>Thanks!</P>
<P>&nbsp;</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P><BR><BR>On Tue, 07/26/2011 06:03 PM, Russell&nbsp;Morris&nbsp;&lt;openvp=
n@...1315...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"FONT-FAMILY: Arial; FONT-SIZE: 10pt">
<STYLE id=3Daxi-htmleditor-style type=3Dtext/css>p { margin: 0px; }</STYLE>

<P>Hi,</P>
<P>&nbsp;</P>
<P>I admit, I didn't know about that option - guess I missed that ... :-(.<=
/P>
<P>&nbsp;</P>
<P>When you mentioned it though, I was very happy to see it - so I decided =
to give it a try. It doesn't seem to work for me though (perhaps because of=
 proxy PAC files?). Is there a way to see what proxy OpenVPN detected (to t=
ry to debug this)?</P>
<P>&nbsp;</P>
<P>Thanks,</P>
<P>... Russell</P>
<P>&nbsp;</P>
<P><BR><BR>On Mon, 07/25/2011 10:55 PM, Jason&nbsp;Haar&nbsp;&lt;Jason.Haar=
@...1299...&gt; wrote:<BR></P>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(0,0,204) 2px solid; PADDING-LEFT: 4px=
; MARGIN-LEFT: 16px">
<DIV style=3D"null: ">
<META content=3D"text/html; charset=3DISO-8859-1" http=3D"http" equiv=3D"Co=
ntent-Type">On 26/07/11 14:57, Russell Morris wrote:=20
<BLOCKQUOTE cite=3Dmid:1311649077083710500@...1315... type=3D"cite">
<STYLE id=3Daxi-htmleditor-style type=3Dtext/css>p { margin: 0px; }</STYLE>
<BR>
<DIV>
<META content=3D"text/html; charset=3Dus-ascii" http=3D"HTTP" equiv=3D"Cont=
ent-Type">
<META name=3DProgId content=3DWord.Document>
<META name=3DGenerator content=3D"Microsoft Word 12">
<META name=3DOriginator content=3D"Microsoft Word 12"><LINK rel=3DFile-List=
><LINK rel=3DthemeData href=3D"~~themedata~~"><LINK rel=3DcolorSchemeMappin=
g href=3D"~~colorschememapping~~">
<STYLE><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-alt:Wingdings;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-alt:"Calisto MT";
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Arial Rounded MT Bold";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	mso-themecolor:hyperlink;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></STYLE>

<DIV class=3DWordSection1>
<P class=3DMsoNormal>I use OpenVPN with a Windows client, and I tend to be =
on one network one minute, another the next. One time with a proxy, the nex=
t time without =E2=80=A6 so I really want OpenVPN to automatically detect t=
he proxy (if there is one), and apply it =E2=80=A6 for every connection res=
tart, client open, etc. My thinking is to add a new option, say something l=
ike =E2=80=9Cauto-proxy=E2=80=9D (so this won=E2=80=99t break anything that=
 is already working!). The idea being that if this option is enabled, then =
on every connection / reconnection attempt OpenVPN will first check the pro=
xy, and then apply it for the actual connection back to the server. Hopeful=
ly this makes sense so far =E2=80=A6 <SPAN style=3D"FONT-FAMILY: " type=3D"=
type" ascii=3D"ascii" calibri=3D"Calibri" hansi=3D"hansi" theme=3D"theme" m=
inor=3D"minor" latin=3D"latin" char=3D"char" mso=3D"mso" symbol=3D"symbol" =
font=3D"font" family=3D"family" wingdings=3D"Wingdings"><SPAN style=3D"mso-=
char-type: " mso=3D"mso" symbol=3D"symbol" font=3D"font" family=3D"family" =
wingdings=3D"Wingdings">J</SPAN></SPAN>.</P></DIV></DIV></BLOCKQUOTE><BR>..=
.isn't that already done by "--auto-proxy"? Been part of openvpn since 2.1(=
ish?)<BR><BR>BTW: I totally agree this is a big deal. For openvpn to be tru=
ly brilliant, it needs<BR><BR>1. one config to handle both udp and tcp-base=
d "&lt;connection&gt;" profiles [sorta supported]<BR>2. "fragment", "mss-fi=
x" and proxy support within profiles&nbsp; [not currently supported - which=
 effectively makes "1." never work in practice]<BR>3. dynamically figure ou=
t if a proxy is available and use that for TCP-based profiles [I thought th=
at was supported by "--auto-proxy"]<BR><BR>With such features and a properl=
y ordered config, you'd have a VPN client that would tunnel out over UDP if=
 it can, TCP if it can't, and TCP-via-proxy if it has to. Basically, you'd =
be guaranteed a working VPN session on any network that you're meant to be =
able to do such things on (with one config).<BR><BR><BR><PRE class=3Dmoz-si=
gnature cols=3D"72">--=20
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1
</PRE>---------------------------------------------------------------------=
---------<BR>Magic Quadrant for Content-Aware Data Loss Prevention<BR>Resea=
rch study explores the data loss prevention market. Includes in-depth<BR>an=
alysis on the changes within the DLP market, and the criteria used to<BR>ev=
aluate the strengths and weaknesses of these DLP solutions.<BR><A href=3D"h=
ttp://server.home:8080/redir.hsp?url=3Dhttp%3A%2F%2Fserver.home%3A8080%2Fre=
dir.hsp%3Furl%3D%68%74%74%70%3A%2F%2F%77%77%77%2E%61%63%63%65%6C%61%63%6F%6=
D%6D%2E%63%6F%6D%2F%6A%61%77%2F%73%66%6E%6C%2F%31%31%34%2F%35%31%33%38%35%3=
0%36%33%2F" target=3D_blank>http://www.accelacomm.com/jaw/sfnl/114/51385063=
/</A> _______________________________________________<BR>Openvpn-devel mail=
ing list<BR><A href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-=
devel@lists.sourceforge.net</A><BR><A href=3D"http://server.home:8080/redir=
.hsp?url=3Dhttp%3A%2F%2Fserver.home%3A8080%2Fredir.hsp%3Furl%3D%68%74%74%70=
%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%67%65%2E%6E%65%74=
%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E%76%70%6E%2D%64=
%65%76%65%6C" target=3D_blank>https://lists.sourceforge.net/lists/listinfo/=
openvpn-devel</A><BR></DIV></BLOCKQUOTE>-----------------------------------=
-------------------------------------------<BR>Got Input? Slashdot Needs Yo=
u.<BR>Take our quick survey online. Come on, we don't ask for help often.<B=
R>Plus, you'll get a chance to win $100 to spend on ThinkGeek.<BR><A href=
=3D"http://server.home:8080/redir.hsp?url=3D%68%74%74%70%3A%2F%2F%70%2E%73%=
66%2E%6E%65%74%2F%73%66%75%2F%73%6C%61%73%68%64%6F%74%2D%73%75%72%76%65%79"=
 target=3D_blank>http://p.sf.net/sfu/slashdot-survey</A> __________________=
_____________________________<BR>Openvpn-devel mailing list<BR><A href=3D"m=
ailto:Openvpn-devel@lists.sourceforge.net" target=3D_blank>Openvpn-devel@...1224...=
sts.sourceforge.net</A><BR><A href=3D"http://server.home:8080/redir.hsp?url=
=3D%68%74%74%70%73%3A%2F%2F%6C%69%73%74%73%2E%73%6F%75%72%63%65%66%6F%72%67=
%65%2E%6E%65%74%2F%6C%69%73%74%73%2F%6C%69%73%74%69%6E%66%6F%2F%6F%70%65%6E=
%76%70%6E%2D%64%65%76%65%6C" target=3D_blank>https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</A><BR></DIV></BLOCKQUOTE></body></html>=

--===axigen=8467581074534554896133085534841835275798=axigen===--


