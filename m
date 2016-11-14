MIME-Version: 1.0
In-Reply-To: <7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
	<20161112150047.GE28918@...1296...>
	<7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
From: Marvin <volleynbike@...277...>
Date: Mon, 14 Nov 2016 10:44:04 -0800
Message-ID: <CAAF3xa8tOSm2uFP3TMcUL4hnmHUst5PnBHK=WgKTjtK=_yietQ@...278...>
Content-Type: multipart/alternative; boundary=001a113f29ee7084d805414739cf
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "<openvpn-devel@lists.sourceforge.net>" <openvpn-devel@lists.sourceforge.net>

--001a113f29ee7084d805414739cf
Content-Type: text/plain; charset=UTF-8

A User's perspective:
We run OpenVPN on some 2500 systems in a (unmanned) client-server config
(we're the ones hoping to someday see Gava's client-nat and ftp-nat patches
included).  Long ago we came up with a brute force workaround to the
service restart issue -- a script that pings back to a node behind our
server, if no reply then restart service.  Not pretty, but it has worked
for us over many years.  I'm happy to see the issue being addressed now
within the source for the new versions.

>>what is a reasonable delay?
Our experience says 3 minutes.

>>under which conditions should systemd restart the server?
Our votes:
>>- on-failure?
Yes.

>>- on-abnormal?
Yes.

>>- on-abort?
Yes.

>>- always?
I am of the opinion that this IS workable, at least in our scenario
(unmanned clients).  For us, the most common reason for connection failure
is some network change or blockage at the remote site -- but it is not
always so.  For us, having it continue to retry is important for
troubleshooting, even if it is our fault because we did something stupid
such as configuration errors (e.g. typos in the .ovpn etc.)

Hope this helps,
Marvin Adeff

On Mon, Nov 14, 2016 at 2:44 AM, David Sommerseth <
openvpn@...2080...> wrote:

> On 12/11/16 16:00, Gert Doering wrote:
> > Hi,
> >
> > On Fri, Nov 11, 2016 at 01:35:57PM +0100, David Sommerseth wrote:
> >> We can of course investigate if we should enable systemd to restart
> >> OpenVPN, at least the server profile, if it dies unexpectedly.
> >> Currently, I am not fully convinced we want that.
> >
> > I think this would be useful to have.  Server processes are expected to
> > be there - if they are not, it needs to be investigated why not, but
> > with some reasonable delay, they should be restarted.
>
> Let's take the easiest part first ... what is a reasonable delay?
> RestartSec= defines how long systemd should wait before restarting the
> service.  Default is 100ms.  Would 30 seconds, 1 minute, 5 minutes, 15
> minutes or 1 hour be a reasonable delay?  Or another value?  I honestly
> don't know.
>
>
> So to the slightly harder part ... under which conditions should systemd
> restart the server?  The Restart= setting can have a few alternatives.
>
> - on-success?  Only when openvpn exits with exit code 0.  Probably not.
>
> - on-failure?  When openvpn exits with exit code != 0 or "unclean"
>                exit signals. [1] Probably.
>
> - on-abnormal? When openvpn is killed by a signal, a timeout event or
>                watchdog timeout event happens. [1] Perhaps.
>
> - on-abort?    Only when an uncaught signal not considered as a "clean
>                exit" occurs.  Perhaps.
>
> - on-watchdog? Only when a watchdog timeout occurs.  Most likely not.
>
> - always?      Whenever OpenVPN stops running regardless of reason
>                why it stopped, it will be restarted.  Most likely not
>                what we want.
>
> - no?          This is the default, which we already have.
>
> And you can only choose one of these alternatives.
>
> In regards to those triggers including a watchdog, that needs the
> OpenVPN process to signal to the systemd daemon that it will provide a
> watchdog signal.  So unless we add that in our OpenVPN code, watchdog is
> not relevant for us.
>
> The systemd.service man page [2] recommends:
>
>     Setting this to on-failure is the recommended
>     choice for long-running services, in order to
>     increase reliability by attempting automatic
>     recovery from errors. For services that shall
>     be able to terminate on their own choice (and
>     avoid immediate restarting), on-abnormal is an
>     alternative choice.
>
> [1] Also includes terminated by signal, including core dump but excludes
>     SIGHUP, SIGINT, SIGTERM adn SIGPIPE (those four signals are
>     considered clean exits)
>
> [2]
> <https://www.freedesktop.org/software/systemd/man/systemd.
> service.html#Restart=>
>
>
> > (I thought this was what systemd was all about?  "Because sysvinit cannot
> > restart stuff!" - which was never true, but standard rc.d scripts do not
> > support it)
>
> Flame bait?  ;-)
>
> I don't know exactly why this isn't enabled by default, but there are
> probably plenty of reasons.  One could be that because the vast majority
> of rc.d scripts don't do this, so it would be a very unexpected change
> for very many services and/or sys-admins.  As you see from above, the
> feature is easily available, fairly flexible and it is far easier to
> enable it than adding extra code to an rc.d script.
>
> For the "this was what systemd was all about?" ... not just this, but it
> is one area of all the stuff systemd wants to improve or simplify.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>
> ------------------------------------------------------------
> ------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a113f29ee7084d805414739cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A User&#39;s perspective:<div>We run OpenVPN on some 2500 =
systems in a (unmanned) client-server config (we&#39;re the ones hoping to =
someday see Gava&#39;s client-nat and ftp-nat patches included).=C2=A0 Long=
 ago we came up with a brute force workaround to the service restart issue =
-- a script that pings back to a node behind our server, if no reply then r=
estart service.=C2=A0 Not pretty, but it has worked for us over many years.=
=C2=A0 I&#39;m happy to see the issue being addressed now within the source=
 for the new versions.</div><div><br></div><div>&gt;&gt;what is a reasonabl=
e delay?</div><div>Our experience says 3 minutes.</div><div><br></div><div>=
&gt;&gt;under which conditions should systemd restart the server?</div><div=
>Our votes:</div><div>&gt;&gt;- on-failure?</div><div>Yes.</div><div><br></=
div><div>&gt;&gt;- on-abnormal?</div><div>Yes.</div><div><br></div><div>&gt=
;&gt;- on-abort?</div><div>Yes.</div><div><br></div><div>&gt;&gt;- always?<=
/div><div>I am of the opinion that this IS workable, at least in our scenar=
io (unmanned clients).=C2=A0 For us, the most common reason for connection =
failure is some network change or blockage at the remote site -- but it is =
not always so.=C2=A0 For us, having it continue to retry is important for t=
roubleshooting, even if it is our fault because we did something stupid suc=
h as configuration errors (e.g. typos in the .ovpn etc.)</div><div><br></di=
v><div>Hope this helps,</div><div>Marvin Adeff</div><div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Mon, Nov 14, 2016 at 2:44 AM, Da=
vid Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." =
target=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">On 12/11/16 16:=
00, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Fri, Nov 11, 2016 at 01:35:57PM +0100, David Sommerseth wrote:<br>
&gt;&gt; We can of course investigate if we should enable systemd to restar=
t<br>
&gt;&gt; OpenVPN, at least the server profile, if it dies unexpectedly.<br>
&gt;&gt; Currently, I am not fully convinced we want that.<br>
&gt;<br>
&gt; I think this would be useful to have.=C2=A0 Server processes are expec=
ted to<br>
&gt; be there - if they are not, it needs to be investigated why not, but<b=
r>
&gt; with some reasonable delay, they should be restarted.<br>
<br>
</span>Let&#39;s take the easiest part first ... what is a reasonable delay=
?<br>
RestartSec=3D defines how long systemd should wait before restarting the<br>
service.=C2=A0 Default is 100ms.=C2=A0 Would 30 seconds, 1 minute, 5 minute=
s, 15<br>
minutes or 1 hour be a reasonable delay?=C2=A0 Or another value?=C2=A0 I ho=
nestly<br>
don&#39;t know.<br>
<br>
<br>
So to the slightly harder part ... under which conditions should systemd<br>
restart the server?=C2=A0 The Restart=3D setting can have a few alternative=
s.<br>
<br>
- on-success?=C2=A0 Only when openvpn exits with exit code 0.=C2=A0 Probabl=
y not.<br>
<br>
- on-failure?=C2=A0 When openvpn exits with exit code !=3D 0 or &quot;uncle=
an&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit signals. [1] Pr=
obably.<br>
<br>
- on-abnormal? When openvpn is killed by a signal, a timeout event or<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0watchdog timeout eve=
nt happens. [1] Perhaps.<br>
<br>
- on-abort?=C2=A0 =C2=A0 Only when an uncaught signal not considered as a &=
quot;clean<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit&quot; occurs.=
=C2=A0 Perhaps.<br>
<br>
- on-watchdog? Only when a watchdog timeout occurs.=C2=A0 Most likely not.<=
br>
<br>
- always?=C2=A0 =C2=A0 =C2=A0 Whenever OpenVPN stops running regardless of =
reason<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0why it stopped, it w=
ill be restarted.=C2=A0 Most likely not<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0what we want.<br>
<br>
- no?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This is the default, which we alrea=
dy have.<br>
<br>
And you can only choose one of these alternatives.<br>
<br>
In regards to those triggers including a watchdog, that needs the<br>
OpenVPN process to signal to the systemd daemon that it will provide a<br>
watchdog signal.=C2=A0 So unless we add that in our OpenVPN code, watchdog =
is<br>
not relevant for us.<br>
<br>
The systemd.service man page [2] recommends:<br>
<br>
=C2=A0 =C2=A0 Setting this to on-failure is the recommended<br>
=C2=A0 =C2=A0 choice for long-running services, in order to<br>
=C2=A0 =C2=A0 increase reliability by attempting automatic<br>
=C2=A0 =C2=A0 recovery from errors. For services that shall<br>
=C2=A0 =C2=A0 be able to terminate on their own choice (and<br>
=C2=A0 =C2=A0 avoid immediate restarting), on-abnormal is an<br>
=C2=A0 =C2=A0 alternative choice.<br>
<br>
[1] Also includes terminated by signal, including core dump but excludes<br>
=C2=A0 =C2=A0 SIGHUP, SIGINT, SIGTERM adn SIGPIPE (those four signals are<b=
r>
=C2=A0 =C2=A0 considered clean exits)<br>
<br>
[2]<br>
&lt;<a href=3D"https://www.freedesktop.org/software/systemd/man/systemd.ser=
vice.html#Restart=3D" rel=3D"noreferrer" target=3D"_blank">https://www.free=
desktop.org/<wbr>software/systemd/man/systemd.<wbr>service.html#Restart=3D<=
/a>&gt;<br>
<span class=3D"gmail-"><br>
<br>
&gt; (I thought this was what systemd was all about?=C2=A0 &quot;Because sy=
svinit cannot<br>
&gt; restart stuff!&quot; - which was never true, but standard rc.d scripts=
 do not<br>
&gt; support it)<br>
<br>
</span>Flame bait?=C2=A0 ;-)<br>
<br>
I don&#39;t know exactly why this isn&#39;t enabled by default, but there a=
re<br>
probably plenty of reasons.=C2=A0 One could be that because the vast majori=
ty<br>
of rc.d scripts don&#39;t do this, so it would be a very unexpected change<=
br>
for very many services and/or sys-admins.=C2=A0 As you see from above, the<=
br>
feature is easily available, fairly flexible and it is far easier to<br>
enable it than adding extra code to an rc.d script.<br>
<br>
For the &quot;this was what systemd was all about?&quot; ... not just this,=
 but it<br>
is one area of all the stuff systemd wants to improve or simplify.<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</div></div><br>------------------------------<wbr>------------------------=
------<wbr>------------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today. <a href=3D"http://sdm.link/xeonphi" rel=3D"noref=
errer" target=3D"_blank">http://sdm.link/xeonphi</a><br>___________________=
___________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div></div>

--001a113f29ee7084d805414739cf--

