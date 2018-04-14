Resent-Message-ID: <20180425061259.GO69387@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
In-Reply-To: <20180414072617.25075-1-gert@...1296...>
References: <CAKuzo_jtPA4=NMeER1YwjRwGkq3NG39aqxHN3NCPGY+3KkAHpg@...278...>
 <20180414072617.25075-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 14 Apr 2018 12:44:57 -0400
Message-ID: <CAKuzo_h-GusttjiFUeV2tivFAKHFdqTnDseg9KiVru5ftWszyg@...278...>
Content-Type: multipart/alternative; boundary="000000000000b571d50569d1b62b"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix potential double-free() in
 Interactive Service (CVE-2018-9336)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: security@...515..., jbaines@...2391...

--000000000000b571d50569d1b62b
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 14, 2018 at 3:26 AM, Gert Doering <gert@...1296...> wrote:

> Malformed input data on the service pipe towards the OpenVPN interactive
> service (normally used by the OpenVPN GUI to request openvpn instances
> from the service) can result in a double free() in the error handling code.
>
> This usually only leads to a process crash (DoS by an unprivileged local
> account) but since it could possibly lead to memory corruption if
> happening while multiple other threads are active at the same time,
> CVE-2018-9336 has been assigned to acknowledge this risk.
>
> Fix by ensuring that sud->directory is set to NULL in GetStartUpData()
> for all error cases (thus not being free()ed in FreeStartupData()).
>
> Rewrite control flow to use explicit error label for error exit.
>
> Discovered and reported by Jacob Baines <jbaines@...2391...>.
>
> CVE: 2018-9336
>
> Signed-off-by: Gert Doering <gert@...1296...>
>
> --
> v2: reword commit message, no code changes


Just for completeness: all good so ACK again.

Selva

--000000000000b571d50569d1b62b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On S=
at, Apr 14, 2018 at 3:26 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"=
mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Malformed input data on the service =
pipe towards the OpenVPN interactive<br>
service (normally used by the OpenVPN GUI to request openvpn instances<br>
from the service) can result in a double free() in the error handling code.=
<br>
<br>
This usually only leads to a process crash (DoS by an unprivileged local<br>
account) but since it could possibly lead to memory corruption if<br>
happening while multiple other threads are active at the same time,<br>
CVE-2018-9336 has been assigned to acknowledge this risk.<br>
<br>
Fix by ensuring that sud-&gt;directory is set to NULL in GetStartUpData()<b=
r>
for all error cases (thus not being free()ed in FreeStartupData()).<br>
<br>
Rewrite control flow to use explicit error label for error exit.<br>
<br>
Discovered and reported by Jacob Baines &lt;<a href=3D"mailto:jbaines@...2392...=
91...">jbaines@...2391...</a>&gt;.<br>
<br>
CVE: 2018-9336<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...493...=
1296...</a>&gt;<br>
<br>
--<br>
v2: reword commit message, no code changes</blockquote><div><br></div><div>=
Just for completeness: all good so ACK again.=C2=A0</div><div><br></div><di=
v>Selva</div></div></div></div>

--000000000000b571d50569d1b62b--


