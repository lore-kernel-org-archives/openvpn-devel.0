MIME-Version: 1.0
In-Reply-To: <1472233732-27074-1-git-send-email-davids@...515...>
References: <1470684488-21307-2-git-send-email-davids@...515...>
	<1472233732-27074-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 26 Aug 2016 20:59:48 -0400
Message-ID: <CAKuzo_gb9dVOH94JvsTLyDY+mW7HLUWF-k+7ugfuh3_ZU20rWQ@...278...>
Content-Type: multipart/alternative; boundary=94eb2c124e34fa9bb0053b03261f
Subject: Re: [Openvpn-devel] [PATCH v4.1 1/4] Rework the user input
 interface to make it more modular
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c124e34fa9bb0053b03261f
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 26, 2016 at 1:48 PM, David Sommerseth <davids@...515...>
wrote:

> This is will provide an interface for other mechanisms to be used to
> query the user for information, such as usernames, passwords, etc.
>
> It has also been a goal to make it possible to query for all the
> information in one call and not do it sequencially as before.
>
>  [v5 - Ensure password prompt is only displayed if we should read
>        from stdin ]
>
>  [v4 - add a simple wrapper combining query_user_{init,add,exec}()
>      - change disapproved &= syntax ]
>
>  [v3 - Avoid the dynamic list, use a static list of QUERY_USER_NUMSLOTS
>      - The list of query_user data is now a global variable
>      - Replaced query_user_init() with query_user_clear()
>      - Make query_user_add() a void function
>      - Rebased against master/600dd9a16fc61 ]
>
>  [v2 - Removed the QUERY_USER_FOREACH macro
>      - Avoided using underscore prefix in function names
>      - Make query_user_init() do M_FATAL and become a void function
>        instead of returning false in these unlikely situations ]
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/Makefile.am       |   2 +-
>  src/openvpn/console.c         | 228 +++++-------------------------------
>  src/openvpn/console.h         |  89 +++++++++++++-
>  src/openvpn/console_builtin.c | 261 ++++++++++++++++++++++++++++++
> ++++++++++++
>  src/openvpn/misc.c            |  61 +++++++---
>  src/openvpn/pkcs11.c          |   7 +-
>  6 files changed, 423 insertions(+), 225 deletions(-)



v5 looks good.
ACK (only for git-master).

I still think username, password and static challenge should be combined
into one query_user_exec() call but no need to hold this back for that.

Selva

--94eb2c124e34fa9bb0053b03261f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 26, 2016 at 1:48 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span>This is will provide=
 an interface for other mechanisms to be used to<br>
query the user for information, such as usernames, passwords, etc.<br>
<br>
It has also been a goal to make it possible to query for all the<br>
information in one call and not do it sequencially as before.<br>
<br>
</span>=C2=A0[v5 - Ensure password prompt is only displayed if we should re=
ad<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0from stdin ]<br>
<span><br>
=C2=A0[v4 - add a simple wrapper combining query_user_{init,add,exec}()<br>
=C2=A0 =C2=A0 =C2=A0- change disapproved &amp;=3D syntax ]<br>
<br>
=C2=A0[v3 - Avoid the dynamic list, use a static list of QUERY_USER_NUMSLOT=
S<br>
=C2=A0 =C2=A0 =C2=A0- The list of query_user data is now a global variable<=
br>
=C2=A0 =C2=A0 =C2=A0- Replaced query_user_init() with query_user_clear()<br>
=C2=A0 =C2=A0 =C2=A0- Make query_user_add() a void function<br>
=C2=A0 =C2=A0 =C2=A0- Rebased against master/600dd9a16fc61 ]<br>
<br>
=C2=A0[v2 - Removed the QUERY_USER_FOREACH macro<br>
=C2=A0 =C2=A0 =C2=A0- Avoided using underscore prefix in function names<br>
=C2=A0 =C2=A0 =C2=A0- Make query_user_init() do M_FATAL and become a void f=
unction<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0instead of returning false in these unlikely sit=
uations ]<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." tar=
get=3D"_blank">davids@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<=
br>
=C2=A0src/openvpn/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 228 +++++---=
----------------------<wbr>------<br>
=C2=A0src/openvpn/console.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 89 +++=
++++++++++-<br>
=C2=A0src/openvpn/console_builtin.c | 261 ++++++++++++++++++++++++++++++<wb=
r>++++++++++++<br>
</span>=C2=A0src/openvpn/misc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 61 +++++++---<br>
=C2=A0src/openvpn/pkcs11.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
7 +-<br>
=C2=A06 files changed, 423 insertions(+), 225 deletions(-)</blockquote></di=
v><br><br></div><div class=3D"gmail_extra">v5 looks good.<br>ACK (only for =
git-master).<br><br></div><div class=3D"gmail_extra">I still think username=
, password and static challenge should be combined into one query_user_exec=
() call but no need to hold this back for that.<br><br></div><div class=3D"=
gmail_extra">Selva<br></div></div>

--94eb2c124e34fa9bb0053b03261f--

