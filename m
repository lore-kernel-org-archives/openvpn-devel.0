MIME-Version: 1.0
In-Reply-To: <56C32BCD.1050407@...515...>
References: <56C32BCD.1050407@...515...>
From: Jason Haar <jason_haar@...1490...>
Date: Wed, 17 Feb 2016 22:43:53 +1300
Message-ID: <CAFChrgL43Fr_1GSYc6qryC8eVncdSURKJJu-oMPWrtYcNf2wjw@...278...>
Content-Type: multipart/alternative; boundary=001a11444612b3d20a052bf417ca
Subject: Re: [Openvpn-devel] Handling bitness (32/64) for OpenVPN Windows
	installers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11444612b3d20a052bf417ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 3:01 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> 1) Combine 32-bit and 64-bit installers into one
>
> Is there a use-case for installing 32-bit OpenVPN on a 64-bit system?
> If not, we could combine both 32-bit and 64-bit binaries into a single
> installers and, at install time, select the correct ones to install.
> This would increase installer size from ~1.8MB to ~3.3MB.
>


3.3M? Umm, what year is this? :-)

I'd say put them both into the installer and auto-install the appropriate
one. If it was 18M vs 36M you might want to be more finer grained - but <2M
difference? It's not worth thinking about.

Ditching WinXP is definitely the right thing to do. People shouldn't be
running security software on dead OSes. They will do it poorly. Just sayin'

--=20
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1

--001a11444612b3d20a052bf417ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 17, 2016 at 3:01 AM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt=
;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2ra" class=
=3D"a3s" style=3D"overflow:hidden">1) Combine 32-bit and 64-bit installers =
into one<br>
<br>
Is there a use-case for installing 32-bit OpenVPN on a 64-bit system?<br>
If not, we could combine both 32-bit and 64-bit binaries into a single<br>
installers and, at install time, select the correct ones to install.<br>
This would increase installer size from ~1.8MB to ~3.3MB.</div></blockquote=
></div><br><br>3.3M? Umm, what year is this? :-)</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">I&#39;d say put them both into t=
he installer and auto-install the appropriate one. If it was 18M vs 36M you=
 might want to be more finer grained - but &lt;2M difference? It&#39;s not =
worth thinking about.=C2=A0</div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra">Ditching WinXP is definitely the right thing to do. P=
eople shouldn&#39;t be running security software on dead OSes. They will do=
 it poorly. Just sayin&#39;<br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div>Cheers</div><div><br></div><di=
v>Jason Haar</div><div>Information Security Manager, Trimble Navigation Ltd=
.</div><div>Phone: +1 408 481 8171</div><div>PGP Fingerprint: 7A2E 0407 C9A=
6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1</div></div></div>
</div></div>

--001a11444612b3d20a052bf417ca--

