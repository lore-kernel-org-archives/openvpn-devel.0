MIME-Version: 1.0
In-Reply-To: <b56a8658-5d18-6e51-b22f-c3c2f7022d2a@...2080...>
References: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
 <b56a8658-5d18-6e51-b22f-c3c2f7022d2a@...2080...>
From: Selva <selva.nair@...277...>
Date: Fri, 22 Sep 2017 12:55:08 -0400
Message-ID: <CAKuzo_h=npapZhtk8Wo79OdPe=4jgiYjp2d_+kWWeYetPPL6Cw@...278...>
Content-Type: multipart/alternative; boundary="001a113de9887f58f60559ca136d"
Subject: Re: [Openvpn-devel] Better error recognition and error/status
 reporting to the mgmt i/f
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113de9887f58f60559ca136d
Content-Type: text/plain; charset="UTF-8"

Hi David,

Thanks for taking time to look through this and for your well-considered
response.

Given that I may not remember the details when we get back to this topic,
let me add a few remarks.

On Thu, Sep 21, 2017 at 6:00 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 14/09/17 21:21, Selva wrote:
> > Hi,
>
> Hi Selva,
>
> Sorry for the long wait.  Things have been quite busy since that meeting.
>
> >
> > Quoting from the meeting logs:
> >
> >
> >     Discussed having more fine-grained signalling from OpenVPN to OpenVPN
> >     GUI. The lack of clear signals from OpenVPN to OpenVPN GUI has been a
> >     rather common problem:
> >
> >
> >
> >     <https://github.com/OpenVPN/openvpn-gui/issues/168#issuecom
> ment-305243166>
> >     <https://github.com/OpenVPN/openvpn-gui/issues/9>
> >     <https://github.com/OpenVPN/openvpn-gui/issues/183>
> >
> >
> >
> >     This problem is probably not limited to OpenVPN GUI (Windows), but
> also
> >     affects other GUI's like NetworkManager. It was agreed that the best
> >     approach is that Selva, mattock and others involved on the Windows
> side
> >     come up with a PoC or "RFC" of how this issue could be tackled ...
> >     OpenVPN core will then be modified if necessary.
> >
> >
> > No time to write an "RFC" or such for something of this sort, but here
> > are some comments/suggestions:
> >
> > 0. Do not send a status message that reads "CONNECTED, SUCCESS" to the
> > management when there has been critical errors such as: failed to add
> > routes or to set ipv6 address using the service or to talk to the
> > service, etc.. Send something like "CONNECTED,ERROR".
>
> I agree that "CONNECTED, SUCCESS" is wrong if routing or other network
> configuration related details fails.  On the other side,
> "CONNECTED,ERROR" have an interesting contradiction; almost sounds like
> an oxymoron.
>

FWIW, we do currently use "CONNECTED,ERROR" in some situations.
And, of late, the Windows GUI has learned not to bandy about the green
icon in such cases.

Not to say that this is good usage language-wise... Still better than
ERROR_SUCCESS which is the "error code" for success in WIndows API.


> I'd probably prefer something like "CONNECTED,PARTIAL_SUCCESS",
> "CONNECTED,SOME_FAILURES" or something similar.  But can easily tend
> towards a discussion of the colour of the bike shed.  As long as we have
> a clear understanding and documentation of these strings, we're good.
>

Even more fine grained info like CONNECTED,ROUTE_ERRORS etc could be
useful though not essential.


>
> > A status signalling with more fine-grained info to the management would
> > be helpful, but as a short-term fix, just changing SUCCESS to ERROR in
> > some cases may be a good start.
> >
> > 1. Mark all messages to the management as I (for info), W (for warning),
> > N (for non fatal error) etc. -- on some log lines this info is currently
> > missing. I think, part of the problem is not all messages are printed
> > with an M_xx flag.
>
> This sounds like a good idea.  But we need to sync-up with the Access
> Server team, to ensure we won't break anything there.
>

I looked further into this. It seems all messages that arrive without a
flag are
some kind of INFO messages. The problem is related to the fact that M_INFO
not a pure M_xx flag (it is loglevel 1 and M_x flag=0 combined) so it cant
be
x-ored with msg flags to find whether a message is INFO or not. Also the
Mx-flag bits for INFO being 0 makes it not testable by XOR.

Based on that I think all log messages that arrive in the management
without
a flag could be safely treated as some kind of INFO. Or, we could make
sure all messages with bits 4 to 23 of the flag not set (i.e. the M_xx flag
= 0)
are tagged as 'I'. Either would do.


>
> > 2. Mark non-fatal opevpn_execve errors as M_NONFATAL instead of M_WARN
>
> This needs a careful analysis to fully understand the consequences.
> There are quite some areas of the code where openvpn_execve_check() is
> used, which is the instance calling openvpn_execve().
>

I was going after the wrong suspect here. openvpn_execve is ok as is, as
its the caller which should decide what to do with errors. It is
 openvpn_execve_check that could use M_NONFATAL instead of
current M_WARN when instructed to continue after errors.

I do not see how changing the log message flag from WARN to
NONFATAL would affect anything else other than programs that parse
the logs.


> We have 70 direct callers of openvpn_execve_check(), but also
> openvpn_run_script() is used for the script hooks.  There might be a few
> more too.  And this covers also all supported platforms, which needs to
> be thoroughly tested.
>
> In addition, openvpn_execve_check() takes a flag argument, which
> controls if errors should be M_WARN or M_FATAL.


Yes, the flag it takes can only turn M_FATAL on or off so its up to it to
decide what to do when the flag is not set. It currently decides to treat
errros as warnings in such cases. Either we should give a finer control
to callers of  openvpn_execve_check or make it print M_NONFATAL.
Again this change looks benign.

But even that may not be enough in case of route errors is the trickier
issue.


> > 3. Treat failure to talk to the service (when msg_channnel is defined)
> > as M_NONFATAL not M_WARN
>
> Sounds reasonable.


> > 4. Mark route add/del errors via service as M_NONFATAL -- currently
> M_WARN.
> >  Mark route addition failure by other means as M_NONFATAL -- currently
> > M_WARN on all platforms, and all methods, I think.

This is somewhat related to 2), as the route manipulation happens via
> openvpn_execve_check().  I do think this needs to be handled in a
> platform agnostic approach and not have one set of error behaviour on
> Windows and another one of the other platforms.
>

> That said, at this years hackathon we will discuss a more thorough
> clean-up of the route.c and tun.c code.  So this issue here is something
> to bring into that discussion as well.
>
> > 5. Mark "ifconfig" (set address) errors as consistently M_FATAL or
> > M_NONFATAL (see comment on "fatality" below).
> > Currently these are M_WARN if done by service, M_FATAL otherwise.
> >
> > Given that M_FATAL should be used only very rarely, if at all --- e.g.,
> > if proceeding further makes no sense ---  most errors should be
> > M_NONFATAL. The above comments reflect that sentiment.
>
> M_FATAL is targeting scenarios where there is no point in continuing at
> all; where OpenVPN will not be able to recover on its own.  So I do
> understand that IP address configuration failing is initially tagged as
> M_FATAL.  But this is not as easy and clear when there is another tool
> OpenVPN needs to co-operate with which will manage parts of the tunnel.
> One of them have to be the final decision maker when to bail out and
> when to not do that.
>

The current approach of treating address configuration errors as FATAL looks
proper to me. If 'ifconfig' is delegated to scripts or to manual setting by
user, the
config file will have directives to that effect. Thus openvpn knows when it
is
responsible for setting the address and bailing out when it fails to do so
is
the right thing to do.


> > That said, whether address and route addition errors should be FATAL
> > deserves some discussion -- In case of address addition, an error
> > probably has to be FATAL, but "route add" failures are borderline cases.
> > E.g., if  "--redirect-gateway" fails, the tunnel may be  considered
> > meaningless in many use cases and thus a fatal error. So, some but not
> > all route-add errors may have to be treated as FATAL.
>
> This is the crux of it.  There is no way OpenVPN by itself knows
> beforehand when a route change is fatal or not.  This touches more some
> kind of policy handling, which needs to be configurable.  Right now it
> is more the kind of "best efforts" approach on the routing setup and
> "required" for the IP address configuration.
>

For many users the tunnel is dysfunctional unless proper routes are set up.
We need to treat route errors more seriously unless it is caused by "route
already exists". Agreed, whether route errors are to be treated as FATAL or
just an error does indeed need careful consideration. But a warning is
clearly
not enough.


>
> > If there is consensus, and an appetite for patch review, I can send in
> > some patches for 2 to 5 and possibly 1. For 0, I'm not sure how to keep
> > track of past errors to construct a useful status message.
>
> I think we all agree we need to improve this.  But how and at which
> scale is currently an open topic.  Right now, I think it is good to take
> some time to discuss and debate this issue.  Perhaps we should allocate
> one community developers meeting after the hackathon for discussing
> this.  I'm suggesting after the hackathon, to ensure we have some clear
> path forward on how we want to clean up route.c/tun.c.  This is a
> massive effort and I doubt it will be done too quickly, so once the have
> some path forward we should look into the error handling as well
> instantly afterwards.


Looking forward to more discussion on this.

Thanks again,

Selva

--001a113de9887f58f60559ca136d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<div><br></div><div>Thanks for taking time to loo=
k through this and for your well-considered</div><div>response.</div><div><=
br></div><div>Given that I may not remember the details when we get back to=
 this topic,</div><div>let me add a few remarks.</div><div><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">On Thu, Sep 21, 2017 at 6:00 PM, =
David <span id=3D"m_-4501866038878721015m_-1137554824929395369m_72084746048=
68634850:7y6.1"><span class=3D"" id=3D":8qs.1" tabindex=3D"-1">Sommerseth</=
span></span> <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." ta=
rget=3D"_blank"><span id=3D"m_-4501866038878721015m_-1137554824929395369m_7=
208474604868634850:7y6.2"><span class=3D"" id=3D":8qs.2" tabindex=3D"-1">op=
envpn</span></span>@sf.lists.<span id=3D"m_-4501866038878721015m_-113755482=
4929395369m_7208474604868634850:7y6.3"><span class=3D"" id=3D":8qs.3" tabin=
dex=3D"-1">topphemmelig</span></span><wbr>.net</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">On 14/09/17 21:21, Selva wrote:<br>
&gt; Hi,<br>
<br>
Hi Selva,<br>
<br>
Sorry for the long wait.=C2=A0 Things have been quite busy since that meeti=
ng.<br>
<span><br>
&gt;<br>
&gt; Quoting from the meeting logs:<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Discussed having more fine-grained signalling from =
OpenVPN to OpenVPN<br>
&gt;=C2=A0 =C2=A0 =C2=A0GUI. The lack of clear signals from OpenVPN to Open=
VPN GUI has been a<br>
&gt;=C2=A0 =C2=A0 =C2=A0rather common problem:<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/OpenVPN/openvpn-g=
ui/issues/168#issuecomment-305243166" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/OpenVPN/o<wbr>penvpn-gui/issues/168#issuecom<wbr>ment-30=
5243166</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/OpenVPN/openvpn-g=
ui/issues/9" rel=3D"noreferrer" target=3D"_blank">https://github.com/OpenVP=
N/o<wbr>penvpn-gui/issues/9</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/OpenVPN/openvpn-g=
ui/issues/183" rel=3D"noreferrer" target=3D"_blank">https://github.com/Open=
VPN/o<wbr>penvpn-gui/issues/183</a>&gt;<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This problem is probably not limited to OpenVPN GUI=
 (Windows), but also<br>
&gt;=C2=A0 =C2=A0 =C2=A0affects other GUI&#39;s like NetworkManager. It was=
 agreed that the best<br>
&gt;=C2=A0 =C2=A0 =C2=A0approach is that Selva, mattock and others involved=
 on the Windows side<br>
&gt;=C2=A0 =C2=A0 =C2=A0come up with a PoC or &quot;RFC&quot; of how this i=
ssue could be tackled ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenVPN core will then be modified if necessary.<br>
&gt;<br>
&gt;<br>
&gt; No time to write an &quot;RFC&quot; or such for something of this sort=
, but here<br>
&gt; are some comments/suggestions:<br>
&gt;<br>
&gt; 0. Do not send a status message that reads &quot;CONNECTED, SUCCESS&qu=
ot; to the<br>
&gt; management when there has been critical errors such as: failed to add<=
br>
&gt; routes or to set ipv6 address using the service or to talk to the<br>
&gt; service, etc.. Send something like &quot;CONNECTED,ERROR&quot;.<br>
<br>
</span>I agree that &quot;CONNECTED, SUCCESS&quot; is wrong if routing or o=
ther network<br>
configuration related details fails.=C2=A0 On the other side,<br>
&quot;CONNECTED,ERROR&quot; have an interesting contradiction; almost sound=
s like<br>
an oxymoron.<br></blockquote><div><br></div><div><span id=3D"m_-45018660388=
78721015m_-1137554824929395369m_7208474604868634850:7y6.4"><span class=3D""=
 id=3D":8qs.4" tabindex=3D"-1">FWIW</span></span>, we do currently use &quo=
t;CONNECTED,ERROR&quot; in some situations.</div><div>And, of late, the Win=
dows GUI has <span class=3D"" id=3D":8qs.5" tabindex=3D"-1">learned</span> =
not to bandy about the green</div><div>icon in such cases.</div><div><br></=
div><div>Not to say that this is good usage language-wise... Still better t=
han</div><div>ERROR_SUCCESS which is the &quot;error code&quot; for success=
 in <span id=3D"m_-4501866038878721015m_-1137554824929395369m_7208474604868=
634850:7y6.5"><span class=3D"" id=3D":8qs.6" tabindex=3D"-1">WIndows</span>=
</span> API.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I&#39;d probably prefer something like &quot;CONNECTED,PARTIAL_SUCCESS&quot=
;,<br>
&quot;CONNECTED,SOME_FAILURES&quot; or something similar.=C2=A0 But can eas=
ily tend<br>
towards a discussion of the colour of the bike shed.=C2=A0 As long as we ha=
ve<br>
a clear understanding and documentation of these strings, we&#39;re good.<b=
r></blockquote><div><br></div><div>Even more fine grained info like CONNECT=
ED,ROUTE_ERRORS etc could be</div><div>useful though not essential.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
<span><br>
&gt; A status signalling with more fine-grained info to the management woul=
d<br>
&gt; be helpful, but as a short-term fix, just changing SUCCESS to ERROR in=
<br>
&gt; some cases may be a good start.<br>
&gt; =C2=A0<br>
&gt; 1. Mark all messages to the management as I (for info), W (for warning=
),<br>
&gt; N (for non fatal error) etc. -- on some log lines this info is current=
ly<br>
&gt; missing. I think, part of the problem is not all messages are printed<=
br>
&gt; with an M_xx flag.<br>
<br>
</span>This sounds like a good idea.=C2=A0 But we need to sync-up with the =
Access<br>
Server team, to ensure we won&#39;t break anything there.<br></blockquote><=
div><br></div><div>I looked further into this. It seems all messages that a=
rrive without a flag are</div><div>some kind of INFO messages. The problem =
is related to the fact that M_INFO</div><div>not a pure M_xx flag (it is=C2=
=A0<span id=3D"m_-4501866038878721015m_-1137554824929395369m_72084746048686=
34850:7y6.6"><span class=3D"" id=3D":8qs.7" tabindex=3D"-1">loglevel</span>=
</span> 1 and M_x flag=3D0 combined) so it cant be=C2=A0</div><div>x-<span =
id=3D"m_-4501866038878721015m_-1137554824929395369m_7208474604868634850:7y6=
.7"><span class=3D"" id=3D":8qs.8" tabindex=3D"-1">ored</span></span> with =
<span id=3D"m_-4501866038878721015m_-1137554824929395369m_72084746048686348=
50:7y6.8"><span class=3D"" id=3D":8qs.9" tabindex=3D"-1">msg</span></span> =
flags to find whether a message is INFO or not. Also the</div><div><span cl=
ass=3D"" id=3D":8qs.10" tabindex=3D"-1">Mx</span>-flag bits for INFO being =
0 makes it not <span style=3D"background-color:rgb(255,255,0)">testable</sp=
an>=C2=A0by XOR.</div><div><br></div><div>Based on that I think all log mes=
sages that arrive in the management without=C2=A0</div><div>a flag could be=
 safely treated as some kind of INFO. Or, we could make</div><div>sure all =
messages with bits 4 to 23 of the flag not set (i.e. the M_xx flag =3D 0)</=
div><div>are tagged as &#39;I&#39;. Either would do.</div><div>=C2=A0=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<span><br>
&gt; 2. Mark non-fatal=C2=A0opevpn_execve=C2=A0errors as M_NONFATAL instead=
 of M_WARN =C2=A0<br>
<br>
</span>This needs a careful analysis to fully understand the consequences.<=
br>
There are quite some areas of the code where openvpn_execve_check() is<br>
used, which is the instance calling openvpn_execve().<br></blockquote><div>=
<br></div><div>I was going after the wrong suspect here. <span class=3D"" i=
d=3D":8qs.12" tabindex=3D"-1">openvpn</span>_<span class=3D"" id=3D":8qs.13=
" tabindex=3D"-1">execve</span> is <span class=3D"" id=3D":8qs.14" tabindex=
=3D"-1">ok</span> as is, as</div><div>its the caller which should decide wh=
at to do with errors. It is=C2=A0</div><div>=C2=A0<span class=3D"" id=3D":8=
qs.15" tabindex=3D"-1">openvpn</span>_<span class=3D"" id=3D":8qs.16" tabin=
dex=3D"-1">execve</span>_check that could use M_NONFATAL instead of</div><d=
iv>current M_WARN when instructed to continue after errors.</div><div><br><=
/div><div>I do not see how changing the log message flag from WARN to=C2=A0=
</div><div>NONFATAL would affect anything else other than programs that par=
se</div><div>the logs.</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
We have 70 direct callers of openvpn_execve_check(), but also<br>
openvpn_run_script() is used for the script hooks.=C2=A0 There might be a f=
ew<br>
more too.=C2=A0 And this covers also all supported platforms, which needs t=
o<br>
be thoroughly tested.<br>
<br>
In addition, openvpn_execve_check() takes a flag argument, which<br>
controls if errors should be M_WARN or M_FATAL.</blockquote><div><br></div>=
<div>Yes, the flag it takes can only <span class=3D"" id=3D":8qs.17" tabind=
ex=3D"-1">turn M_</span>FATAL on or off so its up to it to</div><div>decide=
 what to do when the flag is not set. It currently decides to treat=C2=A0</=
div><div><span class=3D"" id=3D":8qs.18" tabindex=3D"-1">errros</span> as w=
arnings in such cases. Either we should give a finer control</div><div>to c=
allers of =C2=A0<span class=3D"" id=3D":8qs.19" tabindex=3D"-1">openvpn</sp=
an>_<span class=3D"" id=3D":8qs.20" tabindex=3D"-1">execve</span>_check or =
make it print M_NONFATAL.</div><div>Again this change looks benign.</div><d=
iv><br></div><div>But even that may not be enough in case of route errors i=
s the trickier</div><div>issue.</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<span><br>
&gt; 3. Treat failure to talk to the service (when=C2=A0msg_channnel=C2=A0i=
s defined)<br>
&gt; as M_NONFATAL not M_WARN<br>
<br>
</span>Sounds reasonable.</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span><br>
&gt; 4. Mark route add/del=C2=A0errors via service as M_NONFATAL -- current=
ly M_WARN.<br>
&gt; =C2=A0Mark route addition failure by other means as M_NONFATAL -- curr=
ently<br>
&gt; M_WARN on all platforms, and all methods, I think.</span></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This is somewhat related to 2), as the route=
 manipulation happens via<br>
openvpn_execve_check().=C2=A0 I do think this needs to be handled in a<br>
platform agnostic approach and not have one set of error behaviour on<br>
Windows and another one of the other platforms.<br></blockquote><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><br>
That said, at this years hackathon we will discuss a more thorough<br>
clean-up of the route.c and tun.c code.=C2=A0 So this issue here is somethi=
ng<br>
to bring into that discussion as well.<br>
<span><br>
&gt; 5. Mark &quot;ifconfig&quot; (set address) errors as consistently M_FA=
TAL or<br>
&gt; M_NONFATAL (see comment on &quot;fatality&quot; below).<br>
&gt; Currently these are M_WARN if done by service, M_FATAL otherwise.<br>
&gt;<br>
&gt; Given that M_FATAL should be used only very rarely, if at all --- e.g.=
,<br>
&gt; if proceeding further makes no sense --- =C2=A0most errors should be<b=
r>
&gt; M_NONFATAL. The above comments reflect that sentiment.<br>
<br>
</span>M_FATAL is targeting scenarios where there is no point in continuing=
 at<br>
all; where OpenVPN will not be able to recover on its own.=C2=A0 So I do<br>
understand that IP address configuration failing is initially tagged as<br>
M_FATAL.=C2=A0 But this is not as easy and clear when there is another tool=
<br>
OpenVPN needs to co-operate with which will manage parts of the tunnel.<br>
One of them have to be the final decision maker when to bail out and<br>
when to not do that.<br></blockquote><div><br></div><div>The current approa=
ch of treating address configuration errors as FATAL looks</div><div>proper=
 to me. If &#39;ifconfig&#39; is delegated to scripts or to manual setting =
by user, the=C2=A0</div><div><span id=3D"m_-4501866038878721015m_-113755482=
4929395369m_7208474604868634850:7y6.17"><span class=3D"" id=3D":8qs.21" tab=
index=3D"-1">config</span></span>=C2=A0file will have directives to that ef=
fect. Thus <span id=3D"m_-4501866038878721015m_-1137554824929395369m_720847=
4604868634850:7y6.18"><span class=3D"" id=3D":8qs.22" tabindex=3D"-1">openv=
pn</span></span> knows when it is</div><div>responsible for setting the add=
ress and bailing out when it fails to do so is</div><div>the right thing to=
 do.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span><br>
&gt; That said, whether address and route addition errors should be FATAL<b=
r>
&gt; deserves some discussion -- In case of address addition, an error<br>
&gt; probably has to be FATAL, but &quot;route add&quot; failures are borde=
rline cases.<br>
&gt; E.g., if =C2=A0&quot;--redirect-gateway&quot; fails, the tunnel may be=
 =C2=A0considered<br>
&gt; meaningless in many use cases and thus a fatal error. So, some but not=
<br>
&gt; all route-add errors may have to be treated as FATAL.=C2=A0<br>
<br>
</span>This is the crux of it.=C2=A0 There is no way OpenVPN by itself know=
s<br>
beforehand when a route change is fatal or not.=C2=A0 This touches more som=
e<br>
kind of policy handling, which needs to be configurable.=C2=A0 Right now it=
<br>
is more the kind of &quot;best efforts&quot; approach on the routing setup =
and<br>
&quot;required&quot; for the IP address configuration.<br></blockquote><div=
><br></div><div>For many users the tunnel is dysfunctional unless proper ro=
utes are set up.=C2=A0<br></div><div>We need to treat route errors more ser=
iously unless it is caused by &quot;route</div><div>already exists&quot;. A=
greed, whether route errors are to be treated as FATAL or</div><div>just an=
 error does indeed need careful consideration. But a warning is clearly</di=
v><div>not enough.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span><br>
&gt; If there is consensus, and an appetite for patch review, I can send in=
<br>
&gt; some patches for 2 to 5 and possibly 1. For 0, I&#39;m not sure how to=
 keep<br>
&gt; track of past errors to construct a useful status message.<br>
<br>
</span>I think we all agree we need to improve this.=C2=A0 But how and at w=
hich<br>
scale is currently an open topic.=C2=A0 Right now, I think it is good to ta=
ke<br>
some time to discuss and debate this issue.=C2=A0 Perhaps we should allocat=
e<br>
one community developers meeting after the hackathon for discussing<br>
this.=C2=A0 I&#39;m suggesting after the hackathon, to ensure we have some =
clear<br>
path forward on how we want to clean up route.c/tun.c.=C2=A0 This is a<br>
massive effort and I doubt it will be done too quickly, so once the have<br>
some path forward we should look into the error handling as well<br>
instantly afterwards.</blockquote><div><br></div><div>Looking forward to mo=
re discussion on this.</div><div><br></div><div>Thanks again,</div><div><br=
></div><div><span class=3D"" id=3D":8qs.23" tabindex=3D"-1">Selva</span></d=
iv></div></div></div></div>

--001a113de9887f58f60559ca136d--

