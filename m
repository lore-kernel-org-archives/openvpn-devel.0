MIME-Version: 1.0
References: <20221130205718.79765-1-gert@...1296...>
 <20221229072746.19169-1-themiron@...2010...>
 <Y73EuV4BJLLcg7WU@...1296...>
In-Reply-To: <Y73EuV4BJLLcg7WU@...1296...>
From: Vladislav Grishenko <themiron.ru@...277...>
Date: Wed, 11 Jan 2023 01:42:31 +0500
Message-ID: <CAK5QT=ykkPXnOOktChAx5GZRSLpFWe7Wuhh_z+qUXr-FiXrv7g@...278...>
Content-Type: multipart/alternative; boundary="000000000000f15d6c05f1eeec74"
Subject: Re: [Openvpn-devel] [PATCH v15] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

--000000000000f15d6c05f1eeec74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sure, will do.
Yes, I=E2=80=99ve noticed undesired code dup in v14 and have fixed everythi=
ng found
in v15 rebase, same will be rechecked in v16 of course.
Thanks!

=D0=A1=D1=80, 11 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 01:05, Gert Doerin=
g <gert@...1296...>:

> Hi,
>
> On Thu, Dec 29, 2022 at 12:27:46PM +0500, Vladislav Grishenko wrote:
> >   client will move on to the next connection entry.
> >
> > v15:
> >     rebase to master (Dec 2022)
> >     add optional port argument to --remote and --remote-srv usage messa=
ge
> >     fix --proto option coexisting with --remote-srv
> >     fix --nobind option coexisting with --remote-srv
> >     fix options postprocess mutation lost in v13/v14
> >     recover --mtu-test handling with --remote-srv
> >     use explicit srv resolve stub for openbsd for the future
> >     fix comments
>
> Getting close... but, alas, we need another rebase - the signal handling
> fixes from Selva cause conflicts.  Can you do a v16, please?
>
> Also, please have a very close look at the code now - it looks like
> the previous rebase is now creating quite a bit of (undesired!) code
> duplication.  For example, this new hunk:
>
> +static bool
> +options_postprocess_verify_ce_proto(const struct options *options,
> +                                    const struct connection_entry *ce)
> +{
> +    int msglevel =3D M_WARN|M_NOPREFIX|M_OPTERR;
> +
> +    /*
> +     * Sanity check on --local, --remote, and --ifconfig
> +     */
> +
> +    if (proto_is_net(ce->proto)
> +        && string_defined_equal(ce->local, ce->remote)
> +        && string_defined_equal(ce->local_port, ce->remote_port))
> +    {
> +        msg(msglevel, "--remote and --local addresses are the same");
> +        return false;
> +    }
> +
> +    if (string_defined_equal(ce->remote, options->ifconfig_local)
> +        || string_defined_equal(ce->remote,
> options->ifconfig_remote_netmask))
> +    {
> +        msg(msglevel,
> +            "--local and --remote addresses must be distinct from
> --ifconfig "
> +            "addresses");
> +        return false;
> +    }
>
>
> ... these checks are existing today, in options_postprocess_verify_ce(),
> but your patch is not *moving* them to the new function, but *duplicating*
> them.  This can happen if "git --rebase" gets confused by too many
> unrelated changes, but is not the desired end state.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
--=20
Best regards, Vladislav Grishenko

--000000000000f15d6c05f1eeec74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi, sure, will do.</div><div dir=3D"auto">Yes, I=E2=80=99=
ve noticed undesired code dup in v14 and have fixed everything found in v15=
 rebase, same will be rechecked in v16 of course.</div><div dir=3D"auto">Th=
anks!</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">=D0=A1=D1=80, 11 =D1=8F=D0=BD=D0=B2. 2023=C2=A0=D0=B3. =D0=B2 01:=
05, Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>=
&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bord=
er-left-color:rgb(204,204,204)">Hi,<br>
<br>
On Thu, Dec 29, 2022 at 12:27:46PM +0500, Vladislav Grishenko wrote:<br>
&gt;=C2=A0 =C2=A0client will move on to the next connection entry.<br>
&gt; <br>
&gt; v15:<br>
&gt;=C2=A0 =C2=A0 =C2=A0rebase to master (Dec 2022)<br>
&gt;=C2=A0 =C2=A0 =C2=A0add optional port argument to --remote and --remote=
-srv usage message<br>
&gt;=C2=A0 =C2=A0 =C2=A0fix --proto option coexisting with --remote-srv<br>
&gt;=C2=A0 =C2=A0 =C2=A0fix --nobind option coexisting with --remote-srv<br>
&gt;=C2=A0 =C2=A0 =C2=A0fix options postprocess mutation lost in v13/v14<br>
&gt;=C2=A0 =C2=A0 =C2=A0recover --mtu-test handling with --remote-srv<br>
&gt;=C2=A0 =C2=A0 =C2=A0use explicit srv resolve stub for openbsd for the f=
uture<br>
&gt;=C2=A0 =C2=A0 =C2=A0fix comments<br>
<br>
Getting close... but, alas, we need another rebase - the signal handling<br>
fixes from Selva cause conflicts.=C2=A0 Can you do a v16, please?<br>
<br>
Also, please have a very close look at the code now - it looks like<br>
the previous rebase is now creating quite a bit of (undesired!) code<br>
duplication.=C2=A0 For example, this new hunk:<br>
<br>
+static bool<br>
+options_postprocess_verify_ce_proto(const struct options *options,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct connectio=
n_entry *ce)<br>
+{<br>
+=C2=A0 =C2=A0 int msglevel =3D M_WARN|M_NOPREFIX|M_OPTERR;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Sanity check on --local, --remote, and --ifconfig<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 if (proto_is_net(ce-&gt;proto)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; string_defined_equal(ce-&gt;local, =
ce-&gt;remote)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; string_defined_equal(ce-&gt;local_p=
ort, ce-&gt;remote_port))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;--remote and --local addre=
sses are the same&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (string_defined_equal(ce-&gt;remote, options-&gt;ifconfig=
_local)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || string_defined_equal(ce-&gt;remote, options=
-&gt;ifconfig_remote_netmask))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--local and --remote addre=
sses must be distinct from --ifconfig &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;addresses&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
<br>
... these checks are existing today, in options_postprocess_verify_ce(),<br>
but your patch is not *moving* them to the new function, but *duplicating*<=
br>
them.=C2=A0 This can happen if &quot;git --rebase&quot; gets confused by to=
o many<br>
unrelated changes, but is not the desired end state.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature">Best regards, Vladislav Grishenko</div>

--000000000000f15d6c05f1eeec74--

