MIME-Version: 1.0
References: <20221019224642.11178-1-selva.nair@...277...>
 <Y1kr4zYWRP29K2G2@...1296...>
In-Reply-To: <Y1kr4zYWRP29K2G2@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 26 Oct 2022 10:18:19 -0400
Message-ID: <CAKuzo_iRT5SHQUq2jMnBsY6W+wmpVGS2y9d+saVX4dT7D=udiQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000003bcf8405ebf0b381"
Subject: Re: [Openvpn-devel] [PATCH for 2.5/2.6] Purge auth-token as well
 while purging passwords
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

--0000000000003bcf8405ebf0b381
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the detailed analysis!

On Wed, Oct 26, 2022 at 8:45 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Oct 19, 2022 at 06:46:42PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Starting from commit e61b401a auth-token is saved in a separate struct
> > from auth-user-pass and is not cleared when ssl_purge_auth() is called.
> > This makes "forget-passwords" sent to the management
> > interface or "--management-forget-disconnect" option not to work
> > as expected.
>
> I am not sure I can go along with Arne's ACK here - the reason is that
> ssl_purge_auth() is not only called from man_forget_passwords() (where
> I'm totally fine with the change) but also on received EEN from the
> server ("RESTART"), and this patch changes behaviour here.
>
> Without patch:
>
>  - server pushes token (secret-based --auth-gen-token)
>  - server is ctrl-c'ed by admin, sends RESTART
>  - client calls server_pushed_signal() -> ssl_purge_auth()
>      forgets username + password, but not token
>  - server is restarted, same token secret
>  - client reconnects, sends token, is allowed in
>
> With patch:
>
>  - server pushes token (secret-based --auth-gen-token)
>  - server is ctrl-c'ed by admin, sends RESTART
>  - client calls server_pushed_signal() -> ssl_purge_auth()
>      forgets username + password, but not token
>  - server is restarted, same token secret
>  - client reconnects...
>
>         2022-10-26 14:38:58 SIGUSR1[soft,server-pushed-connection-reset]
> received, process restarting
>         2022-10-26 14:38:58 Restart pause, 5 second(s)
>         ...
>         Enter Auth Username:
>
>    ... and asks for a username.
>
> I think this is not what this patch is expected to do, and would irk
> a lot of my 2FA users (that are currently happy that I can restart the
> openvpn server without them all having to do 2FA again).
>

I think the intent of the original code is to purge all credentials by
default in case of RESTART ---  [RESTART,P] was required to preserve
credentials as you note below. But somehow we did not keep that behaviour
when auth-token was introduced.

But, I agree it may be useful to preserve the token in this case, though it
will fail if restart moves to the next server, isn't it?


> There is a theoretical way to avoid this (server needs to send RESTART,P),
> but the --explicit-exit-notify code on the server has no way to trigger
> this, so it's not helping.
>
> This also affects --management-forget-disconnect (obscure option of
> the day), which, I think, should not forget tokens either - but I do
> not have a strong opinion here.  I think OpenVPN should retain tokens
> on disconnect due to "network change" or whatever, but then, I have
> no idea when we'd want to use this option in the first place.
>

IMO, management-forget-disconnect should forget the token along with
passwords. The patch is meant to address this option and
"forget-passwords". The use case: if you stop the tunnel and put the
connection on management-hold and then detach from the management
interface, another user connecting to it would be able to connect to it
without entering a password. --management-forget-disconnect can protect
against this.


> The two other places where this is called (SIGUSR1 AUTH FAIL with
> "auth-retry interact" and man_forget_passwords() should be fine with
> forgetting tokens - I think "AUTH FAIL" already does this (in some
> other code path).
>
>
> I agree with the intent on the patch (Feature-ACK), and would suggest
> to call "ssl_clean_auth_token()" directly from "man_forget_passwords()"
> instead.  This will catch your (valid) use-case without impacting
> other users of ssl_purge_auth().
>

I'm okay with this. Will send an amended patch.

Selva

--0000000000003bcf8405ebf0b381
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the det=
ailed analysis!</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 26, 2022 at 8:45 AM Gert Doering &lt;<a hr=
ef=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Oct 19, 2022 at 06:46:42PM -0400, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Starting from commit e61b401a auth-token is saved in a separate struct=
<br>
&gt; from auth-user-pass and is not cleared when ssl_purge_auth() is called=
.<br>
&gt; This makes &quot;forget-passwords&quot; sent to the management<br>
&gt; interface or &quot;--management-forget-disconnect&quot; option not to =
work<br>
&gt; as expected.<br>
<br>
I am not sure I can go along with Arne&#39;s ACK here - the reason is that<=
br>
ssl_purge_auth() is not only called from man_forget_passwords() (where<br>
I&#39;m totally fine with the change) but also on received EEN from the<br>
server (&quot;RESTART&quot;), and this patch changes behaviour here.<br>
<br>
Without patch:<br>
<br>
=C2=A0- server pushes token (secret-based --auth-gen-token)<br>
=C2=A0- server is ctrl-c&#39;ed by admin, sends RESTART<br>
=C2=A0- client calls server_pushed_signal() -&gt; ssl_purge_auth()<br>
=C2=A0 =C2=A0 =C2=A0forgets username + password, but not token<br>
=C2=A0- server is restarted, same token secret<br>
=C2=A0- client reconnects, sends token, is allowed in<br>
<br>
With patch:<br>
<br>
=C2=A0- server pushes token (secret-based --auth-gen-token)<br>
=C2=A0- server is ctrl-c&#39;ed by admin, sends RESTART<br>
=C2=A0- client calls server_pushed_signal() -&gt; ssl_purge_auth()<br>
=C2=A0 =C2=A0 =C2=A0forgets username + password, but not token<br>
=C2=A0- server is restarted, same token secret<br>
=C2=A0- client reconnects...<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2022-10-26 14:38:58 SIGUSR1[soft,server-pushed-=
connection-reset] received, process restarting<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2022-10-26 14:38:58 Restart pause, 5 second(s)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Enter Auth Username:<br>
<br>
=C2=A0 =C2=A0... and asks for a username.<br>
<br>
I think this is not what this patch is expected to do, and would irk<br>
a lot of my 2FA users (that are currently happy that I can restart the<br>
openvpn server without them all having to do 2FA again).<br></blockquote><d=
iv><br></div><div>I think the intent of the original code is to purge all c=
redentials by default in case of RESTART=C2=A0---=C2=A0 [RESTART,P] was req=
uired to preserve credentials as you note below. But somehow we did not kee=
p that behaviour when auth-token was introduced.</div><div><br></div><div>B=
ut, I agree it may be useful to preserve the token in this case, though it =
will fail if restart moves to the next server, isn&#39;t it?</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
There is a theoretical way to avoid this (server needs to send RESTART,P),<=
br>
but the --explicit-exit-notify code on the server has no way to trigger<br>
this, so it&#39;s not helping.<br>
<br>
This also affects --management-forget-disconnect (obscure option of<br>
the day), which, I think, should not forget tokens either - but I do<br>
not have a strong opinion here.=C2=A0 I think OpenVPN should retain tokens<=
br>
on disconnect due to &quot;network change&quot; or whatever, but then, I ha=
ve<br>
no idea when we&#39;d want to use this option in the first place.<br></bloc=
kquote><div><br></div><div>IMO, management-forget-disconnect should forget =
the token along with passwords. The patch is meant to address this option a=
nd &quot;forget-passwords&quot;. The use case: if you stop the tunnel and p=
ut the connection on management-hold and then detach from the management in=
terface, another user connecting to it would be able to connect to it witho=
ut entering a password. --management-forget-disconnect can protect against =
this.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>The two other places where this is called (SIGUSR1 AUTH FAIL with<br>
&quot;auth-retry interact&quot; and man_forget_passwords() should be fine w=
ith<br>
forgetting tokens - I think &quot;AUTH FAIL&quot; already does this (in som=
e<br>
other code path).<br>
<br>
<br>
I agree with the intent on the patch (Feature-ACK), and would suggest<br>
to call &quot;ssl_clean_auth_token()&quot; directly from &quot;man_forget_p=
asswords()&quot;<br>
instead.=C2=A0 This will catch your (valid) use-case without impacting <br>
other users of ssl_purge_auth().<br></blockquote><div><br></div><div>I&#39;=
m okay with this. Will send an amended patch.<br></div><div><br></div><div>=
Selva</div></div></div>

--0000000000003bcf8405ebf0b381--

