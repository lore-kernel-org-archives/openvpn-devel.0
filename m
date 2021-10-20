MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
In-Reply-To: <20211019183127.614175-13-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Oct 2021 14:19:07 -0400
Message-ID: <CAKuzo_h6zwNySb7iu=bFGduxH7jB2OT_2TopZ0gYdYPmpRTO=g@...278...>
Content-Type: multipart/alternative; boundary="000000000000503d2305ceccd16d"
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000503d2305ceccd16d
Content-Type: text/plain; charset="UTF-8"

Hi,

Not a code review but a general comment as this is a new option that
warrants some discussion.

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> This allows OpenVPN to load non-default providers. This is mainly
> useful for loading the legacy provider with --provider legacy:default
>

While this format looks okay, we need to consider a few things to get this
option right and possibly extensible in future without causing a regression.

(i) Provider name may not be a simple word like legacy -- could also be the
path to a shared object with possible embedded space in the path name. A
single option with optional quotes, picked apart using ":" as separator can
still work.

Ideally I would have preferred space separated provider names with
each quoted if needed, but the format proposed here may be easier to parse.
Need clear documentation, though.

(ii) We may want to attach some meaning to the order in which providers are
specified. Here is why:

When multiple providers implement the same method (say, KEYEXCH), there is
no guarantee in OpenSSL as to which will get used. Unless a property query
like "?provider=my-fast-aes" is also used. Here the prefix "?" to mean
preferred but not exclusive. In cases like an pkcs11 token provider, one
would need to say the opposite like "?provider=default" to ensure default
is preferred and the token provider is to be used only when required -- say
when the key is in a token. Same would be the case with our proposed
built-in  "external-key provider" which should be used only for certain
operations that handle the external key.

How this relates to the --provider option is like this: in some cases we
want to know which provider the user prefers. Instead of hard-coding the
preferred provider to "default" which the user may not even want to load.
We could state that the first provider specified will become the preferred
one when there are multiple choices for a method or when a preferred
fallback is required. In that case the option for legacy would be

--provider default:legacy

And, if this option is absent, we take it to mean that the "default"
provider should be loaded. This explicit loading of providers takes away
some ambiguity regarding which one's are made available. However, this
could conflict with what is in the OpenSSL config file. Which is not a bad
thing as we probably should not use the config file to load providers
(which we currently do) -- it's not supported on some platforms (Windows as
of now) and can lead to broken setups due to user error.

At the same time, provider paths and their names could be set up in OpenSSL
config files, so loading them through config has some advantages. So, an
alternate option is to not add this option at all and require the use of a
config file to load additional providers like "legacy + default". Loading a
custom config file is possible with OpenSSL 3.0 and could be enabled on
Windows in a safe manner.

Or always load providers from OPENSSL config and use the "--provider foo"
on top of that.

We could also consider a separate option to specify a preferred property
query ("?provider=myprov") that could be added later and not rely on any
ordering here.

The above is just meant for further discussion -- I'm not entirely sure
what the best approach is.

Regards,

Selva

--000000000000503d2305ceccd16d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Not a code review but a =
general comment as this is a new option that warrants some discussion.</div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...2639...=
.." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">This allows OpenVPN to load non-defaul=
t providers. This is mainly<br>
useful for loading the legacy provider with --provider legacy:default<br></=
blockquote><div><br></div><div>While this format looks okay, we need to con=
sider a few things to get this option right and possibly extensible in futu=
re without causing a regression.</div><div><br></div><div>(i) Provider name=
 may not be a simple word=C2=A0like legacy -- could also be the path to a s=
hared object with possible embedded space in the path name. A single option=
 with optional quotes, picked apart using &quot;:&quot; as separator=C2=A0c=
an still work.</div><div><br></div><div>Ideally I would have preferred spac=
e separated provider names with each=C2=A0quoted if needed, but the=C2=A0fo=
rmat proposed here may be easier to parse. Need clear documentation, though=
.</div><div><br></div><div>(ii) We may want to attach some meaning to the o=
rder in which providers are specified. Here is why:</div><div><br></div><di=
v>When multiple providers implement the same method (say, KEYEXCH), there i=
s no=C2=A0guarantee in OpenSSL as to which will get used. Unless a property=
 query like &quot;?provider=3Dmy-fast-aes&quot; is also used. Here the pref=
ix &quot;?&quot; to mean preferred but not exclusive. In cases like an pkcs=
11 token provider, one would need to say the opposite like &quot;?provider=
=3Ddefault&quot; to ensure default is preferred and the token provider is t=
o be used only when required --=C2=A0say when the key is in a token. Same w=
ould be the case with our proposed built-in=C2=A0 &quot;external-key provid=
er&quot; which should be used only for certain operations that=C2=A0handle =
the external key.</div><div><br></div><div>How this relates to the --provid=
er option is like this: in some cases=C2=A0we want to know which provider t=
he user prefers. Instead of hard-coding the preferred provider to &quot;def=
ault&quot; which the user may not even want to load. We could state that th=
e first provider specified will become the preferred one when there are mul=
tiple choices for a method or when a preferred fallback is required. In tha=
t case the option for legacy would be</div><div><br></div><div>--provider d=
efault:legacy</div><div><br></div><div>And, if this option is absent, we ta=
ke it to mean=C2=A0that the &quot;default&quot; provider should be loaded. =
This explicit loading of providers takes away some ambiguity regarding whic=
h one&#39;s are made available. However, this could conflict with what is i=
n the OpenSSL config file. Which is not a bad thing as we probably should n=
ot use the config file to load providers (which we currently do) -- it&#39;=
s not supported on some platforms (Windows as of now) and can lead to broke=
n setups due to user error.</div><div><br></div><div>At the same time, prov=
ider=C2=A0paths and their names could be set up in OpenSSL config files, so=
 loading them through config has some advantages. So, an alternate option i=
s to not add this option at all and require the use of a config file to loa=
d additional providers like &quot;legacy=C2=A0+ default&quot;. Loading a cu=
stom config file is possible with OpenSSL 3.0 and could be enabled on Windo=
ws in a safe manner.=C2=A0=C2=A0</div><div><br></div><div>Or always load pr=
oviders from OPENSSL config and use the &quot;--provider foo&quot; on top=
=C2=A0of that.</div><div><br></div><div>We could also consider a separate o=
ption to specify a preferred property query (&quot;?provider=3Dmyprov&quot;=
) that could be added later and not rely on any ordering here.</div><div><b=
r></div><div>The above is just meant for further discussion -- I&#39;m not =
entirely sure what the best approach=C2=A0is.</div><div><br></div><div>Rega=
rds,</div><div><br></div><div>Selva</div></div></div>

--000000000000503d2305ceccd16d--

