MIME-Version: 1.0
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
 <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
In-Reply-To: <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 30 Oct 2025 12:56:35 -0400
Message-ID: <CAKuzo_gpF7Tzx85O023M-sMqA7VJ0RZYvMnmEPDPccK3+gNfBQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000b7d632064263222d"
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: lstipakov@...277..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--000000000000b7d632064263222d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:12=E2=80=AFAM stipa (Code Review) <gerrit@...2146...=
...>
wrote:

> Attention is currently required from: flichtenheld, plaisthos.
>
> stipa *uploaded patch set #2* to this change.
>
> View Change <http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail>
>
> openvpnserv: validate openvpn-gui process path
>
> Ensure that the service pipe client process (which is openvpn-gui)
> is from openvpn binary directory, defined in registry. This limits
> unauthorized connections to the service pipe.
>
> Reported-by: Abdul Mhanni <abdul.mhanni@...2951...>
>
>
Do we really want to do this? I thought allowing any user process to use
the interactive service was deliberate: the only restriction being user
whitelisted as "OpenVPNAdministrators" or else we allow only a limited set
of config directives.

Currently, starting openvpn.exe through the service using a script or a
custom application works. Without having to install it in the "OpenVPN/bin"
directory. Do we want to take away that functionality? The threat being
addressed here is unclear to me.

Selva

--000000000000b7d632064263222d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 10:12=E2=80=AFAM stipa (Code Review) &lt;<a href=3D"mailto:gerrit@=
...515...">gerrit@...515...</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><u></u><div><p> Attention is currently required =
from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail" target=3D"_bl=
ank">View Change</a></p><pre style=3D"font-family:monospace,monospace;white=
-space:pre-wrap">openvpnserv: validate openvpn-gui process path<br><br>Ensu=
re that the service pipe client process (which is openvpn-gui)<br>is from o=
penvpn binary directory, defined in registry. This limits<br>unauthorized c=
onnections to the service pipe.<br><br>Reported-by: Abdul Mhanni &lt;<a hre=
f=3D"mailto:abdul.mhanni@...2951..." target=3D"_blank">abdul.mhanni@...2952...=
...</a>&gt;<br></pre></div></blockquote><div><br></div><div>Do we really wa=
nt to do this? I thought allowing any user process to use the interactive s=
ervice was deliberate: the only restriction being user whitelisted as &quot=
;OpenVPNAdministrators&quot; or else we allow only a limited set of config =
directives.=C2=A0<br><br>Currently, starting openvpn.exe through the servic=
e using a script or a custom=C2=A0application works. Without having to inst=
all it in the &quot;OpenVPN/bin&quot; directory. Do we want to take away th=
at functionality? The threat being addressed here is unclear=C2=A0to me.</d=
iv><div><br></div><div>Selva<br></div></div></div>

--000000000000b7d632064263222d--

