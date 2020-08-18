MIME-Version: 1.0
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
 <20200818192104.GB75094@...1296...>
 <CAKuzo_h2hLeQodHsJ7uzetq_XeGPJiu3i-o2tXuL29HbJcG6bA@...278...>
 <20200818194248.GC75094@...1296...>
 <CAKuzo_jG-NOqD4wHZ1SL-2Ti5NgocUDzSOpV5yqMaTXZ2UXVrA@...278...>
In-Reply-To: <CAKuzo_jG-NOqD4wHZ1SL-2Ti5NgocUDzSOpV5yqMaTXZ2UXVrA@...278...>
From: Rafael Gava <gava100@...277...>
Date: Tue, 18 Aug 2020 19:30:12 -0300
Message-ID: <CAAWBBYPby1vNtcmqy32=jJbVO=vxaZuHphjR4UxJfS9pOAMc-Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000f133c305ad2e6e13"
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000f133c305ad2e6e13
Content-Type: text/plain; charset="UTF-8"

Hello Guys, sorry for the late reply.

Ok, I'll wait for the fix to retest.

Another question...

Inspecting the wintun interface through the properties I saw that on the
TCP/IPv4 Properties the default option selected is "Use the following IP
address" but the IP address and the Subnet mask were empty. Should that be
a problem?

BR

Rafael

On Tue, Aug 18, 2020 at 5:15 PM Selva Nair <selva.nair@...277...> wrote:

> Hi
>
> On Tue, Aug 18, 2020 at 3:42 PM Gert Doering <gert@...1296...> wrote:
>
>> Hi,
>>
>> On Tue, Aug 18, 2020 at 03:29:19PM -0400, Selva Nair wrote:
>> > > If you already have SYSTEM, accessing wintun from openvpn directly
>> will
>> > > also work and should bring quite a bit of speed improvement.
>> >
>> > I was wrong to assume that this just works. Looking at it again, the
>> current
>> > implementation of wintun support does not seem to cover this. Meaning
>> the
>> > only working approach is to use the interactive service.
>>
>> Indeed, you are right.  Somewhere on the track we lost the ability
>> to do wintun "from OpenVPN" if we *have* SYSTEM.
>>
>> This is the code in tun.c
>>
>>     if (tt->options.msg_channel)
>>     {
>>         ret = service_register_ring_buffers(tt);
>>     }
>>     else
>>     {
>>         msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and
>> therefore "
>>                      "should be used with interactive service. If you
>> want to "
>>                      "use openvpn from command line, you need to do
>> SYSTEM "
>>                      "elevation yourself (for example with psexec).");
>>     }
>>
>>
>> ... so while I'm happy that we got rid of impersonating SYSTEM, the
>> current
>> code does not even try anymore, just assumes "if there is no message
>> channel,
>> we have not enough privileges".
>>
>> OTOH the message is severely misleading now, since it suggests "having
>> the right privileges will make this work".
>>
>>
>> This needs fixing - either we *try*, and if we fail, print the message
>> about insufficient privileges, or we change the message to actually
>> print something like "Wintun support is only possible if the interactive
>> service is used.  Do not run from the CLI.  Use the GUI in non-admin
>> mode.".
>>
>
> We have all the necessary code to do "register ring buffers" that the
> service uses, so just calling it and printing that message on failure
> should fix it.
>
> Looks like something lost by Lev during a rebase or conflict resolution.
>
> Trac #1318
>
> Selva
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000f133c305ad2e6e13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Guys, sorry=C2=A0for the late reply=
.<div><br></div><div>Ok, I&#39;ll wait for the fix to retest.</div><div><br=
></div><div>Another question...</div><div><br></div><div>Inspecting the win=
tun interface through=C2=A0the properties I saw that on the TCP/IPv4 Proper=
ties the default option selected is &quot;Use the following IP address&quot=
; but the IP address and the Subnet mask were empty. Should that be a=C2=A0=
problem?</div><div><br></div><div>BR</div><div><br></div><div>Rafael</div><=
div><br></div><div>On Tue, Aug 18, 2020 at 5:15 PM Selva Nair &lt;<a href=
=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></d=
iv></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 3:42 PM Gert Doe=
ring &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1725...=
..</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi,<br>
<br>
On Tue, Aug 18, 2020 at 03:29:19PM -0400, Selva Nair wrote:<br>
&gt; &gt; If you already have SYSTEM, accessing wintun from openvpn directl=
y will<br>
&gt; &gt; also work and should bring quite a bit of speed improvement.<br>
&gt; <br>
&gt; I was wrong to assume that this just works. Looking at it again, the c=
urrent<br>
&gt; implementation of wintun support does not seem to cover this. Meaning =
the<br>
&gt; only working approach is to use the interactive service.<br>
<br>
Indeed, you are right.=C2=A0 Somewhere on the track we lost the ability<br>
to do wintun &quot;from OpenVPN&quot; if we *have* SYSTEM.<br>
<br>
This is the code in tun.c<br>
<br>
=C2=A0 =C2=A0 if (tt-&gt;options.msg_channel)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D service_register_ring_buffers(tt);<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;ERROR:=C2=A0 Wintun requires=
 SYSTEM privileges and therefore &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;should be used with interactive service. If you want to &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;use openvpn from command line, you need to do SYSTEM &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;elevation yourself (for example with psexec).&quot;);<br>
=C2=A0 =C2=A0 }<br>
<br>
<br>
... so while I&#39;m happy that we got rid of impersonating SYSTEM, the cur=
rent<br>
code does not even try anymore, just assumes &quot;if there is no message c=
hannel,<br>
we have not enough privileges&quot;.<br>
<br>
OTOH the message is severely misleading now, since it suggests &quot;having=
<br>
the right privileges will make this work&quot;.<br>
<br>
<br>
This needs fixing - either we *try*, and if we fail, print the message<br>
about insufficient privileges, or we change the message to actually<br>
print something like &quot;Wintun support is only possible if the interacti=
ve<br>
service is used.=C2=A0 Do not run from the CLI.=C2=A0 Use the GUI in non-ad=
min mode.&quot;.<br></blockquote><div><br></div><div>We have all the necess=
ary code to do &quot;register ring buffers&quot; that the=C2=A0</div><div>s=
ervice uses, so just calling it and printing that message on failure</div><=
div>should fix it.=C2=A0</div><div><br></div><div>Looks like something lost=
 by Lev during a rebase or conflict resolution.</div><div><br></div><div>Tr=
ac #1318</div><div><br></div><div>Selva=C2=A0</div></div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000f133c305ad2e6e13--

