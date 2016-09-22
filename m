MIME-Version: 1.0
In-Reply-To: <1474538677-23301-1-git-send-email-davids@...515...>
References: <1474538677-23301-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Sep 2016 12:43:10 -0400
Message-ID: <CAKuzo_j+FjOCOHMBw5ca1KTPX7AoFwOPkdTRKhLh9yktmFRCwQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12299c99c7d4053d1b5c76
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c12299c99c7d4053d1b5c76
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Sep 22, 2016 at 6:04 AM, David Sommerseth <davids@...515...>
wrote:

> If running an OpenVPN client with --enable-pkcs11 and a server without
> and having a username and/or password with more than 128 characters,
> the authentication will fail as the server truncates the password
> to 128 bytes.
>
> This makes things easier and more predictable.  Username/passwords
> can be up to 4096 bytes, regardless of the --enable-pkcs11 state.
>

In spite of this change, in most usage scenarios, username, password and
even pkcs11-id are limited to a much smaller length (more like ~256 bytes)
for other reasons:

The pkcs11-id is the only string that probably needs such a long length,
but its limited to ~240 bytes when read from the config file because of max
line length of 256 bytes + 1 for NUL (in some code paths 255?). Even if the
max line length is increased, the max size of an option parameter is 256
bytes (+ 1 for NUL).

The 256 byte limit on parameters in response received from management
(pointed out by Jonathan) is also somewhat related to the above: Input from
management goes through the same parsing code as the lines read from the
config file for handling escapes, embedded whitespace etc. and a limit of
256 bytes per option parameter is imposed

Also usernames > 64 bytes will break --username-as-common-name as CN is
limited to 64 bytes (could 64 code points, but it seems openvpn interprets
that as 64 bytes).

So for most practical purposes, pkcs11-id appears to be limited to ~240
bytes characters in the current code. Changing USER_PASS_LEN to, say, 256
may be more sensible. That shouldn't break any existing configs but may
break some use cases where a long id is supplied from the command line.

Selva

--94eb2c12299c99c7d4053d1b5c76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Sep 22, 2016 at 6:04 AM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." target=
=3D"_blank">davids@...515...</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div>If running an OpenVPN client with --enable-pkcs11 and a serv=
er without<br>
and having a username and/or password with more than 128 characters,<br>
the authentication will fail as the server truncates the password<br>
to 128 bytes.<br>
<br>
This makes things easier and more predictable.=C2=A0 Username/passwords<br>
can be up to 4096 bytes, regardless of the --enable-pkcs11 state.</div></bl=
ockquote></div></div><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra">In spite of this change, in most usage scenarios, username, passw=
ord and even pkcs11-id are limited to a much smaller length (more like ~256=
 bytes) for other reasons:</div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra">The pkcs11-id is the only string that probably needs s=
uch a long length, but its limited to ~240 bytes when read from the config =
file because of max line length of 256 bytes + 1 for NUL (in some code path=
s 255?). Even if the max line length is increased, the max size of an optio=
n parameter is 256 bytes (+ 1 for NUL).</div><div class=3D"gmail_extra"><br=
></div><div class=3D"gmail_extra">The 256 byte limit on parameters in respo=
nse received from management (pointed out by Jonathan) is also somewhat rel=
ated to the above: Input from management goes through the same parsing code=
 as the lines read from the config file for handling escapes, embedded whit=
espace etc. and a limit of 256 bytes per option parameter is imposed</div><=
div class=3D"gmail_extra">=C2=A0=C2=A0</div><div class=3D"gmail_extra">Also=
 usernames &gt; 64 bytes will break --username-as-common-name as CN is limi=
ted to 64 bytes (could 64 code points, but it seems openvpn interprets that=
 as 64 bytes).</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">So for most practical purposes, pkcs11-id appears to be limited to=
 ~240 bytes characters in the current code. Changing USER_PASS_LEN to, say,=
 256 may be more sensible. That shouldn&#39;t break any existing configs bu=
t may break some use cases where a long id is supplied from the command lin=
e.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Sel=
va</div></div>

--94eb2c12299c99c7d4053d1b5c76--

