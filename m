MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAGyAFMX8Hf81e5Jom-F4__7ktrA5pyf1ygMff2ixHzqhsTebGQ@...278...>
References: <CAGyAFMWg5j+ki56=fwOOZwcpAdixE8eDyJXFgktrNsOqrYZRcA@...278...>
	<CAP+U6tKkiU3FmaPN66s62iZiEoqbmgLjn4J-kJTM9P=0H5qSMg@...278...>
	<CAGyAFMX8Hf81e5Jom-F4__7ktrA5pyf1ygMff2ixHzqhsTebGQ@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 10 Oct 2014 22:43:03 +0200
Message-ID: <CAP+U6t+djWatsor=OoKuSLEC12Mt5Vin8hJu2S81aRcAtPjk5Q@...278...>
Content-Type: multipart/alternative; boundary=001a11c11812a2a9240505179990
Subject: Re: [Openvpn-devel] Async OPENVPN_PLUGIN_CLIENT_CONNECT plugin
	support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c11812a2a9240505179990
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lev,

2014-10-07 20:50 GMT+02:00 Lev Stipakov <lstipakov@...277...>:

> Patch works great, thanks! I have rebased it a bit and added support
> for client-connect plugin call.
>

Great to hear that my patch works for you!

I've finally rebased the patches too, due to my current users complaining
about the old OpenVPN version and missing security updates. (See
https://github.com/fknittel/openvpn/tree/feat_deferred_client-connect -
there's a branch for master and a branch for the OpenVPN 2.3 stable branch.)

You say that you've added support for the client-connect plugin call. May I
ask what was missing? I'd definitely be interested in any changes you
needed to make it work. I would have expected the patch titled
"client-connect: Add deferred support to the client-connect plugin v1
handler" to provide everything, but as I only ever used the script handler,
it's not unlikely that I missed something.

I would like to offer a related feature (and implementation) I call
> async-push.
>
> Use case: authentication / authorization takes time. I have auth/az
> code in auth-user-pass-verify and client-connect calls, and sometimes
> it takes more that second to execute those. The problem is that after
> auth-user-pass-verify is done, OpenVPN server won=E2=80=99t proceed with
> client-connect unless some timeout/io event happens for that client.
> Also, server will not notify client that client-connect returned
> success unless client sends PULL_REQUEST. Client, in turn, sends
> PULL_REQUEST one second after connection initiation and after that
> once per 5 seconds. So, for example, if at the moment when first pull
> request has arrived, client-connect has not finished yet, we will have
> to wait another 5 seconds for the next PULL_REQUEST.
>

So this is basically about replacing a 5s poll-interval with something that
should proceed near instantaneously, correct?


> Solution: Inotify. Since OpenVPN creates itself files (auth-contro and
> client-connect-deferred) which names it passes to the plugin, we
> create one inotify descriptor for event loop and right after creating
> those files, we add inotify watch on those. Before calling epoll (or
> whatever we use) we add inotify descriptor to the list of watched
> descriptors. We also keep watch descriptor and multi_instance in a
> hashtable.
>
> When epoll informs us that an event has happened on inotify
> descriptor, we get multi_instance by watch descriptor (fetched from
> poll event) from our new hashtable and call multi_process_post for
> given multi_instance. This will check result from the file and
> eventually call multi_connection_established, from where we call
> send_push_reply.
>
> Since implementation uses Inotify, it will work on Linux only. Code is
> under #define, which is set at compile-time (--enable-async-push=3Dyes).
>
> I have attached an implementation. So far has been working nicely in
> my test environment. I would love to hear a feedback from the
> community. Is the whole thing done more or less right? Any bugs got
> introduced that someone could spot?
>

Thanks for sharing! I'll have a look at it, when time permits. Though my
focus is currently on getting some or all of the patches from the basic
patch-set upstream.

Cheers
Fabian

--001a11c11812a2a9240505179990
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Lev,<div><br></div><div>2014-10-07 20:50 GMT+02:00 Lev =
Stipakov <span dir=3D"ltr">&lt;<a href=3D"mailto:lstipakov@...277..." targe=
t=3D"_blank" onclick=3D"window.open(&#39;https://mail.google.com/mail/?view=
=3Dcm&amp;tf=3D1&amp;to=3Dlstipakov@...277...&amp;cc=3D&amp;bcc=3D&amp;su=
=3D&amp;body=3D&#39;,&#39;_blank&#39;);return false;">lstipakov@...277...</=
a>&gt;</span>:<br></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:soli=
d;padding-left:1ex">Patch works great, thanks! I have rebased it a bit and =
added support<br>
for client-connect plugin call.<br></blockquote><div><br></div><div><div>Gr=
eat to hear that my patch works for you!</div><div><br></div><div>I&#39;ve =
finally rebased the patches too, due to my current users complaining about =
the old OpenVPN version and missing security updates. (See=C2=A0<a href=3D"=
https://github.com/fknittel/openvpn/tree/feat_deferred_client-connect">http=
s://github.com/fknittel/openvpn/tree/feat_deferred_client-connect</a> - the=
re&#39;s a branch for master and a branch for the OpenVPN 2.3 stable branch=
.)</div></div><div>=C2=A0<br></div><div>You say that you&#39;ve added suppo=
rt for the client-connect plugin call. May I ask what was missing? I&#39;d =
definitely be interested in any changes you needed to make it work. I would=
 have expected the patch titled &quot;client-connect: Add deferred support =
to the client-connect plugin v1 handler&quot; to provide everything, but as=
 I only ever used the script handler, it&#39;s not unlikely that I missed s=
omething.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">
I would like to offer a related feature (and implementation) I call async-p=
ush.<br>
<br>
Use case: authentication / authorization takes time. I have auth/az<br>
code in auth-user-pass-verify and client-connect calls, and sometimes<br>
it takes more that second to execute those. The problem is that after<br>
auth-user-pass-verify is done, OpenVPN server won=E2=80=99t proceed with<br>
client-connect unless some timeout/io event happens for that client.<br>
Also, server will not notify client that client-connect returned<br>
success unless client sends PULL_REQUEST. Client, in turn, sends<br>
PULL_REQUEST one second after connection initiation and after that<br>
once per 5 seconds. So, for example, if at the moment when first pull<br>
request has arrived, client-connect has not finished yet, we will have<br>
to wait another 5 seconds for the next PULL_REQUEST.<br></blockquote><div><=
br></div><div>So this is basically about replacing a 5s poll-interval with =
something that should proceed near instantaneously, correct?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">
Solution: Inotify. Since OpenVPN creates itself files (auth-contro and<br>
client-connect-deferred) which names it passes to the plugin, we<br>
create one inotify descriptor for event loop and right after creating<br>
those files, we add inotify watch on those. Before calling epoll (or<br>
whatever we use) we add inotify descriptor to the list of watched<br>
descriptors. We also keep watch descriptor and multi_instance in a<br>
hashtable.<br>
<br>
When epoll informs us that an event has happened on inotify<br>
descriptor, we get multi_instance by watch descriptor (fetched from<br>
poll event) from our new hashtable and call multi_process_post for<br>
given multi_instance. This will check result from the file and<br>
eventually call multi_connection_established, from where we call<br>
send_push_reply.<br>
<br>
Since implementation uses Inotify, it will work on Linux only. Code is<br>
under #define, which is set at compile-time (--enable-async-push=3Dyes).<br>
<br>
I have attached an implementation. So far has been working nicely in<br>
my test environment. I would love to hear a feedback from the<br>
community. Is the whole thing done more or less right? Any bugs got<br>
introduced that someone could spot?<br></blockquote><div><br></div><div>Tha=
nks for sharing! I&#39;ll have a look at it, when time permits. Though my f=
ocus is currently on getting some or all of the patches from the basic patc=
h-set upstream.</div><div><br></div><div>Cheers</div><div>Fabian</div></div=
></div></div>

--001a11c11812a2a9240505179990--

