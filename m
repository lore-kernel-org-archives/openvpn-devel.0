MIME-Version: 1.0
In-Reply-To: <20160531160104.GB53051@...1296...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<20160531084825.GT53051@...1296...>
	<CAKuzo_jLpENbvwEOg18dp3CKRCFQbo8O29m3-jZfqQeJ+DB+Kw@...278...>
	<20160531160104.GB53051@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 3 Jun 2016 15:43:58 -0400
Message-ID: <CAKuzo_i+hY8svkPNzJvF-HamNFaBd3iauiukmwgLVfRyzjGuoQ@...278...>
Content-Type: multipart/alternative; boundary=001a11449adcc073b5053464f288
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11449adcc073b5053464f288
Content-Type: text/plain; charset=UTF-8

On Tue, May 31, 2016 at 12:01 PM, Gert Doering <gert@...1296...> wrote:

> Do you foresee more different action types?  My imagination ends at
> "accept, ignore, refuse-with-error"...
>
> > Suppose we do make "reject" to not just remove the option but reject the
> > server. What to do if no alternative remotes exist --- just SIGHUP and
> hope
> > that next try will succeed or something like management-hold will keep
> the
> > connection waiting for user intervention? I would avoid issuing or
> causing
> > a SIGTERM.
>
> I have a use case where I would like to silently *ignore* something one
> of my servers is sending me (one route that is sent conflicts with local
> stuff, but that is not malicious or neglicience on their end, but something
> on my end).  So v1 would do that for me, changing it to "you can only
> have accept ore reject-the-server" would make this option not work for
> me (right now I use route-nopull and manually set route statements).
>
> But anyway - I think SIGHUP is good enough.  If there is no other server,
> it will loop, like in any other uncorrectable error (like, server cert
> invalid), but there is not much we can do about it.
>

I'm holding back on version 2 of  patch due to an issue seen while testing
the proposed change (accept, ignore or  reject with error by triggering a
restart) -- I'm using SIGUSR1 restart so that the next remote gest tried.

Testing shows that during such a failure-restart cycle caused by the
reject, a SIGTERM received could be lost sometimes depending on the timing
of the signal. This is particularly bad for the windows-GUI which uses the
exit-event for SIGTERM --- when missed it leaves openvpn.exe process
running after the GUI exits causing all kinds of issues.

The problem appears to be present only when explicit-exit-notify is used so
it seems this is what happens:

SIGTERM triggers exit-notify and initializes the struct
c->c2.explicit_exit_notification_interval with params that controls the
timer. Any SIGUSR1 or SIGHUP after this can break the loop in
 tunnel_point_to_point() by any of the P2P_CHECK_SIG()s. Then the instance
gets restarted. At the re-entry to tunnel_point_to_point() we have

context_clear_2 (c);

which clears the previously set elements of the
c->c2.explicit_exit_notification_interval struct and the SIGTERM is lost.

Now, I recall a discussion in the past about SIGTERM/SIGINT being ignored
during the resolve-failure -- how was that resolved?

Selva

--001a11449adcc073b5053464f288
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, May 31, 2016 at 12:01 PM, Gert <span class=3D"" id=3D":58h.1" tabin=
dex=3D"-1">Doering</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1386...=
296..." target=3D"_blank"><span class=3D"" id=3D":58h.2" tabindex=3D"-1">ge=
rt</span>@<span class=3D"" id=3D":58h.3" tabindex=3D"-1">greenie</span>.<sp=
an class=3D"" id=3D":58h.4" tabindex=3D"-1">muc</span>.<span class=3D"" id=
=3D":58h.5" tabindex=3D"-1">de</span></a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div>Do you foresee more different action types?=C2=A0 My imagination =
ends at<br>
&quot;accept, ignore, refuse-with-error&quot;...<br>
<span><br>
&gt; Suppose we do make &quot;reject&quot; to not just remove the option bu=
t reject the<br>
&gt; server. What to do if no alternative remotes exist --- just SIGHUP and=
 hope<br>
&gt; that next try will succeed or something like management-hold will keep=
 the<br>
&gt; connection waiting for user intervention? I would avoid issuing or cau=
sing<br>
&gt; a SIGTERM.<br>
<br>
</span>I have a use case where I would like to silently *ignore* something =
one<br>
of my servers is sending me (one route that is sent conflicts with local<br>
stuff, but that is not malicious or neglicience on their end, but something=
<br>
on my end).=C2=A0 So v1 would do that for me, changing it to &quot;you can =
only<br>
have accept ore reject-the-server&quot; would make this option not work for=
<br>
me (right now I use route-nopull and manually set route statements).<br>
<br>
But anyway - I think SIGHUP is good enough.=C2=A0 If there is no other serv=
er,<br>
it will loop, like in any other uncorrectable error (like, server cert<br>
invalid), but there is not much we can do about it.</div></blockquote></div=
><br><div class=3D"gmail_extra"><div class=3D"gmail_extra">I&#39;m holding =
back on version 2 of =C2=A0patch due to an issue seen while testing the pro=
posed change (accept, ignore or =C2=A0reject with error by triggering a res=
tart) -- I&#39;m using SIGUSR1 restart so that the next remote <span class=
=3D"" id=3D":58h.6" tabindex=3D"-1">gest</span> tried.</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">Testing shows that during =
such a failure-restart cycle caused by the reject, a <span class=3D"" id=3D=
":58h.7" tabindex=3D"-1">SIGTERM</span> received could be lost sometimes de=
pending on the timing of the signal. This is particularly bad for the windo=
ws-GUI which uses the exit-event for <span class=3D"" id=3D":58h.8" tabinde=
x=3D"-1">SIGTERM</span> --- when missed it leaves <span class=3D"" id=3D":5=
8h.9" tabindex=3D"-1">openvpn</span>.<span class=3D"" id=3D":58h.10" tabind=
ex=3D"-1">exe</span> process running after the GUI exits causing all kinds =
of issues.=C2=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gm=
ail_extra">The problem appears to be present only when explicit-exit-notify=
 is used so it seems this is what happens:</div><div class=3D"gmail_extra">=
=C2=A0</div><div class=3D"gmail_extra"><span class=3D"" id=3D":58h.11" tabi=
ndex=3D"-1">SIGTERM</span> triggers exit-notify and initializes the <span c=
lass=3D"" id=3D":58h.12" tabindex=3D"-1">struct</span> c-&gt;c2.explicit_ex=
it_notification_interval with <span class=3D"" id=3D":58h.13" tabindex=3D"-=
1">params</span> that controls the timer. Any SIGUSR1 or <span class=3D"" i=
d=3D":58h.14" tabindex=3D"-1">SIGHUP</span> after this can break the loop i=
n =C2=A0tunnel_point_to_point() by any of the P2P_CHECK_SIG()s. Then the in=
stance gets restarted. At the re-entry to tunnel_point_to_point() we have</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_extra">context_clear_2 (c);</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">which clears the previously set elements=
 of the c-&gt;c2.explicit_exit_notification_interval <span class=3D"" id=3D=
":58h.15" tabindex=3D"-1">struct</span> and the <span class=3D"" id=3D":58h=
.16" tabindex=3D"-1">SIGTERM</span> is lost.</div><div class=3D"gmail_extra=
"><br></div></div><div class=3D"gmail_extra">Now, I recall a discussion in =
the past about <span class=3D"" id=3D":58h.17" tabindex=3D"-1">SIGTERM</spa=
n>/<span class=3D"" id=3D":58h.18" tabindex=3D"-1">SIGINT</span> being igno=
red during the resolve-failure -- how was that resolved?<br><br></div><div =
class=3D"gmail_extra"><span class=3D"" id=3D":58h.19" tabindex=3D"-1">Selva=
</span></div></div></div></div>

--001a11449adcc073b5053464f288--

