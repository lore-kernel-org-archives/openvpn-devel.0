MIME-Version: 1.0
In-Reply-To: <4001174.479134.1431430060517.JavaMail.root@...1893...>
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>
	<5551BE33.2010208@...1227...>
	<4001174.479134.1431430060517.JavaMail.root@...1893...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 12 May 2015 07:47:17 -0400
Message-ID: <CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>
Content-Type: multipart/alternative; boundary=001a1138e37ad3915c0515e110a8
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
	software
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1138e37ad3915c0515e110a8
Content-Type: text/plain; charset=UTF-8

On Tue, May 12, 2015 at 7:27 AM, Lisa Minogue <lminogue@...1892...> wrote:

> Can I conclude from your above statements that applying obfuscation
> patches to the standard OpenVPN client software may actually introduce
> security vulnerabilities?
>

The openvpn_xorpatch
<https://github.com/clayface/openvpn_xorpatch/blob/master/openvpn_xor.patch>
which
as introduced and discussed in this thread
<https://forums.openvpn.net/topic12605.html> does have some vulnerabilities
See Tunnelblick openvpn_xorpatch
<https://code.google.com/p/tunnelblick/wiki/cOpenvpn_xorpatch> for a
further discussion of the patch.

Most of the vulnerabilities are null pointer dereferences or other errors
when parsing the "scramble" option or are triggered by unlikely values for
its parameters. However, one is a potential buffer overflow which can occur
while the VPN is active and could potentially be triggered by carefully
constructed traffic.

--001a1138e37ad3915c0515e110a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, May 12, 2015 at 7:27 AM, Lisa Minogue <span dir=3D"ltr">&lt;<a href=3D"=
mailto:lminogue@...1892..." target=3D"_blank">lminogue@...1892...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex">Can I conclude from your above statements =
that applying obfuscation patches to the standard OpenVPN client software m=
ay actually introduce security vulnerabilities?<br></blockquote><div><br></=
div><div>The=C2=A0<a href=3D"https://github.com/clayface/openvpn_xorpatch/b=
lob/master/openvpn_xor.patch" rel=3D"nofollow" style=3D"color:rgb(0,0,204);=
font-size:13.1199998855591px;line-height:16.3999996185303px">openvpn_xorpat=
ch</a>=C2=A0which as introduced and discussed=C2=A0<a href=3D"https://forum=
s.openvpn.net/topic12605.html" rel=3D"nofollow" style=3D"color:rgb(0,0,204)=
;font-size:13.1199998855591px;line-height:16.3999996185303px">in this threa=
d</a>=C2=A0does have some vulnerabilities See=C2=A0<a href=3D"https://code.=
google.com/p/tunnelblick/wiki/cOpenvpn_xorpatch" style=3D"color:rgb(0,0,204=
);font-size:13.1199998855591px;background-color:rgb(248,248,248)">Tunnelbli=
ck openvpn_xorpatch</a>=C2=A0for a further discussion of the patch.</div><d=
iv><div><br></div><div>Most of the vulnerabilities are null pointer derefer=
ences or other errors when parsing the &quot;scramble&quot; option or are t=
riggered by unlikely values for its parameters. However, one is a potential=
 buffer overflow which can occur while the VPN is active and could potentia=
lly be triggered by carefully constructed traffic.</div><div class=3D"gmail=
_extra"><br></div></div></div></div></div>

--001a1138e37ad3915c0515e110a8--

