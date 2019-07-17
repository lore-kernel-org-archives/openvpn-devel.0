MIME-Version: 1.0
References: <CAGyAFMUgS+WaDf5Xx8S-jX3MbAu4QT7_Ln86JDtmZEaV2PPLcA@...278...>
 <1561637226-18464-1-git-send-email-lstipakov@...277...>
 <CAKuzo_jqHYt-xbwkTG59DEbEpNKT7GPtWE8T6t-Jiwv0CiyhOQ@...278...>
In-Reply-To: <CAKuzo_jqHYt-xbwkTG59DEbEpNKT7GPtWE8T6t-Jiwv0CiyhOQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 17 Jul 2019 15:19:53 +0300
Message-ID: <CAGyAFMUDx_eD4Yk9TtvWKDXNnpLg55-0tZT0zL6T61zDALTTvw@...278...>
Content-Type: multipart/alternative; boundary="00000000000059d138058ddf8342"
Subject: Re: [Openvpn-devel] [PATCH v3] openvpnserv: enable interactive
 service to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000059d138058ddf8342
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for delay - I was on vacation.

(i) The new message is named message_open_tun, but it allows opening
> any file using the service. This is not secure.


I am thinking of possible vector of attack here.

In our case it is service which launches openvpn process using
path set in registry, opens pipe and passes pipe handle to launched process.

To make service run malicious process one needs either to replace
executable or
modify registry. For both actions you need to be administrator, assuming
default security policy.

Alternatively, can random process hijack the pipe handle from another
process?


> We need to restrict it to open tun/tap device nodes only.
>

Without adding too much code, I can think of:

 - check that path starts with \\\\.\\Global\\ to make sure we open device,
not file

and

 - check that path starts with \\\\.\\Global\\WINTUN or ends with .tap

Is this good enough or do you have better ideas?

(ii) Should we allow all users to open tap6 adapters irrespective of
> any other access restrictions that may be present? I'm conflicted
> about this as, on closer look, access control in tap-windows6 appears
> broken.
>

I'll pass on this one. Maybe "Strengthening access control for
tap-windows6" could be another patch.


> Defining this struct with error_number followed by handle would be
> better (makes its head match in memory with ack_message_t). That makes
> it possible to read a normal ack into it and resolve the error number.
>

Agreed, will do.

-- 
-Lev

--00000000000059d138058ddf8342
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Sorry for delay - =
I was on vacation.</div><div><br></div></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
(i) The new message is named message_open_tun, but it allows opening<br>
any file using the service. This is not secure. </blockquote><div><br></div=
><div>I am thinking of possible vector of attack here.</div><div><br></div>=
<div>In our case it is service which launches openvpn process using</div><d=
iv>path set in registry, opens pipe and passes pipe handle to launched proc=
ess.</div><div><br></div><div>To make service run malicious process one nee=
ds either to replace executable or</div><div>modify registry. For both acti=
ons you need to be administrator, assuming default security policy.</div><d=
iv><br></div><div>Alternatively, can random process hijack the pipe handle =
from another process?</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">We need to restrict it to open tun/tap device nodes only=
.<br></blockquote><div><br></div><div>Without adding too much code, I can t=
hink of:</div><div><br></div><div>=C2=A0- check that path starts with=C2=A0=
\\\\.\\Global\\ to make sure we open device, not file</div><div><br></div><=
div>and</div><div>=C2=A0</div><div>=C2=A0- check that path starts with=C2=
=A0\\\\.\\Global\\WINTUN or ends with .tap</div><div><br></div><div>Is this=
 good enough or do you have better ideas?</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
(ii) Should we allow all users to open tap6 adapters irrespective of<br>
any other access restrictions that may be present? I&#39;m conflicted<br>
about this as, on closer look, access control in tap-windows6 appears<br>
broken.<br></blockquote><div><br></div><div>I&#39;ll pass on this one. Mayb=
e &quot;Strengthening access control for tap-windows6&quot; could be anothe=
r patch.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
Defining this struct with error_number followed by handle would be<br>
better (makes its head match in memory with ack_message_t). That makes<br>
it possible to read a normal ack into it and resolve the error number.<br><=
/blockquote><div><br></div><div>Agreed, will do.=C2=A0</div></div><div><br>=
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--00000000000059d138058ddf8342--

