MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
References: <CAKuzo_iOXui4WDuRqf6-NybpfeWNjKR3GLn7dsw98FoNoSHNMw@...278...>
 <20171105223714.7852-1-simon@...2293...>
 <CAKuzo_gsuMMhThtx4UvWoHP9ipT4x_KEFewBxh00z=h4xkc4ow@...278...>
 <99D61A626FDA8A4B90A270669121BE1085882F90@...2294...>
From: Selva <selva.nair@...277...>
Date: Wed, 8 Nov 2017 14:52:44 -0500
Message-ID: <CAKuzo_jDTZ41vrpZYPtzkW51=2a9X90qtwYnkGGXx85QVJceZg@...278...>
Content-Type: multipart/alternative; boundary="94eb2c04422a3328cd055d7e09e2"
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnserv: Add support for
 multi-instances
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c04422a3328cd055d7e09e2
Content-Type: text/plain; charset="UTF-8"

Hi


>
> > > +                static const SERVICE_TABLE_ENTRY
> > > + dispatchTable_automatic[] = {
> > > +                    { TEXT(""), ServiceStartAutomaticOwn },
> > > +                    { NULL, NULL }
> > > +                };
> >
> > Agreed this array has to live beyond the for loop, but why static?
> Statics live
> > for ever while this need not exist beyond the function. Putting it at
> the top
> > where dispatchTable_shared is defined (or anywhere before the loop) as a
> > non-static variable would be the way to go?
>
> - There is almost nothing beyond this function. This is "the" main
> function. This function endures the whole process lifetime, making its
> local variables persist on stack the whole process lifetime. Not much
> better than static variables.
>
> - If this was some big chunk of data declared as a main() local variable,
> it would eat up its chunk of stack for the whole process lifetime. When it
> is declared as static, it is kept in the data segment.
>
> - But the main reason behind static usage is to allow us to keep the
> feature as a single chunk of code vs. splitting it across the main
> function. I personally put code aesthetics before memory usage.
>

I guessed that much. And agreed that this is main and everything here
persists
for ever... Also minimizing the scope of declarations is good style.

But then making the variable static just to keep a valid pointer beyond the
current block
local looks like a kludge. For me seeing static applied to a variable
scoped to
a block is just confusing and unusual style. Think of this: if you remove
that static
the code may still build and even work on some compilers depending on
optimization
level etc. and mysteriously fail on some occasions. From that one could
either conclude
a static qualifier is required her or the variable is wrongly scoped. I
think the latter
conclusion is the 'right' one and static is a misuse.

As for the combination 'static const ...', it has a place and that is for
constants
defined outside functions to limit the scope of an otherwise  global const
to
that of the compilation unit.

It may be just me.


>
> > Finally, we could add the instance name to the eventlog output.
> > MsgToEventLog prints errors as "APPNAME error: ...." where APPNAME is
> > "openvpnserv".
> > E.g., add " (instance_name)" after APPNAME?
>
> Excellent suggestion. I shall add it to the v3 patch.
>
> However, I propose a bit different output. The `service_instance` dynamic
> service name is used as a replacement for "OpenVPN" and "openvpn" hardcoded
> strings in the code. Therefore, logging "APPNAME (instance_name)" would log
> as "OpenVPN (OpenVPN)" for official builds. Not exactly elegant. I would
> prefer to keep the official OpenVPN log output backward binary compatible.
>
> An example of how we branded interactive service instance for eduVPN:
> - The interactive service is installed as "OpenVPNServiceInteractive$eduVPN"
> with the display name "OpenVPN Interactive Service (eduVPN)"
>

Use of $instance is MSSQL style... good.


> - The service is launched using "openvpnserv.exe -instance interactive
> OpenVPN$eduVPN" command line.
> - This makes it load the settings from "HKEY_LOCAL_MACHINE\SOFTWARE\
> OpenVPN$eduVPN"
>
> We were careful to start the instance name with "OpenVPN$" because:
> - We don't want to hide the OpenVPN interactive service official
> name/brand.
> - Our version of interactive service is always listed next to the official
> OpenVPN's. In the registry and on the services.msc list.
> - Our registry key is adjacent to the official OpenVPN's.
> - $ is also used in Microsoft SQL Server as a delimiter.
>

I like it: using "OpenVPN" as a kind of namespace also avoids name
collision with
any other 'foobar' installed in HKLM\Software\foobar


>
> Using the APPNAME ("openvpnserv") and merging with our instance name would
> make a Frankenstein "openvpnservOpenVPN$eduVPN" log entry. Not exactly
> elegant either.
>
> For v3 I shall redesign the code to use compile-time defined
> PACKAGE_NAME/PACKAGE as the left part again, and only append the ""
> service_instance for official OpenVPN and "$eduVPN" for named instance.
>

Not sure I follow, but will wait for the patch. I suppose naming additional
instances as, say, 'foo'  using the official package and have service pipe,
exit
event etc named after it and registry keys taken from HKLM\Software\foo will
still work.

In fact I like the current patch in that it allows installing even the
official instance
as a named one with name = OpenVPN and thus decouples automatic and
interactive services. That makes it easy to avoid installing the legacy
service,
which I think no one uses anymore.

Thanks,

Selva

--94eb2c04422a3328cd055d7e09e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br><div class=3D"gmail_extra"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
<br>
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static c=
onst SERVICE_TABLE_ENTRY<br>
&gt; &gt; + dispatchTable_automatic[] =3D {<br>
<span class=3D"">&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{ TEXT(&quot;&quot;), ServiceStartAutomaticOwn },<b=
r>
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{ NULL, NULL }<br>
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;<br>
&gt; Agreed this array has to live beyond the for loop, but why static? Sta=
tics live<br>
&gt; for ever while this need not exist beyond the function. Putting it at =
the top<br>
&gt; where dispatchTable_shared is defined (or anywhere before the loop) as=
 a<br>
&gt; non-static variable would be the way to go?<br>
<br>
</span>- There is almost nothing beyond this function. This is &quot;the&qu=
ot; main function. This function endures the whole process lifetime, making=
 its local variables persist on stack the whole process lifetime. Not much =
better than static variables.<br>
<br>
- If this was some big chunk of data declared as a main() local variable, i=
t would eat up its chunk of stack for the whole process lifetime. When it i=
s declared as static, it is kept in the data segment.<br>
<br>
- But the main reason behind static usage is to allow us to keep the featur=
e as a single chunk of code vs. splitting it across the main function. I pe=
rsonally put code aesthetics before memory usage.<br></blockquote><div><br>=
</div><div>I guessed that much. And agreed that this is main and everything=
 here persists</div><div>for ever... Also minimizing the scope of declarati=
ons is good style.</div><div><br></div><div>But then making the variable st=
atic just to keep a valid pointer beyond the current block</div><div>local =
looks like a kludge. For me seeing static applied to a variable scoped to</=
div><div>a block is just confusing and unusual style. Think of this: if you=
 remove that static</div><div>the code may still build and even work on som=
e compilers depending on optimization</div><div>level etc. and mysteriously=
 fail on some occasions. From that one could either conclude</div><div>a st=
atic qualifier is required her or the variable is wrongly scoped. I think t=
he latter</div><div>conclusion is the &#39;right&#39; one and static is a m=
isuse.</div><div><br></div><div>As for the combination &#39;static const ..=
.&#39;, it has a place and that is for constants</div><div>defined outside =
functions to limit the scope of an otherwise =C2=A0global const to</div><di=
v>that of the compilation unit.</div><div><br></div><div>It may be just me.=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
<br>
&gt; Finally, we could add the instance name to the eventlog output.<br>
&gt; MsgToEventLog prints errors as &quot;APPNAME error: ....&quot; where A=
PPNAME is<br>
&gt; &quot;openvpnserv&quot;.<br>
&gt; E.g., add &quot; (instance_name)&quot; after APPNAME?<br>
<br>
</span>Excellent suggestion. I shall add it to the v3 patch.<br>
<br>
However, I propose a bit different output. The `service_instance` dynamic s=
ervice name is used as a replacement for &quot;OpenVPN&quot; and &quot;open=
vpn&quot; hardcoded strings in the code. Therefore, logging &quot;APPNAME (=
instance_name)&quot; would log as &quot;OpenVPN (OpenVPN)&quot; for officia=
l builds. Not exactly elegant. I would prefer to keep the official OpenVPN =
log output backward binary compatible.<br>
<br>
An example of how we branded interactive service instance for eduVPN:<br>
- The interactive service is installed as &quot;OpenVPNServiceInteractive$<=
wbr>eduVPN&quot; with the display name &quot;OpenVPN Interactive Service (e=
duVPN)&quot;<br></blockquote><div><br></div><div>Use of $instance is MSSQL =
style... good.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
- The service is launched using &quot;openvpnserv.exe -instance interactive=
 OpenVPN$eduVPN&quot; command line.<br>
- This makes it load the settings from &quot;HKEY_LOCAL_MACHINE\SOFTWARE\<w=
br>OpenVPN$eduVPN&quot;<br>
<br>
We were careful to start the instance name with &quot;OpenVPN$&quot; becaus=
e:<br>
- We don&#39;t want to hide the OpenVPN interactive service official name/b=
rand.<br>
- Our version of interactive service is always listed next to the official =
OpenVPN&#39;s. In the registry and on the services.msc list.<br>
- Our registry key is adjacent to the official OpenVPN&#39;s.<br>
- $ is also used in Microsoft SQL Server as a delimiter.<br></blockquote><d=
iv><br></div><div>I like it: using &quot;OpenVPN&quot; as a kind of namespa=
ce also avoids name collision with</div><div>any other &#39;foobar&#39; ins=
talled in HKLM\Software\foobar</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
Using the APPNAME (&quot;openvpnserv&quot;) and merging with our instance n=
ame would make a Frankenstein &quot;openvpnservOpenVPN$eduVPN&quot; log ent=
ry. Not exactly elegant either.<br>
<br>
For v3 I shall redesign the code to use compile-time defined PACKAGE_NAME/P=
ACKAGE as the left part again, and only append the &quot;&quot; service_ins=
tance for official OpenVPN and &quot;$eduVPN&quot; for named instance.<br><=
/blockquote><div><br></div><div>Not sure I follow, but will wait for the pa=
tch. I suppose naming additional</div><div>instances as, say, &#39;foo&#39;=
 =C2=A0using the official package and have service pipe, exit</div><div>eve=
nt etc named after it and registry keys taken from HKLM\Software\foo will</=
div><div>still work.</div><div><br></div><div>In fact I like the current pa=
tch in that it allows installing even the official instance</div><div>as a =
named one with name =3D OpenVPN and thus decouples automatic and</div><div>=
interactive services. That makes it easy to avoid installing the legacy ser=
vice,</div><div>which I think no one uses anymore.</div><div>=C2=A0</div><d=
iv>Thanks,</div><div><br></div><div>Selva</div></div></div></div></div>

--94eb2c04422a3328cd055d7e09e2--

