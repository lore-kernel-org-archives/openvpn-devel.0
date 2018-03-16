Date: Fri, 16 Mar 2018 16:50:48 +0000 (UTC)
From: Ning Wei <xiaoningning@...109...>
Message-ID: <866575943.1904187.1521219048538@...2084...>
In-Reply-To: <20180316164554.GI69387@...1296...>
References: <20180316164059.9120-1-xiaoningning@...109...>
 <20180316164554.GI69387@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_1904186_2137670832.1521219048536"
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

------=_Part_1904186_2137670832.1521219048536
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thank you for reminding this.=C2=A0 The reason that I have resent was ther=
e was a typo in the commit comment.
Best regards,Ning
    On Friday, March 16, 2018, 9:46:07 AM PDT, Gert Doering <gert@...2132...=
.> wrote:=20=20
=20
 Hi,

On Fri, Mar 16, 2018 at 09:40:59AM -0700, Ning Wei via Openvpn-devel wrote:
> Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
> ENABLE_PKCS11, the password field can be 4096.=C2=A0 The old size of
> TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.

Please do not keep re-sending this patch just because you did not get
a response right away.=C2=A0 This messes up our patch tracking in patchwork,
and annoys those that will eventually find time to review it.

Such a change might cause incompatibilities or overflows in unexpected
ways, so a review is complex and not just anyone can do it - and those
few that understand the openvpn protocol <-> tls interaction well=20
enough are quite busy with other work.

So, patience please.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gert@...1296...=20=20=

------=_Part_1904186_2137670832.1521219048536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:13px;"><div></div>
            <div>Thank you for reminding this.&nbsp; The reason that I have=
 resent was there was a typo in the commit comment.</div><div><br></div><di=
v>Best regards,</div><div>Ning</div><div><br></div>
=20=20=20=20=20=20=20=20=20=20=20=20
            <div id=3D"yahoo_quoted_1940664204" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                    <div>
                        On Friday, March 16, 2018, 9:46:07 AM PDT, Gert Doe=
ring &lt;gert@...1296...&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div>Hi,<br clear=3D"none"><div class=3D"yqt4689090325"=
 id=3D"yqtfd28460"><br clear=3D"none">On Fri, Mar 16, 2018 at 09:40:59AM -0=
700, Ning Wei via Openvpn-devel wrote:<br clear=3D"none">&gt; Increase TLS_=
CHANNEL_BUF_SIZE to 4096. When the build is enabled with<br clear=3D"none">=
&gt; ENABLE_PKCS11, the password field can be 4096.&nbsp; The old size of<b=
r clear=3D"none">&gt; TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.</=
div><br clear=3D"none"><br clear=3D"none">Please do not keep re-sending thi=
s patch just because you did not get<br clear=3D"none">a response right awa=
y.&nbsp; This messes up our patch tracking in patchwork,<br clear=3D"none">=
and annoys those that will eventually find time to review it.<br clear=3D"n=
one"><br clear=3D"none">Such a change might cause incompatibilities or over=
flows in unexpected<br clear=3D"none">ways, so a review is complex and not =
just anyone can do it - and those<br clear=3D"none">few that understand the=
 openvpn protocol &lt;-&gt; tls interaction well <br clear=3D"none">enough =
are quite busy with other work.<br clear=3D"none"><br clear=3D"none">So, pa=
tience please.<br clear=3D"none"><br clear=3D"none">gert<br clear=3D"none">=
-- <br clear=3D"none">now what should I write here...<br clear=3D"none"><br=
 clear=3D"none">Gert Doering - Munich, Germany&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <a sh=
ape=3D"rect" ymailto=3D"mailto:gert@...1296..." href=3D"mailto:gert@...1726...=
...">gert@...1296...</a></div>
                </div>
            </div></div></body></html>=

------=_Part_1904186_2137670832.1521219048536--

