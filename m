MIME-Version: 1.0
References: <20220310115718.11188-1-gert@...1296...>
In-Reply-To: <20220310115718.11188-1-gert@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Fri, 11 Mar 2022 16:29:42 +0000
Message-ID: <CAAYFXLmJzmwUXQiLhiUwJA9_+6QA47tBOgo-XhiWf0vJ+LPFJA@...278...>
Content-Type: multipart/alternative; boundary="000000000000238eb205d9f3d708"
Subject: Re: [Openvpn-devel] [PATCH] Enable deferred auth for multiple
 plugins (RFC).
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

--000000000000238eb205d9f3d708
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 12:18 PM Gert Doering <gert@...1296...> wrote:

> The actual plugin calls are no longer done with the "do them all"
> function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h
> is changed to expose the "call one" function plugin_call_item(), and
> verify_user_pass_plugin() calls this for each loaded plugin,
> keeping track of "overall" state.
>
> key_state_test_plugin_auth() is introduced to do the
> "key_state_test_auth_control_file()" test for all plugins, and
> return "FAIL if one fails, PENDING if one is pending, SUCCESS
> if one was pending and succeeded now".
>

Since the handling is changing from "do them all' to "call one and FAIL on
first failure," may I suggest a feature enhancement?

Linux PAM uses auth plugins too, and each plugin has a control flag of
required, requisite, sufficient, or optional.  To date, OpenVPN handles
auth plugins as if each were required (proceed with next regardless of
failure), but with this patch, that will change to requisite (fail
immediately on first failure).  What if, as part of the openvpn plugin
config, we could set the behavior explicitly, much like PAM allows?

For reference:
http://linux-pam.org/Linux-PAM-html/sag-configuration-file.html

This would allow OpenVPN to handle alternate authentication paths, such as:

> plugin sufficient /usr/share/openvpn/plugin/lib/openvpn-auth-pam.so login
> plugin requisite /usr/share/openvpn/plugin/lib/openvpn-auth-ldap.so login
> plugin required /usr/share/openvpn/plugin/lib/openvpn-auth-duo.so login
> skey=abc ...
>

This setup would succeed immediately if the user successfully authenticates
with a local account; otherwise it would require LDAP and Duo MFA, but
would not query Duo if LDAP failed.

Such control would be constrained by the deferral mechanism, as the
deferred result cannot be immediately evaluated, so I think it makes sense
that all deferred plugins are assumed to be required and must follow any
plugins marked as requisite/sufficient.  Alternatively, if a deferred
plugin is marked as sufficient or requisite, it could hold further
processing until the deferred result is returned, but that negates much of
the asynchronous advantage that deferral gives us.

So that config files don't need updating between versions, I think it's
also wise to use a default flag if one is not specified.  I would suggest
non-deferred results default to requisite and deferred to required.  Or if
you want strict compatibility with existing behavior, you could default all
to required.

On that note, regarding serial vs. parallel launching of multiple deferred
plugins, unless PAM-like control is implemented and plugins are allowed to
be sufficient or requisite, I vote for launching them all in parallel and
returning FAIL if any one fails.

Thanks,
--
Pete

--000000000000238eb205d9f3d708
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Mar 10, 2022 at 12:18 PM Gert Doe=
ring &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<=
br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">The actual plugin calls are no longer done with the &quot;do the=
m all&quot;<br>
function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h<br>
is changed to expose the &quot;call one&quot; function plugin_call_item(), =
and<br>
verify_user_pass_plugin() calls this for each loaded plugin,<br>
keeping track of &quot;overall&quot; state.<br>
<br>
key_state_test_plugin_auth() is introduced to do the<br>
&quot;key_state_test_auth_control_file()&quot; test for all plugins, and<br>
return &quot;FAIL if one fails, PENDING if one is pending, SUCCESS<br>
if one was pending and succeeded now&quot;.<br></blockquote><div>=C2=A0</di=
v><div>Since the handling is changing from &quot;do them all&#39; to &quot;=
call one and FAIL on first failure,&quot; may I suggest a feature enhanceme=
nt?</div><div><br></div><div>Linux PAM uses auth plugins too, and each plug=
in has a control flag of required, requisite, sufficient, or optional.=C2=
=A0 To date, OpenVPN handles auth plugins as if each were required (proceed=
 with next regardless of failure), but with this patch, that will change to=
 requisite (fail immediately on first failure).=C2=A0 What if, as part of t=
he openvpn plugin config, we could set the behavior explicitly, much like P=
AM allows?<br><br></div><div>For reference: <a href=3D"http://linux-pam.org=
/Linux-PAM-html/sag-configuration-file.html">http://linux-pam.org/Linux-PAM=
-html/sag-configuration-file.html</a></div><div><br></div><div>This would a=
llow OpenVPN to handle alternate authentication paths, such as:</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div>plugin sufficient /usr/sha=
re/openvpn/plugin/lib/openvpn-auth-pam.so login<br>plugin requisite /usr/sh=
are/openvpn/plugin/lib/openvpn-auth-ldap.so login<br>plugin required /usr/s=
hare/openvpn/plugin/lib/openvpn-auth-duo.so login skey=3Dabc ...</div></blo=
ckquote><div><br><div>This setup would succeed immediately if the user succ=
essfully authenticates with a local account; otherwise it would require LDA=
P and Duo MFA, but would not query Duo if LDAP failed.</div><div><br></div>=
<div>Such control would be constrained by the deferral mechanism, as the de=
ferred result cannot be immediately evaluated, so I think it makes sense th=
at all deferred plugins are assumed to be required and must follow any plug=
ins marked as requisite/sufficient.=C2=A0 Alternatively, if a deferred plug=
in is marked as sufficient or requisite, it could hold further processing u=
ntil the deferred result is returned, but that negates much of the asynchro=
nous advantage that deferral gives us.</div><div><br></div><div>So that con=
fig files don&#39;t need updating between versions, I think it&#39;s also w=
ise to use a default flag if one is not specified.=C2=A0 I would suggest no=
n-deferred results default to requisite and deferred to required.=C2=A0 Or =
if you want strict compatibility with existing behavior, you could default =
all to required.<br></div><div><br></div><div>On that note, regarding seria=
l vs. parallel launching of multiple deferred plugins, unless PAM-like cont=
rol is implemented and plugins are allowed to be sufficient or requisite, I=
 vote for launching them all in parallel and returning FAIL if any one fail=
s.<br></div><div><br></div><div>Thanks,</div><div>--</div><div>Pete<br></di=
v></div></div></div>

--000000000000238eb205d9f3d708--

