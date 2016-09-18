Content-Type: multipart/alternative;
	boundary="Apple-Mail=_93FC5A63-73E6-42C8-ABA9-DE1C9057403E"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <CAFHpkQFFkL_3Zv=F1y=CmPoe_PY14VnnnNS1BrxSpT-5A-KNuA@...278...>
Date: Sun, 18 Sep 2016 18:34:32 +0200
Message-Id: <8D624060-471D-42CA-BC8F-9EBA929A6B75@...2127...>
References: <1474208364-11251-1-git-send-email-chipitsine@...277...>
	<2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
	<CAFHpkQFFkL_3Zv=F1y=CmPoe_PY14VnnnNS1BrxSpT-5A-KNuA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cppcheck finding: add "ASSERT(
	maxoutput > 0 || separator != NULL )" to prevent possible
	null pointer derefence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_93FC5A63-73E6-42C8-ABA9-DE1C9057403E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> Hello,
>=20
> this defect was found by cppcheck, however cppcheck still complains.
> so, we did not make it happy yet.
>=20
> I think, the best would be split this function into 2 separate functions
> (with either null argument) or leave it like that.

Unrelated to an actual fix, IMHO we should at least break up

out =3D alloc_buf_gc (maxoutput ? maxoutput :
				    ((size * 2) + (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) *=
 (int) strlen (separator) + 2),
				    gc);

and create a variable with a semantic variable for the result of   "((size =
* 2) + (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen (=
separator) + 2)=E2=80=9D

Honestly the calculation looks very arcane and I would better understand it=
, if i knew what it means :-)

Jens=

--Apple-Mail=_93FC5A63-73E6-42C8-ABA9-DE1C9057403E
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D""><div><blockquote t=
ype=3D"cite" class=3D""><br class=3D"Apple-interchange-newline"><div class=
=3D""><span style=3D"font-family: Helvetica; font-size: 12px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; orphans: auto; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; float: none; display: inline !important;" class=3D"">Hello,</=
span><br style=3D"font-family: Helvetica; font-size: 12px; font-style: norm=
al; font-variant-caps: normal; font-weight: normal; letter-spacing: normal;=
 orphans: auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -we=
bkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: Helvet=
ica; font-size: 12px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; orphans: auto; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; widows: auto; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: inli=
ne !important;" class=3D"">this defect was found by cppcheck, however cppch=
eck still complains.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: He=
lvetica; font-size: 12px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; orphans: auto; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; widows: auto=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">so, we did not make it happy yet.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans:=
 auto; text-align: start; text-indent: 0px; text-transform: none; white-spa=
ce: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px=
;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; font-st=
yle: normal; font-variant-caps: normal; font-weight: normal; letter-spacing=
: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text=
-stroke-width: 0px;" class=3D""><span style=3D"font-family: Helvetica; font=
-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: no=
rmal; letter-spacing: normal; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; float: none; display: inline !impor=
tant;" class=3D"">I think, the best would be split this function into 2 sep=
arate functions</span><br style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; widows: auto; word-spacing: 0px; -web=
kit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: Helveti=
ca; font-size: 12px; font-style: normal; font-variant-caps: normal; font-we=
ight: normal; letter-spacing: normal; orphans: auto; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; widows: auto; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: inlin=
e !important;" class=3D"">(with either null argument) or leave it like that=
.</span><br style=3D"font-family: Helvetica; font-size: 12px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; orphans: auto; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-strok=
e-width: 0px;" class=3D""></div></blockquote><div><br class=3D""></div><div=
>Unrelated to an actual fix, IMHO we should at least break up</div><div><br=
 class=3D""></div><div>out =3D alloc_buf_gc (maxoutput ? maxoutput :<br cla=
ss=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>=
<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span cl=
ass=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span class=3D"A=
pple-tab-span" style=3D"white-space: pre;">	</span>&nbsp;&nbsp;&nbsp;&nbsp;=
((size * 2) + (size / (space_break_flags &amp; FHE_SPACE_BREAK_MASK)) * (in=
t) strlen (separator) + 2),<br class=3D""><span class=3D"Apple-tab-span" st=
yle=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" style=3D"w=
hite-space: pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-spa=
ce: pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;=
">	</span>&nbsp;&nbsp;&nbsp;&nbsp;gc);</div><div><br class=3D""></div><div>=
and create a variable with a semantic variable for the result of &nbsp; "((=
size * 2) + (size / (space_break_flags &amp; FHE_SPACE_BREAK_MASK)) * (int)=
 strlen (separator) + 2)=E2=80=9D</div><div><br class=3D""></div><div>Hones=
tly the calculation looks very arcane and I would better understand it, if =
i knew what it means :-)</div><div><br class=3D""></div><div>Jens</div></di=
v></body></html>=

--Apple-Mail=_93FC5A63-73E6-42C8-ABA9-DE1C9057403E--

