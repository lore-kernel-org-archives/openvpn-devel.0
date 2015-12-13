MIME-Version: 1.0
In-Reply-To: <CAEsd45R3t63kG=x8o9rxUB98sDqKtGK9kw424BaPag43X55O=w@...278...>
References: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
	<CAKuzo_it8Y25Z0Bw4i-X+FiY80K2cT9X5Q7oQ4wxN-Ds_SPAOA@...278...>
	<CAEsd45R3t63kG=x8o9rxUB98sDqKtGK9kw424BaPag43X55O=w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 13 Dec 2015 14:13:50 -0500
Message-ID: <CAKuzo_juNMKRnpVfxi3GBqkrEJNW-hrG6U0vrv7jks0qdLHCcg@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9e76113c0526cc5c7b
Subject: Re: [Openvpn-devel] Options that are "safe" for users to modify?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443d9e76113c0526cc5c7b
Content-Type: text/plain; charset=UTF-8

forgot to copy the list..

Hi,

Sorry, I missed the point that only referenced files are being replaced.

On Sat, Dec 12, 2015 at 9:31 PM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

> I'm not clear at all about --crl-verify. Would it ever be used in a
> client? Would there be a security risk if a client erased the contents
> of the file? (Would that allow a client to connect to a server that
> has a revoked certificate which would otherwise not be allowed?
>

The risk appears to be even less than that of the user replacing ca
(i.e very minor). With a new ca, the user can connect to a server
presenting
a cert from that ca. With crl replaced or removed,  the client can connect
to a server using a revoked cert. Both these cases also need dns or IP
spoofing as you do not allow --remote  to be modified by the user. Unless
admins start misusing crl as an easy way of disabling a remote (among
multiple remotes) listed in <connection> .. </connection>

Selva

--001a11443d9e76113c0526cc5c7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">forgot to copy the list..<br><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr"><div class=3D"gmail_extra">Hi=
,<br><br></div><div class=3D"gmail_extra">Sorry, I missed the point that on=
ly referenced files are being replaced.<br>=C2=A0<br></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><span>On Sat, Dec 12, 2015 at 9:31 PM=
, Jonathan K. Bullard <span dir=3D"ltr">&lt;<a href=3D"mailto:jkbullard@...493...=
277..." target=3D"_blank">jkbullard@...277...</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"overflow:hidden=
">I&#39;m not clear at all about --crl-verify. Would it ever be used in a<b=
r>
client? Would there be a security risk if a client erased the contents<br>
of the file? (Would that allow a client to connect to a server that<br>
has a revoked certificate which would otherwise not be allowed?</div></bloc=
kquote><div><br></div></span><div>The risk appears to be even less than tha=
t of the user replacing ca <br>(i.e very minor). With a new ca, the user ca=
n connect to a server presenting <br>a cert from that ca. With crl replaced=
 or removed,=C2=A0 the client can connect <br>to a server using a revoked c=
ert. Both these cases also need dns or IP <br>spoofing as you do not allow =
--remote=C2=A0 to be modified by the user. Unless <br>admins start misusing=
 crl as an easy way of disabling a remote (among <br>multiple remotes) list=
ed in &lt;connection&gt; .. &lt;/connection&gt;<span><font color=3D"#888888=
"><br></font></span></div><span><font color=3D"#888888"><div><br></div><div=
 id=3D":21t" class=3D"" style=3D"overflow:hidden">Selva <br>
<span class=3D""></span></div></font></span></div></div></div></div></div><=
/div>

--001a11443d9e76113c0526cc5c7b--

