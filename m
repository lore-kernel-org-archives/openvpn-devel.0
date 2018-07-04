MIME-Version: 1.0
References: <DM5PR2101MB1112D9B5D70AC19014BC5BEDB0420@...2412...>
 <MW2PR2101MB09219BB9BA77ADD409D3DFECAB410@...2433...>
In-Reply-To: <MW2PR2101MB09219BB9BA77ADD409D3DFECAB410@...2433...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 4 Jul 2018 13:04:21 +0500
Message-ID: <CAFHpkQHPWDfPDqiJ0_7FrMLc18q9EoC8j1NBAkYx9snXo+V0Uw@...278...>
Content-Type: multipart/alternative; boundary="00000000000085da31057027e17f"
Subject: Re: [Openvpn-devel] Upstreaming pqcrypto changes from
 microsoft/openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kkane@...2393...
Cc: jkunkee@...2393..., =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000085da31057027e17f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I meant "vpndialer" part first :)

as for PQ crypto - I played with it, however, it is currently far from
worldwide adoption (if that would have been implemented as openssl loadable
engine, it would be more luck....)

=D1=81=D1=80, 4 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 5:17, Kevin Kane <k=
kane@...2393...>:

> Hello all,
>
> Thanks to Jon for making the introduction. My team works on post-quantum
> (PQ) cryptography, which is algorithms used by regular computers but which
> are resistant to attack by a sufficiently powerful quantum computer. This
> OpenVPN fork is an example application we released so the public could
> experiment with it.
>
> The following sites have information on what we're doing:
>
> Our openvpn, openvpn-build, and openvpn-gui forks are subprojects of the
> following repo: https://github.com/Microsoft/PQCrypto-VPN
>
> I just realized there are no back-pointers from the subprojects back to
> the main repo. I've just corrected that.
>
> On this site are scripts and instructions for doing our custom build of
> OpenVPN for Windows and Linux, to use the PQ crypto-enabled fork of OpenS=
SL
> we use, and how to properly configure it for PQ crypto. We also provide
> instructions for building an image for a Raspberry Pi to be used as a wifi
> access point that tunnels all traffic to a remote server protected by PQ
> key exchange. We also have released pre-built Linux x64 and Windows
> binaries. Our current build process works but there is plenty of room for
> improvement.
>
> A more in-depth description of the PQ VPN is here:
> https://www.microsoft.com/en-us/research/project/post-quantum-crypto-vpn/
>
> And our introduction to post-quantum cryptography overall is here:
> https://www.microsoft.com/en-us/research/project/post-quantum-cryptograph=
y/
>
> As Jon said, these algorithms are experimental and so it would be
> inappropriate to introduce them into production code until the
> standardization and thorough analysis by the cryptographic community are
> completed. When that happens, we want to be ready to quickly integrate
> these algorithms into existing software. My colleagues are already
> contributing to a PQ crypto-enabled fork of OpenSSL (
> https://github.com/open-quantum-safe/openssl), and similarly we believe
> there is value in maintaining a PQ-enabled fork of OpenVPN, so that both
> are ready when there is consensus on a standard.
>
> I will be updating the fork to track the forward progress of both the
> PQ-enabled OpenSSL fork and OpenVPN as time allows, but I welcome the
> participation of anyone who's interested in helping with the updates or
> making other improvements, as well as any suggestions you may have on
> future directions for this work.
>
> -----Original Message-----
> From: Jon Kunkee
> Sent: Tuesday, July 3, 2018 4:20 PM
> To: Samuli Sepp=C3=A4nen <samuli@...515...>; =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <
> chipitsine@...277...>; Kevin Kane <kkane@...2393...>
> Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Subject: Upstreaming pqcrypto changes from microsoft/openvpn
>
> Hi,
>
> (Retitling thread from RE: [Openvpn-devel] Topics for the community
> meeting (Wed, 13th June 2018))
>
> > do you know this activity https://github.com/Microsoft/openvpn/ ?
> > there are interesting things
>
> There are *very* interesting things there!
>
> > Do you know if Kevin (or his manager/team) plans to push his work
> upstream (i.e. to us) at some point?
>
> Samuli and =D0=98=D0=BB=D1=8C=D1=8F, I'd like to introduce you to Kevin K=
ane. He is the
> current maintainer of the Microsoft\openvpn pqcrypto branch on Github.
>
> He is working on developing encryption standards that are resistant to
> quantum-mechanics-based attacks. This includes taking existing products a=
nd
> adding experimental implementations of the experimental standards to
> them=E2=80=94including OpenVPN and OpenSSL. Over time these new technique=
s will be
> studied, refined, tested, and otherwise hammered on in the furnace of
> open-source cryptography until they gain some measure of trust.
>
> Both the experimental and untested nature of his work mean that no, his
> code isn=E2=80=99t ready to be merged into OpenVPN/master=E2=80=A6yet!
>
> In the meantime, he would love to work with someone from the OpenVPN
> community=E2=80=94or even the organization itself=E2=80=94to make the con=
nection official
> and to refine his additions. Some of the needed refinement requires
> familiarity with the overall build system, while a forward-looking
> cryptographer or protocol guru might take interest in what's developing
> under the hood.
>
> I don't know much about the current status of the project, but Kevin is
> happy to answer questions and would love to hear from you.
>
> Thanks,
> Jon
>
>

--00000000000085da31057027e17f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I meant &quot;vpndialer&=
quot; part first :)</div><div><br></div><div>as for PQ crypto - I played wi=
th it, however, it is currently far from worldwide adoption (if that would =
have been implemented as openssl loadable engine, it would be more luck....=
)<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">=D1=81=D1=
=80, 4 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 5:17, Kevin Kane &lt;<a href=
=3D"mailto:kkane@...2393...">kkane@...2393...</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Hello all,<br>
<br>
Thanks to Jon for making the introduction. My team works on post-quantum (P=
Q) cryptography, which is algorithms used by regular computers but which ar=
e resistant to attack by a sufficiently powerful quantum computer. This Ope=
nVPN fork is an example application we released so the public could experim=
ent with it. <br>
<br>
The following sites have information on what we&#39;re doing:<br>
<br>
Our openvpn, openvpn-build, and openvpn-gui forks are subprojects of the fo=
llowing repo: <a href=3D"https://github.com/Microsoft/PQCrypto-VPN" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/Microsoft/PQCrypto-VPN</a>=
<br>
<br>
I just realized there are no back-pointers from the subprojects back to the=
 main repo. I&#39;ve just corrected that.<br>
<br>
On this site are scripts and instructions for doing our custom build of Ope=
nVPN for Windows and Linux, to use the PQ crypto-enabled fork of OpenSSL we=
 use, and how to properly configure it for PQ crypto. We also provide instr=
uctions for building an image for a Raspberry Pi to be used as a wifi acces=
s point that tunnels all traffic to a remote server protected by PQ key exc=
hange. We also have released pre-built Linux x64 and Windows binaries. Our =
current build process works but there is plenty of room for improvement.<br>
<br>
A more in-depth description of the PQ VPN is here: <a href=3D"https://www.m=
icrosoft.com/en-us/research/project/post-quantum-crypto-vpn/" rel=3D"norefe=
rrer" target=3D"_blank">https://www.microsoft.com/en-us/research/project/po=
st-quantum-crypto-vpn/</a><br>
<br>
And our introduction to post-quantum cryptography overall is here: <a href=
=3D"https://www.microsoft.com/en-us/research/project/post-quantum-cryptogra=
phy/" rel=3D"noreferrer" target=3D"_blank">https://www.microsoft.com/en-us/=
research/project/post-quantum-cryptography/</a><br>
<br>
As Jon said, these algorithms are experimental and so it would be inappropr=
iate to introduce them into production code until the standardization and t=
horough analysis by the cryptographic community are completed. When that ha=
ppens, we want to be ready to quickly integrate these algorithms into exist=
ing software. My colleagues are already contributing to a PQ crypto-enabled=
 fork of OpenSSL (<a href=3D"https://github.com/open-quantum-safe/openssl" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/open-quantum-safe/o=
penssl</a>), and similarly we believe there is value in maintaining a PQ-en=
abled fork of OpenVPN, so that both are ready when there is consensus on a =
standard.<br>
<br>
I will be updating the fork to track the forward progress of both the PQ-en=
abled OpenSSL fork and OpenVPN as time allows, but I welcome the participat=
ion of anyone who&#39;s interested in helping with the updates or making ot=
her improvements, as well as any suggestions you may have on future directi=
ons for this work.<br>
<br>
-----Original Message-----<br>
From: Jon Kunkee <br>
Sent: Tuesday, July 3, 2018 4:20 PM<br>
To: Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515..." target=3D"=
_blank">samuli@...515...</a>&gt;; =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277..." tar=
get=3D"_blank">chipitsine@...277...</a>&gt;; Kevin Kane &lt;<a href=3D"mail=
to:kkane@...2393..." target=3D"_blank">kkane@...2393...</a>&gt;<br>
Cc: openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net=
" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt;<br>
Subject: Upstreaming pqcrypto changes from microsoft/openvpn<br>
<br>
Hi,<br>
<br>
(Retitling thread from RE: [Openvpn-devel] Topics for the community meeting=
 (Wed, 13th June 2018))<br>
<br>
&gt; do you know this activity <a href=3D"https://github.com/Microsoft/open=
vpn/" rel=3D"noreferrer" target=3D"_blank">https://github.com/Microsoft/ope=
nvpn/</a> ?<br>
&gt; there are interesting things<br>
<br>
There are *very* interesting things there!<br>
<br>
&gt; Do you know if Kevin (or his manager/team) plans to push his work upst=
ream (i.e. to us) at some point?<br>
<br>
Samuli and =D0=98=D0=BB=D1=8C=D1=8F, I&#39;d like to introduce you to Kevin=
 Kane. He is the current maintainer of the Microsoft\openvpn pqcrypto branc=
h on Github.<br>
<br>
He is working on developing encryption standards that are resistant to quan=
tum-mechanics-based attacks. This includes taking existing products and add=
ing experimental implementations of the experimental standards to them=E2=
=80=94including OpenVPN and OpenSSL. Over time these new techniques will be=
 studied, refined, tested, and otherwise hammered on in the furnace of open=
-source cryptography until they gain some measure of trust.<br>
<br>
Both the experimental and untested nature of his work mean that no, his cod=
e isn=E2=80=99t ready to be merged into OpenVPN/master=E2=80=A6yet!<br>
<br>
In the meantime, he would love to work with someone from the OpenVPN commun=
ity=E2=80=94or even the organization itself=E2=80=94to make the connection =
official and to refine his additions. Some of the needed refinement require=
s familiarity with the overall build system, while a forward-looking crypto=
grapher or protocol guru might take interest in what&#39;s developing under=
 the hood.<br>
<br>
I don&#39;t know much about the current status of the project, but Kevin is=
 happy to answer questions and would love to hear from you.<br>
<br>
Thanks,<br>
Jon<br>
<br>
</blockquote></div>

--00000000000085da31057027e17f--

