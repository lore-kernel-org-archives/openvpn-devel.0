MIME-Version: 1.0
References: <20221010071229.7935-1-gert@...1296...>
In-Reply-To: <20221010071229.7935-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 18 Oct 2022 19:01:20 -0400
Message-ID: <CAKuzo_jMWxigVoqxJNHdx+yfn2CBHamECs3Fq3QFsNpSJ9jK_g@...278...>
Content-Type: multipart/alternative; boundary="000000000000dd1d0f05eb571a35"
Subject: Re: [Openvpn-devel] [PATCH] TLS: do not lock empty usernames
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

--000000000000dd1d0f05eb571a35
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Oct 10, 2022 at 3:14 AM Gert Doering <gert@...1296...> wrote:

> We do not permit username changes on renegotiation (= username is
> "locked" after successful initial authentication).
>
> Unfortunately the way this is written this gets in the way of using
> auth-user-pass-optional + pushing "auth-token-user" from client-connect
> (and most likely also "from management") because we'll lock an empty
> username, and on renegotiation, refuse the client with
>

Why is it not okay to support change of username?. I have a situation
where username change looks legitimate:

With our new PLAP (start from login screen) and "persistent connection"
support on Windows,
a connection may be started by one user and then "renegotiated" by another
who may enter
a different username and password from the initial connection (say
auth-nocache or 2FA
is in use).

In this case, the server will disable the tunnel (username tried to
change), the client will retry
asking the user for username/password input again. On inputting the same
credentials a
second time, the connection will succeed. This leads to poor UX.

If we can conjure up usernames (like with empty --> token-user) why not
allow other username
changes too?

Selva

--000000000000dd1d0f05eb571a35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Oct 10, 2022 at 3:14 AM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We do no=
t permit username changes on renegotiation (=3D username is<br>
&quot;locked&quot; after successful initial authentication).<br>
<br>
Unfortunately the way this is written this gets in the way of using<br>
auth-user-pass-optional + pushing &quot;auth-token-user&quot; from client-c=
onnect<br>
(and most likely also &quot;from management&quot;) because we&#39;ll lock a=
n empty<br>
username, and on renegotiation, refuse the client with<br></blockquote><div=
><br></div><div>Why is it not okay to support change of username?. I have a=
 situation</div><div>where username change looks legitimate:</div><div><br>=
</div><div>With our new PLAP (start from login screen) and &quot;persistent=
 connection&quot; support on Windows,</div><div>a connection=C2=A0may be st=
arted by one user and then &quot;renegotiated&quot; by another who may ente=
r</div><div>a different username and password from the initial=C2=A0connect=
ion=C2=A0(say auth-nocache or 2FA</div><div>is in use).=C2=A0</div><div><br=
></div><div>In this case, the server will disable the tunnel (username trie=
d to change), the client will retry</div><div>asking the user for username/=
password input again. On inputting the same credentials a</div><div>second =
time, the connection will succeed. This leads to poor UX.</div><div><br></d=
iv><div>If we can conjure up usernames (like with empty --&gt; token-user) =
why not allow other username</div><div>changes=C2=A0too?</div><div><br></di=
v><div>Selva</div></div></div>

--000000000000dd1d0f05eb571a35--

