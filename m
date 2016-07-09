MIME-Version: 1.0
In-Reply-To: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 9 Jul 2016 15:11:53 -0400
Message-ID: <CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
Content-Type: multipart/alternative; boundary=001a114f6a24555f86053738b2d7
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Noel Kuntze <noel@...2150...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114f6a24555f86053738b2d7
Content-Type: text/plain; charset=UTF-8

On Sat, Jul 9, 2016 at 12:16 PM, Noel Kuntze <noel@...2150...> wrote:

> The changed source code compiles successfully, however I do not know if
> the behaviour is correct, as I do not have a code signing certificate or EV
> certificate
>
> that I could sign the driver with.
>

You can test it with a test signature on a machine booted with TESTSIGNING
boot config option:

bcdedit.exe -set TESTSIGNING ON

For more info see
https://msdn.microsoft.com/en-ca/library/windows/hardware/ff553484(v=vs.85).aspx

Selva

--001a114f6a24555f86053738b2d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jul 9, 2016 at 12:16 PM, Noel Kuntze <span dir=3D"ltr">&lt;<a href=
=3D"mailto:noel@...2150..." target=3D"_blank">noel@...2150...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>The chan=
ged source code compiles successfully, however I do not know if the behavio=
ur is correct, as I do not have a code signing certificate or EV certificat=
e<br>
<br>
that I could sign the driver with.</div></blockquote></div><br></div><div c=
lass=3D"gmail_extra">You can test it with a test signature on a machine boo=
ted with TESTSIGNING boot config option:<br><br>bcdedit.exe -set TESTSIGNIN=
G ON<br><br></div><div class=3D"gmail_extra">For more info see <a href=3D"h=
ttps://msdn.microsoft.com/en-ca/library/windows/hardware/ff553484(v=3Dvs.85=
).aspx" target=3D"_blank">https://msdn.microsoft.com/en-ca/library/windows/=
hardware/ff553484(v=3Dvs.85).aspx</a><br><br></div><div class=3D"gmail_extr=
a">Selva<br></div></div>

--001a114f6a24555f86053738b2d7--

