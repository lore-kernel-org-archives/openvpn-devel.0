MIME-Version: 1.0
In-Reply-To: <20160613204102.GN62247@...1296...>
References: <CAKuzo_hJ3SV0rDSXcYVRCZDS9wqxbxeedoKi=AaqKfEyjmLM0g@...278...>
	<20160613204102.GN62247@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Jun 2016 17:10:53 -0400
Message-ID: <CAKuzo_i58Gwcg3SPwW=G_faxKQp=tYQ90W5be1PF_C5HVcpQew@...278...>
Content-Type: multipart/alternative; boundary=001a1149afdc109bfa05352f5481
Subject: Re: [Openvpn-devel] Semaphore locking error on windows
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

--001a1149afdc109bfa05352f5481
Content-Type: text/plain; charset=UTF-8

On Mon, Jun 13, 2016 at 4:41 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jun 13, 2016 at 04:22:39PM -0400, Selva Nair wrote:
> > As Windows clears semaphores when all open handles to it are gone, this
> is
> > a problem only when there is one or more other openvpn processes running.
> >
> > Any suggestions on how to fix this?
>
> Would "relinquish the semaphore when the initialization is finished, and
> re-acuire it when running the netsh.exe commands for route deletion on
> tunnel teardown" work?
>

> Aka "while openvpn is running in steady state, no handle exists", so the
> semaphore should clear itself.
>
>
Good idea. Just open and close the semaphore as and when needed instead of
keeping the open handle throughout the life of the process.  That should
work, I think.


> Not sure I understand the environment well enough to say whether this
> might work or not...
>

My understanding is that when the process terminates all handles are closed
but the semaphores lock count doesn't change. Until there are no open
handles at which point the semaphore can be cleared.  So it does seem your
suggestion should work.

I'll test it. Also we could just avoid opening the semaphore at all if
interactive service is in use.

By the way, the interactive service currently uses an un-named sempahore
--- the thinking was that there is only one process, so a global name is
not needed. But if both automatic and interactive services are in use, it
may be better to use the same global semaphore everywhere.

> Bonus question: write a unit test that anticipates this and catches it :-)
>
> All our units need to be perfect, so this just cannot happen! ;-)
>

corollary: No code can be perfect, ergo no unit test can ever be written ;)

Selva

--001a1149afdc109bfa05352f5481
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Jun 13, 2016 at 4:41 PM, Gert <span>Doering</span> <span dir=3D"ltr=
">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"><span>gert</span=
>@<span>greenie</span>.<span>muc</span>.<span>de</span></a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div>Hi,<br>
<span><br>
On Mon, Jun 13, 2016 at 04:22:39PM -0400, Selva Nair wrote:<br>
&gt; As Windows clears semaphores when all open handles to it are gone, thi=
s is<br>
&gt; a problem only when there is one or more other openvpn processes runni=
ng.<br>
&gt;<br>
&gt; Any suggestions on how to fix this?<br>
<br>
</span>Would &quot;relinquish the semaphore when the initialization is fini=
shed, and<br>
re-acuire it when running the netsh.exe commands for route deletion on<br>
tunnel teardown&quot; work?</div></blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div>
<br>
Aka &quot;while openvpn is running in steady state, no handle exists&quot;,=
 so the<br>
semaphore should clear itself.<br>
<br></div></blockquote><div><br></div><div>Good idea. Just open and close t=
he semaphore as and when needed instead of keeping the open handle througho=
ut the life of the process.=C2=A0 That should work, I think.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div>
Not sure I understand the environment well enough to say whether this<br>
might work or not...<br></div></blockquote><div><br></div><div>My understan=
ding is that when the process terminates all handles are closed but the sem=
aphores lock count doesn&#39;t change. Until there are no open handles at w=
hich point the semaphore can be cleared.=C2=A0 So it does seem your suggest=
ion should work.=C2=A0</div><div><br></div><div>I&#39;ll test it. Also we c=
ould just avoid opening the semaphore at all if interactive service is in u=
se.=C2=A0</div><div>=C2=A0</div><div>By the way, the interactive service cu=
rrently uses an un-named <span>sempahore</span> --- the thinking was that t=
here is only one process, so a global name is not needed. But if both autom=
atic and interactive services are in use, it may be better to use the same =
global semaphore everywhere.</div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div><span>
&gt; Bonus question: write a unit test that anticipates this and catches it=
 :-)<br>
<br>
</span>All our units need to be perfect, so this just cannot happen! ;-)</d=
iv></blockquote></div><div class=3D"gmail_extra"><br></div>corollary: No co=
de can be perfect, ergo no unit test can ever be written ;)</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><span>Selva</span><br=
><br></div></div>

--001a1149afdc109bfa05352f5481--

