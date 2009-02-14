Date: Sat, 14 Feb 2009 11:23:03 +0530 (IST)
From: mk rao <keshava_2103@...293...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-308462627-1234590783=:88057"
Message-ID: <765905.88057.qm@...1197...>
Subject: [Openvpn-devel] OpenVPN with pre-shared secret keys
Reply-To: keshava_2103@...293...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-308462627-1234590783=:88057
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I=C2=A0would like run openvpn=C2=A0with mulit-client and server set-up usin=
g pre-shared keys which is presently not supported by openvpn.=20
I have gone=C2=A0through the source code. I could able to locate certain fu=
nction which encrypt/decrypt's packets. i.e openvpn_encrypt(), openvpn_decr=
ypt() functions in crypto.c.
But above function also uses tls function, which is driven by public-key's =
and certificate's.=20
I would like to know that,=C2=A0what are functions i should use or fine tun=
e or add so that i can=C2=A0add another features to OpenVPN which=C2=A0 all=
ows=C2=A0to=C2=A0set-up mulit-client and server=C2=A0by=C2=A0 using=C2=A0si=
mple=C2=A0pre-shared keys only.
=C2=A0
It will be helpfull if any body helps or gives some pointers for=C2=A0above=
 mentioned problem.
=C2=A0
Thanks
M.K.R



      Add more friends to your messenger and enjoy! Go to http://messenger.=
yahoo.com/invite/=

--0-308462627-1234590783=:88057
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>Hi,<BR>I&nbsp;would like run openvpn&nbs=
p;with mulit-client and server set-up using pre-shared keys which is presen=
tly not supported by openvpn. </DIV>
<DIV>I have gone&nbsp;through the source code. I could able to locate certa=
in function which encrypt/decrypt's packets. i.e openvpn_encrypt(), openvpn=
_decrypt() functions in crypto.c.</DIV>
<DIV>But above function also uses tls function, which is driven by public-k=
ey's and certificate's. </DIV>
<DIV>I would like to know that,&nbsp;what are functions i should use or fin=
e tune or add so that i can&nbsp;add another features to OpenVPN which&nbsp=
; allows&nbsp;to&nbsp;set-up mulit-client and server&nbsp;by&nbsp; using&nb=
sp;simple&nbsp;pre-shared keys only.</DIV>
<DIV>&nbsp;</DIV>
<DIV>It will be helpfull if any body helps or gives some pointers for&nbsp;=
above mentioned problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks<BR>M.K.R<BR></DIV></td></tr></table><br>
      <!--6--><hr size=3D1></hr> Add more friends to your messenger and enj=
oy! <a href=3D"http://in.rd.yahoo.com/tagline_messenger_6/*http://messenger=
.yahoo.com/invite/"> Invite them now.</a>=

--0-308462627-1234590783=:88057--

