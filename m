MIME-Version: 1.0
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-6-a@...2181...>
In-Reply-To: <20220812130657.29899-6-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 12 Aug 2022 19:59:30 +0300
Message-ID: <CAGyAFMUwZcfmQB6KKCw8zA2XWtd64cPvcmN_ZDJi_55J4MDR_A@...278...>
Content-Type: multipart/alternative; boundary="0000000000004bc85e05e60e353a"
Subject: Re: [Openvpn-devel] [PATCH v100 05/10] dco-win: add documentation
 to README.dco.md
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000004bc85e05e60e353a
Content-Type: text/plain; charset="UTF-8"

Hi,

+Getting started (Windows)
> +-------------------------
> +Getting started under windows is currently for brave people having
> experience
> +with windows development. You need to compile openvpn yourself and also
> need
> +to get the test driver installed on your system.
>

While I consider building openvpn and installing test-signed drivers as
common knowledge,
this is not necessarily needed to try out dco-win.

We have GHA-based automation which builds openvpn, builds MSI installers for
x86/x64/arm64 and uploads those to build.openvpn.net.

So to try out dco-win, one just needs to get installation package from

https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/

-Lev

--0000000000004bc85e05e60e353a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+Getting started (Windows)<br>
+-------------------------<br>
+Getting started under windows is currently for brave people having experie=
nce<br>
+with windows development. You need to compile openvpn yourself and also ne=
ed<br>
+to get the test driver installed on your system.<br></blockquote><div><br>=
</div><div>While I consider building openvpn and installing test-signed dri=
vers as common knowledge,</div><div>this is not necessarily=C2=A0needed to =
try out dco-win.</div><div><br></div><div>We have GHA-based automation whic=
h builds openvpn, builds MSI installers for</div><div>x86/x64/arm64 and upl=
oads those to <a href=3D"http://build.openvpn.net">build.openvpn.net</a>.</=
div><div><br></div><div>So to try out dco-win, one just needs to get instal=
lation package from=C2=A0 =C2=A0</div><div><br></div><div><a href=3D"https:=
//build.openvpn.net/downloads/snapshots/github-actions/openvpn2/">https://b=
uild.openvpn.net/downloads/snapshots/github-actions/openvpn2/</a></div><div=
><br></div><div>-Lev</div></div></div>

--0000000000004bc85e05e60e353a--

