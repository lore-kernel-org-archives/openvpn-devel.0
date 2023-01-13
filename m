MIME-Version: 1.0
References: <20230111160848.22906-1-gert@...1296...>
In-Reply-To: <20230111160848.22906-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Jan 2023 14:15:27 -0500
Message-ID: <CAKuzo_h-U3sryJ23Qa7-M-+uzSjBQZJ=Nc0bWxNWCWiWKhrdYQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000005e135b05f22a0f97"
Subject: Re: [Openvpn-devel] [PATCH] Repair special-casing of EEXIST for
 Linux/SITNL route install
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--0000000000005e135b05f22a0f97
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 11, 2023 at 11:38 AM Gert Doering <gert@...1296...> wrote:

> The code in sitnl_route_set() used to treat "route can not be installed
> because it already exists" (EEXIST) as "not an error".
>
> This is arguably a reasonable approach, but needs to handled higher
> up - if the low level add_route() function say "no error", we will try
> to remove that route later on in delete_route(), possibly removing
> someone else's "already existing" route then.
>

Found one more case of route addition flag not correctly recorded --
RL_DID_LOCAL  used for the direct route to the server. I will wait
for the final shape and form of this one before sending a patch.

Selva

--0000000000005e135b05f22a0f97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 11, 2023 at 11:38 AM Gert Doe=
ring &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">The code in sitn=
l_route_set() used to treat &quot;route can not be installed<br>
because it already exists&quot; (EEXIST) as &quot;not an error&quot;.<br>
<br>
This is arguably a reasonable approach, but needs to handled higher<br>
up - if the low level add_route() function say &quot;no error&quot;, we wil=
l try<br>
to remove that route later on in delete_route(), possibly removing<br>
someone else&#39;s &quot;already existing&quot; route then.<br></blockquote=
><div><br></div><div>Found one more case of route addition flag not correct=
ly recorded --=C2=A0</div><div>RL_DID_LOCAL=C2=A0 used for the direct route=
 to the server. I will wait</div><div>for the final shape and form of this =
one before sending a patch.</div><div><br></div><div>Selva=C2=A0</div></div=
></div>

--0000000000005e135b05f22a0f97--

