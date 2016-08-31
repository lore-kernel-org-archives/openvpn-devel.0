MIME-Version: 1.0
In-Reply-To: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 1 Sep 2016 00:37:11 +0500
Message-ID: <CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
Content-Type: multipart/alternative; boundary=001a11442290480288053b63395d
Subject: Re: [Openvpn-devel] Modernising the management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11442290480288053b63395d
Content-Type: text/plain; charset=UTF-8

I'd bet many people would like to see REST here

2016-08-31 23:55 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

>
> Hi,
>
> I have for a long time pondered on how we can make the management API
> more suitable for more modern tools and tasks.  So I am just giving an
> extremely early heads-up on on what I'm poking at ... and hopefully
> receive some feedbacks on what you think.
>
> One of the things which have struck me is that D-Bus is adopted a lot
> of places, and its internal API have been considered stable for about
> 10 years or more.  Even though there are areas where D-Bus seems a bit
> over-engineered, it has proved to be a very useful IPC mechanism for a
> lot of software.
>
> Currently, each tool and application who wants to integrate with the
> management API today, needs to write their own TCP connect code and
> implement various methods to send, receive and parse the data to and
> from the management interface.  And the management interface doesn't
> scale well if you want to add support for more advanced management.
>
> Yes, the current interface solves most of today's challenges
> reasonably well.  But I believe it can be improved so that it can be
> even more flexible and more easily integrable with various set of
> management tools.
>
>
> * Why D-Bus?
> It provides a standardised API with integrations to most programming
> and scripting languages.  It is asynchronous and it you can both send
> messages but also have management tools act upon signals the
> application sends.  The way messages are sent are standardised, and
> all the connectivity and data exchange is covered by the D-Bus
> libraries.  Even data types are standardised and there is type safety
> on all data exchanged in a D-Bus message.
>
> D-Bus is also pretty much installed by default on any modern Linux
> distribution today.  And as far as I have seen, it exists on most
> POSIX based platforms.  I am somewhat uncertain on the Windows and
> macOS side, though.  More on that towards the end.
>
>
> * How will a D-Bus improve OpenVPN?
>
> With D-Bus we can provide a better integration towards GUIs as well as
> other management tools.  OpenVPN can much more easy alert D-Bus
> listeners about things which requires attention.  And we can more
> easily extend the management interface to also cover more areas of
> OpenVPN more easily, as D-Bus will describe the API through its
> built-in introspection.
>
> This can also enable us to provide plug-ins to be managed via the
> management interface, where each plug-in can individually provide it's
> own API without requiring any changes to the OpenVPN core.  The
> plug-in just needs to provide an init call which tells the OpenVPN
> server it has D-Bus support, and introspection takes care of providing
> the proper message passing from a management client down to the
> plug-in itself.
>
> And it can enabled more modern and advanced management tools to be
> integrated more easily with OpenVPN.  For example the Cockpit
> project[1] is a a web based management interface for Linux systems
> with systemd.  Cockpit depends entirely on D-Bus to do the management.
>  Writing a new module in Cockpit requires only to write a module
> covering the D-Bus methods defined in OpenVPN, the presentation and
> interaction is covered by the Cockpit framework.  A demo how to
> implement setting the time zone as a Cockpit module can be seen here[2].
>
> [1] <http://cockpit-project.org/>
> [2] <https://www.youtube.com/watch?v=97l1qf2sZtk&feature=youtu.be&t=1754>
>
> Other features where this can be useful is to provide D-Bus signals
> when users log in and out for audit purposes.  It is possible to add
> methods where you can set thresholds on bytes sent/received or how
> long a session have been running, and then send a signal when those
> thresholds are reached; then a management tool can decide what to do
> when these signals happens.  As a Cockpit feature, could be to list
> all connected VPN clients on a Cockpit enabled OpenVPN server, and
> have a button kick them out or otherwise manage these VPN clients.
>
> Many of these things requires today a poll mechanism which doesn't
> scale too well as only one instance can be connected to the management
> API today.  With D-Bus you can have many instances connected to the
> interfaces OpenVPN would provide at the same time - which again
> simplifies implementing new management tools for OpenVPN.
>
> Similar D-Bus interfaces will also be added to the OpenVPN 3 codebase
> when that arrives, which should help migration between OpenVPN 2 and
> OpenVPN 3 setups as well.
>
>
> * What comes next?
>
> Right now I am digging into the whole feature set of the management
> interface and wrapping my head around how this could look like through
> a D-Bus interface.
>
> The next thing I am will do is to provide some proof-of-concept code,
> which first will just connect to today's management API and be a
> broker between OpenVPN and D-Bus.  This won't scale well, but it will
> at least give something we can play with.
>
> Then comes the job of implementing D-Bus natively into OpenVPN and
> then start to provide more advanced features over D-Bus which today is
> be harder to achieve.  This will be an iterative process.
>
> But ... It would be very useful to get some input from especially
> macOS and Windows developers on how the state of D-Bus are on those
> platforms.  AFAIK, D-Bus is available on most *BSD platforms, so that
> shouldn't be an issue.
>
> It is not being planned to remove the management interface.  If D-Bus
> works well for everyone on all platforms, then we can discuss what to
> do next.  But as of now, I have no plans to remove this part of the code.
>
> And of course ... plenty of discussions along the road :)  But I chose
> to start this discussion in the public before actually starting to
> coding and submitting patches - just as a heads up and to get feedback
> before moving on further.
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
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11442290480288053b63395d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d bet many people would like to see REST here<br></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-08-31 23:=
55 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openv=
pn@...2080..." target=3D"_blank">openvpn@...2080...</a>&gt;</span>:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><br>
Hi,<br>
<br>
I have for a long time pondered on how we can make the management API<br>
more suitable for more modern tools and tasks.=C2=A0 So I am just giving an=
<br>
extremely early heads-up on on what I&#39;m poking at ... and hopefully<br>
receive some feedbacks on what you think.<br>
<br>
One of the things which have struck me is that D-Bus is adopted a lot<br>
of places, and its internal API have been considered stable for about<br>
10 years or more.=C2=A0 Even though there are areas where D-Bus seems a bit=
<br>
over-engineered, it has proved to be a very useful IPC mechanism for a<br>
lot of software.<br>
<br>
Currently, each tool and application who wants to integrate with the<br>
management API today, needs to write their own TCP connect code and<br>
implement various methods to send, receive and parse the data to and<br>
from the management interface.=C2=A0 And the management interface doesn&#39=
;t<br>
scale well if you want to add support for more advanced management.<br>
<br>
Yes, the current interface solves most of today&#39;s challenges<br>
reasonably well.=C2=A0 But I believe it can be improved so that it can be<b=
r>
even more flexible and more easily integrable with various set of<br>
management tools.<br>
<br>
<br>
* Why D-Bus?<br>
It provides a standardised API with integrations to most programming<br>
and scripting languages.=C2=A0 It is asynchronous and it you can both send<=
br>
messages but also have management tools act upon signals the<br>
application sends.=C2=A0 The way messages are sent are standardised, and<br>
all the connectivity and data exchange is covered by the D-Bus<br>
libraries.=C2=A0 Even data types are standardised and there is type safety<=
br>
on all data exchanged in a D-Bus message.<br>
<br>
D-Bus is also pretty much installed by default on any modern Linux<br>
distribution today.=C2=A0 And as far as I have seen, it exists on most<br>
POSIX based platforms.=C2=A0 I am somewhat uncertain on the Windows and<br>
macOS side, though.=C2=A0 More on that towards the end.<br>
<br>
<br>
* How will a D-Bus improve OpenVPN?<br>
<br>
With D-Bus we can provide a better integration towards GUIs as well as<br>
other management tools.=C2=A0 OpenVPN can much more easy alert D-Bus<br>
listeners about things which requires attention.=C2=A0 And we can more<br>
easily extend the management interface to also cover more areas of<br>
OpenVPN more easily, as D-Bus will describe the API through its<br>
built-in introspection.<br>
<br>
This can also enable us to provide plug-ins to be managed via the<br>
management interface, where each plug-in can individually provide it&#39;s<=
br>
own API without requiring any changes to the OpenVPN core.=C2=A0 The<br>
plug-in just needs to provide an init call which tells the OpenVPN<br>
server it has D-Bus support, and introspection takes care of providing<br>
the proper message passing from a management client down to the<br>
plug-in itself.<br>
<br>
And it can enabled more modern and advanced management tools to be<br>
integrated more easily with OpenVPN.=C2=A0 For example the Cockpit<br>
project[1] is a a web based management interface for Linux systems<br>
with systemd.=C2=A0 Cockpit depends entirely on D-Bus to do the management.=
<br>
=C2=A0Writing a new module in Cockpit requires only to write a module<br>
covering the D-Bus methods defined in OpenVPN, the presentation and<br>
interaction is covered by the Cockpit framework.=C2=A0 A demo how to<br>
implement setting the time zone as a Cockpit module can be seen here[2].<br>
<br>
[1] &lt;<a href=3D"http://cockpit-project.org/" rel=3D"noreferrer" target=
=3D"_blank">http://cockpit-project.org/</a>&gt;<br>
[2] &lt;<a href=3D"https://www.youtube.com/watch?v=3D97l1qf2sZtk&amp;featur=
e=3Dyoutu.be&amp;t=3D1754" rel=3D"noreferrer" target=3D"_blank">https://www=
.youtube.com/<wbr>watch?v=3D97l1qf2sZtk&amp;feature=3D<wbr>youtu.be&amp;t=
=3D1754</a>&gt;<br>
<br>
Other features where this can be useful is to provide D-Bus signals<br>
when users log in and out for audit purposes.=C2=A0 It is possible to add<b=
r>
methods where you can set thresholds on bytes sent/received or how<br>
long a session have been running, and then send a signal when those<br>
thresholds are reached; then a management tool can decide what to do<br>
when these signals happens.=C2=A0 As a Cockpit feature, could be to list<br>
all connected VPN clients on a Cockpit enabled OpenVPN server, and<br>
have a button kick them out or otherwise manage these VPN clients.<br>
<br>
Many of these things requires today a poll mechanism which doesn&#39;t<br>
scale too well as only one instance can be connected to the management<br>
API today.=C2=A0 With D-Bus you can have many instances connected to the<br>
interfaces OpenVPN would provide at the same time - which again<br>
simplifies implementing new management tools for OpenVPN.<br>
<br>
Similar D-Bus interfaces will also be added to the OpenVPN 3 codebase<br>
when that arrives, which should help migration between OpenVPN 2 and<br>
OpenVPN 3 setups as well.<br>
<br>
<br>
* What comes next?<br>
<br>
Right now I am digging into the whole feature set of the management<br>
interface and wrapping my head around how this could look like through<br>
a D-Bus interface.<br>
<br>
The next thing I am will do is to provide some proof-of-concept code,<br>
which first will just connect to today&#39;s management API and be a<br>
broker between OpenVPN and D-Bus.=C2=A0 This won&#39;t scale well, but it w=
ill<br>
at least give something we can play with.<br>
<br>
Then comes the job of implementing D-Bus natively into OpenVPN and<br>
then start to provide more advanced features over D-Bus which today is<br>
be harder to achieve.=C2=A0 This will be an iterative process.<br>
<br>
But ... It would be very useful to get some input from especially<br>
macOS and Windows developers on how the state of D-Bus are on those<br>
platforms.=C2=A0 AFAIK, D-Bus is available on most *BSD platforms, so that<=
br>
shouldn&#39;t be an issue.<br>
<br>
It is not being planned to remove the management interface.=C2=A0 If D-Bus<=
br>
works well for everyone on all platforms, then we can discuss what to<br>
do next.=C2=A0 But as of now, I have no plans to remove this part of the co=
de.<br>
<br>
And of course ... plenty of discussions along the road :)=C2=A0 But I chose=
<br>
to start this discussion in the public before actually starting to<br>
coding and submitting patches - just as a heads up and to get feedback<br>
before moving on further.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
<br>______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a11442290480288053b63395d--

