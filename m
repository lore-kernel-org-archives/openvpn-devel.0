MIME-Version: 1.0
References: <20241106165950.14469-1-michael.m.clarke@...277...>
 <77861124-f340-48d1-b021-c56dd37c43ad@...1227...>
In-Reply-To: <77861124-f340-48d1-b021-c56dd37c43ad@...1227...>
From: Michael Clarke <michael.m.clarke@...277...>
Date: Wed, 6 Nov 2024 19:24:52 +0000
Message-ID: <CACLAULi-9O=ZfxH_0eLHyJ2HB66umyNukDdSahxJCC5hT5k9ig@...278...>
Content-Type: multipart/alternative; boundary="0000000000008dde2906264379ae"
Subject: Re: [Openvpn-devel] [PATCH] Allow auth plugins not to be invoked if
 other auth plugins fail
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Openvpn-devel@lists.sourceforge.net

--0000000000008dde2906264379ae
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the feedback.

I should have made it clear that this was a request for comment about the
concept.
Whilst the functionality works for the setup I've tested with, I've not
reviewed cases
of admin or auth-user-pass-verify scripts so there are potential gaps I'll
need to
go back and fill.

For background, the options are based on Linux PAM:
https://linux.die.net/man/5/pam.conf.
I don't use all the PAM configuration in any of my set-ups, but I know of
people who
cover use-cases through the likes of Optional, so didn't want to exclude it
unless
there's a strong consensus that it wouldn't provide value in the OpenVPN
case.


> This seems to only if you are using a different MFA approach than the
> current/recommended one, e.g. demonstrated by the demo script totp.py in
> the OpenVPN repository.
>

This is primarily aimed at out-of-band Push OTP rather than a user entering
a TOTP
into their VPN client.


> To better understand what this patch is actually addressing, it would be
> nice to describe the scenario that you are addressing with this patch as
> that me do better understand what real-world scenario is actually
> addressed by this patch as the this is a bit abstract.
>
>
The use case I'm working with is LDAP authentication followed by a Duo Push,
with the requirement being not to perform a Duo Push unless LDAP succeeds.
Both of these are initiated from server-side plugins, which I don't think
the
TOTP script handles, but I'm happy to be told there's an easy way of doing
this!



> plugin foo foo
>
> could be both as
>
>   plugin module-name "arguments"
>
> and as
>
> plugin [scope] module-name
>
>
> according to the man page. I do not like the approach of using a
> whitelist of argument to determine which of the two is being used as a
> typo for example or using an old version can then change the parsing in
> unexpected way. I would rather see something that has not this ambiguity
> like introducing a new keyword like plugin-something.
>
>
>
There would only be an incompatibility between old and new versions if you
had a binary named `optional`, `required`, `requisite`, or `suffiicient` on
your
path, and at that point your OpenVPN is likely to fail on the Plugin Init
phase
as the binary won't have the expected init methods in it, otherwise you'd
get
an error about not finding the binary for plugin `required`. Similarly
having a
typo in the configuration would result in OpenVPN failing to start with a
message about being unable to find the target binary for the plugin
`reequired`.

I did consider adding a new `scoped-plugin` item, but wanted to avoid the
ambiguity of someone mixing 'auth' plugins in `plugin` and `scoped-plugin`,
or using plugins that don't support scope (i.e. non-auth plugins) in
`scoped-plugin`. Do you have any suggestions about how you'd differentiate
existing plugins and the new plugin type to prevent ambiguity from
mix-and-matching old-and-new configuration, e.g. adding two auth-pam
entries,
one under an existing `plugin` line and one under the newly named
`scoped-plugin` line?


> What happens with other auth methods like management and auth scripts?
> That should be made clear without having to read the source code.
>

I've not looked at these yet. I'll come back to you on the actual
implementation of
these.


>
> What happens if all plugins are optinal. And what is the point of a
> plugin being called but ignored? Some idea what to use this for would be
> good.
>
>
Good point. Just now OpenVPN terminates if verify-client-cert is `none` and
then
doesn't have any auth-user-pass-verify scripts or plugins, but this change
doesn't
prevent someone setting only `sufficient` plugins that all fail, or only
setting `optional`
plugins. I can harden this by performing a configuration check to ensure a
non-optional
plugin is set after loading all plugins and to ensure there's no
fall-through for all
'sufficient'
plugins failing.

I don't use Optional in any of the PAM configurations I have, but know the
common
use-case is for ensuring keyrings/keychains are unlocked but not failing if
they're
unavailable.



> > +
> > +  If :code:`scope` is not specified for an auth plugin then the plugin
> will
> > +  be treated as :code:`required`.
>
> do we define what an auth plugin vs a non-plugin is anywhere?
>

No. This is a terminology I've gone with rather than an OpenVPN
nomenclature.
It's any plugin that returns the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
mask but didn't have a meaningful name for it that didn't refer to a
constant in the
code. I'm happy to take any suggestions on how to better define that
category
of plugins.



>
> > +  If :code:`scope` is specified for a non-auth plugin then the
> configuration
> > +  will be treated as invalid.
> > +
>
> And then what will happen?
>

OpenVPN will exit with an error about the configuration being invalid. Are
you wanting
this to be explicitly called-out?



> > +static char *
> > +plugin_scope_name(enum plugin_scope scope)
> > +{
> > +    switch (scope)
> > +    {
> > +        case PLUGIN_SCOPE_REQUIRED:
> > +            return "required";
> > +
> > +        case PLUGIN_SCOPE_REQUISITE:
> > +            return "requisite";
> > +
> > +        case PLUGIN_SCOPE_SUFFICIENT:
> > +            return "sufficient";
> > +
> > +        case PLUGIN_SCOPE_OPTIONAL:
> > +            return "optional";
> > +
> > +        default:
> > +            return "";
> > +    }
> The PLUGIN_SCOPE_UNDEFINED is missing from this function and default
> should be something other than an empty string I think
>
>
This was intentional - the only way you can have UNDEFINED  is not to
have defined a scope so when printing it back out anywhere I wanted to
show the same value as what the user had originally entered.



>
>
>
> > +    bool non_scope_sufficient_auth_plugin_seen = false;
>
> I have trouble parsing this variable name and meaning. A plugin without
> scope is required from the earlier manpage changes. The combination of
> no scope but a sufficent scope makes no sense to me.
>

Agreed the naming isn't great here. This is enforcing the section from the
manpage
about ":code:`sufficient` plugins must be listed before any other
plugins.", so checking
if we've seen something that's not a `sufficient` plugin as we iterate over
plugins.
However, re-reading the PAM config man page the 'sufficient' should be able
to be
placed anywhere but have the result ignore if a previous 'required' or
'requisite'
plugin has failed. I'll do some refactoring to make this work as-per what
PAM is doing
which will ultimately remove the block of code in this area.



> > +                msg(M_FATAL,
> > +                    "PLUGIN_INIT: auth plugin %s is defined as
> 'sufficient' but has been specified after other auth plugins not specified
> as 'sufficient'",
> > +                    pc->plugins[i].so_pathname);
> > +            }
>
> Is this restriction documented in the man page? Also why has this
> decision been made. I don't see any obvious reason for it.
>
>
Yes: " :code:`sufficient` plugins must be listed before any other
plugins.". This was to
prevent ambiguity with a requisite or required plugin failing and having a
sufficient
plugin listed afterwards. As mentioned above I've misunderstood what PAM
does in
this area, so will update my implementation to be less restrictive.

Thanks,
Michael

--0000000000008dde2906264379ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks for the feedback.=
</div><div><br></div><div>I should have made it clear that this was a reque=
st for comment about the concept.</div><div>Whilst the functionality works =
for the setup I&#39;ve tested with, I&#39;ve not reviewed cases</div><div>o=
f admin or auth-user-pass-verify scripts so=C2=A0there are potential gaps I=
&#39;ll need to</div><div>go back and fill.</div><div><br></div><div>For ba=
ckground, the options are based on Linux PAM:</div><div><a href=3D"https://=
linux.die.net/man/5/pam.conf">https://linux.die.net/man/5/pam.conf</a>.</di=
v><div>I don&#39;t use all the PAM configuration in any of my set-ups, but =
I know of people who</div><div>cover use-cases through the likes of Optiona=
l, so didn&#39;t want to exclude it unless</div><div>there&#39;s a strong c=
onsensus that it wouldn&#39;t provide value in the OpenVPN case.</div><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
This seems to only if you are using a different MFA approach than the <br>
current/recommended one, e.g. demonstrated by the demo script totp.py in <b=
r>
the OpenVPN repository.<br></blockquote><div>=C2=A0</div><div>This is prima=
rily aimed at out-of-band Push OTP rather than a user entering a TOTP</div>=
<div>into their VPN client.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
To better understand what this patch is actually addressing, it would be <b=
r>
nice to describe the scenario that you are addressing with this patch as <b=
r>
that me do better understand what real-world scenario is actually <br>
addressed by this patch as the this is a bit abstract.<br>
<br></blockquote><div><br></div><div>The use case I&#39;m working with is L=
DAP authentication followed by a Duo Push,</div><div>with the requirement b=
eing not to perform a Duo Push unless LDAP succeeds.</div><div>Both of thes=
e are initiated from server-side plugins, which I don&#39;t think the=C2=A0=
</div><div>TOTP script handles, but I&#39;m happy to be told there&#39;s an=
 easy way of doing this!</div><br class=3D"gmail-Apple-interchange-newline"=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
plugin foo foo<br>
<br>
could be both as<br>
<br>
=C2=A0 plugin module-name &quot;arguments&quot;<br>
<br>
and as<br>
<br>
plugin [scope] module-name<br>
<br>
<br>
according to the man page. I do not like the approach of using a <br>
whitelist of argument to determine which of the two is being used as a <br>
typo for example or using an old version can then change the parsing in <br>
unexpected way. I would rather see something that has not this ambiguity <b=
r>
like introducing a new keyword like plugin-something.<br>
<br>
<br></blockquote><div><br></div><div>There would only be an incompatibility=
=C2=A0between old and new versions if you</div><div>had a binary named `opt=
ional`, `required`, `requisite`, or `suffiicient` on your</div><div>path, a=
nd at that point your OpenVPN is likely to fail on the Plugin Init phase</d=
iv><div>as the binary won&#39;t have the expected init methods in it, other=
wise you&#39;d get</div><div>an error about not finding the binary for plug=
in `required`. Similarly having a</div><div>typo in the configuration would=
 result in OpenVPN failing to start with a=C2=A0</div><div>message about be=
ing unable to find the target binary for the plugin `reequired`.</div><div>=
<br></div><div>I did consider adding a new `scoped-plugin` item, but wanted=
 to avoid the</div><div>ambiguity of someone mixing &#39;auth&#39; plugins =
in `plugin` and `scoped-plugin`,</div><div>or using plugins that don&#39;t =
support scope (i.e. non-auth plugins) in=C2=A0</div><div>`scoped-plugin`. D=
o you have any suggestions about how you&#39;d differentiate</div><div>exis=
ting plugins and the new plugin type to prevent ambiguity from=C2=A0</div><=
div>mix-and-matching old-and-new configuration, e.g. adding two auth-pam en=
tries,</div><div>one under an existing `plugin` line and one under the newl=
y named</div><div>`scoped-plugin` line?</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
What happens with other auth methods like management and auth scripts? <br>
That should be made clear without having to read the source code.<br></bloc=
kquote><div><br></div><div>I&#39;ve not looked at these yet. I&#39;ll come =
back to you on the actual implementation of</div><div>these.<br>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
What happens if all plugins are optinal. And what is the point of a <br>
plugin being called but ignored? Some idea what to use this for would be <b=
r>
good.<br>
<br></blockquote><div><br></div><div>Good point. Just now OpenVPN terminate=
s if verify-client-cert is `none` and then</div><div>doesn&#39;t have any a=
uth-user-pass-verify scripts or plugins, but this change doesn&#39;t</div><=
div>prevent someone setting only `sufficient` plugins that all fail, or onl=
y setting `optional`</div><div>plugins. I can harden this by performing a c=
onfiguration check to ensure a non-optional</div><div>plugin is set after l=
oading all plugins and to ensure there&#39;s no fall-through for all=C2=A0<=
/div><div>&#39;sufficient&#39;</div><div>plugins failing.</div><div><br></d=
iv><div>I don&#39;t use Optional in any of the PAM configurations I have, b=
ut know the common</div><div>use-case is for ensuring keyrings/keychains ar=
e unlocked but not failing if they&#39;re</div><div>unavailable.</div><div>=
<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 If :code:`scope` is not specified for an auth plugin then the =
plugin will<br>
&gt; +=C2=A0 be treated as :code:`required`.<br>
<br>
do we define what an auth plugin vs a non-plugin is anywhere?<br></blockquo=
te><div><br></div><div>No. This is a terminology I&#39;ve gone with rather =
than an OpenVPN nomenclature.</div><div>It&#39;s any plugin that returns th=
e OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY</div><div>mask but didn&#39;t have a=
 meaningful name for it that didn&#39;t refer to a constant in the</div><di=
v>code. I&#39;m happy to take any suggestions on how to better define that =
category</div><div>of plugins.</div><div><br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 If :code:`scope` is specified for a non-auth plugin then the c=
onfiguration<br>
&gt; +=C2=A0 will be treated as invalid.<br>
&gt; +<br>
<br>
And then what will happen?<br></blockquote><div><br></div><div>OpenVPN will=
 exit with an error about the configuration being invalid. Are you wanting<=
/div><div>this to be explicitly called-out?</div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +static char *<br>
&gt; +plugin_scope_name(enum plugin_scope scope)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (scope)<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PLUGIN_SCOPE_REQUIRED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;required&quot;=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PLUGIN_SCOPE_REQUISITE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;requisite&quot=
;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PLUGIN_SCOPE_SUFFICIENT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;sufficient&quo=
t;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PLUGIN_SCOPE_OPTIONAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;optional&quot;=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&quot;;<br>
&gt; +=C2=A0 =C2=A0 }<br>
The PLUGIN_SCOPE_UNDEFINED is missing from this function and default <br>
should be something other than an empty string I think<br>
<br></blockquote><div><br></div><div>This was intentional - the only way yo=
u can have UNDEFINED=C2=A0 is not to=C2=A0</div><div>have defined a scope s=
o when printing it back out anywhere I wanted to=C2=A0</div><div>show the s=
ame value as what the user had originally entered.</div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 bool non_scope_sufficient_auth_plugin_seen =3D false;<b=
r>
<br>
I have trouble parsing this variable name and meaning. A plugin without <br>
scope is required from the earlier manpage changes. The combination of <br>
no scope but a sufficent scope makes no sense to me.<br></blockquote><div><=
br></div><div>Agreed the naming isn&#39;t great here. This is enforcing the=
 section from the manpage</div><div>about &quot;:code:`sufficient` plugins =
must be listed before any other plugins.&quot;, so checking</div><div>if we=
&#39;ve seen something that&#39;s not a `sufficient` plugin as we iterate o=
ver plugins.</div><div>However, re-reading the PAM config man page the &#39=
;sufficient&#39; should be able to be</div><div>placed anywhere but have th=
e result ignore if a previous &#39;required&#39; or &#39;requisite&#39;</di=
v><div>plugin has failed. I&#39;ll do some refactoring to make this work as=
-per what PAM is doing</div><div>which will ultimately remove the block of =
code in this area.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;PLUGIN_INIT: auth plugin %s is defined as &#39;sufficient&#39; but h=
as been specified after other auth plugins not specified as &#39;sufficient=
&#39;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pc-&gt;plugins[i].so_pathname);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Is this restriction documented in the man page? Also why has this <br>
decision been made. I don&#39;t see any obvious reason for it.<br>
<br></blockquote><div><br></div><div>Yes: &quot;=C2=A0:code:`sufficient` pl=
ugins must be listed before any other plugins.&quot;. This was to</div><div=
>prevent ambiguity with a requisite or required plugin failing and having a=
 sufficient</div><div>plugin listed afterwards. As mentioned above I&#39;ve=
 misunderstood what PAM does in</div><div>this area, so will update my impl=
ementation to be less restrictive.</div><div><br></div><div>Thanks,</div><d=
iv>Michael</div></div></div>

--0000000000008dde2906264379ae--

