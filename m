MIME-Version: 1.0
In-Reply-To: <20160623062043.GA79504@...1296...>
References: <1466649762-1657-1-git-send-email-selva.nair@...277...>
	<20160623062043.GA79504@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Jun 2016 10:39:15 -0400
Message-ID: <CAKuzo_j=NnNiA2z65G=8FOKmy7tHjqSrVotgcqBP=M-tR_juZQ@...278...>
Content-Type: multipart/alternative; boundary=001a11403cdcd2cc310535f305b1
Subject: Re: [Openvpn-devel] [PATCH] Return process id of openvpn from
 interactive service to client
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

--001a11403cdcd2cc310535f305b1
Content-Type: text/plain; charset=UTF-8

On Thu, Jun 23, 2016 at 2:20 AM, Gert Doering <gert@...1296...> wrote:

> On Wed, Jun 22, 2016 at 10:42:42PM -0400, Selva Nair wrote:
> > - The process id is returned as a message formatted in the same manner
> >   as error messages from the service to the client: i.e., a three-line
> >   message with pid formatted as 0x%08x on line 1, "Process Id" on
> >   line 2 and a blank line 3.
> >
> > This provides a way for service clients to check the status of openvpn
> > and terminate it without needing management interface or exit event.
> > Useful when the interactive service is used from a launch script, or
> > to force-terminate openvpn from the GUI if/when needed.
>
> How does the GUI currently handle return messages?  As in, does this
> need GUI changes, or is the GUI prepared to handle anything that comes
> along?
>

Currently the GUI interpretes two custom error codes (0x2000000 and
0x20000001) and ignores the rest. So it will just a log a message and
ignore this one. Unless the PID happens to match one of those two numbers.
Though I've never seen PIDs that large.

An alternative is to set error = 0 and pass PID as the second line:

"0x00000000\nPID\Process ID"

where PID may be formatted as 0x%08x. May be that is better?


> >
> > +static VOID
> > +ReturnProcessId (HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events)
> > +{
> > +  const WCHAR msg[] = L"\nProcess ID\n";
> > +  WCHAR buf[10 + _countof(msg)]; /* 10 characters for the pid in 0x%08x
> format */
> > +
> > +  /* A 3-line string like an error message but with pid in place of
> error number */
> > +  _snwprintf (buf, _countof(buf), L"0x%08x%s", pid, msg);
> > +  buf[_countof(buf) - 1] = '\0';
> > +
> > +  WritePipeAsync (pipe, buf, wcslen (buf) * 2, count, events);
> > +}
>
> Where does the extra blank line come from?  If I'm not all confused
> (this is before my first cup of tea) this will write
>
> %08x\nProcess ID\n
>
> into the buffer, and not \n\n...


May be its my terminology of what is a "line", not your tea. The currently
used format is NUMBER\nLINE2\nLINE3 so there is no \n at the end of line
3.  In the present case that would be "%08x\nProcess ID\n"

Thanks for looking into this.

Selva

--001a11403cdcd2cc310535f305b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Jun 23, 2016 at 2:20 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, Jun 22,=
 2016 at 10:42:42PM -0400, Selva Nair wrote:<br>
&gt; - The process id is returned as a message formatted in the same manner=
<br>
&gt;=C2=A0 =C2=A0as error messages from the service to the client: i.e., a =
three-line<br>
&gt;=C2=A0 =C2=A0message with pid formatted as 0x%08x on line 1, &quot;Proc=
ess Id&quot; on<br>
&gt;=C2=A0 =C2=A0line 2 and a blank line 3.<br>
&gt;<br>
&gt; This provides a way for service clients to check the status of openvpn=
<br>
&gt; and terminate it without needing management interface or exit event.<b=
r>
&gt; Useful when the interactive service is used from a launch script, or<b=
r>
&gt; to force-terminate openvpn from the GUI if/when needed.<br>
<br>
</span>How does the GUI currently handle return messages?=C2=A0 As in, does=
 this<br>
need GUI changes, or is the GUI prepared to handle anything that comes<br>
along?<br></blockquote><div><br></div><div>Currently the GUI interpretes tw=
o custom error codes (0x2000000 and 0x20000001) and ignores the rest. So it=
 will just a log a message and ignore this one. Unless the PID happens to m=
atch one of those two numbers. Though I&#39;ve never seen PIDs that large.<=
/div><div><br></div><div>An alternative is to set error =3D 0 and pass PID =
as the second line:=C2=A0</div><div><br></div><div>&quot;0x00000000\nPID\Pr=
ocess ID&quot;</div><div><br></div><div>where PID may be formatted as 0x%08=
x. May be that is better?<br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<span class=3D""><br>
&gt;<br>
&gt; +static VOID<br>
&gt; +ReturnProcessId (HANDLE pipe, DWORD pid, DWORD count, LPHANDLE events=
)<br>
&gt; +{<br>
&gt; +=C2=A0 const WCHAR msg[] =3D L&quot;\nProcess ID\n&quot;;<br>
&gt; +=C2=A0 WCHAR buf[10 + _countof(msg)]; /* 10 characters for the pid in=
 0x%08x format */<br>
&gt; +<br>
&gt; +=C2=A0 /* A 3-line string like an error message but with pid in place=
 of error number */<br>
&gt; +=C2=A0 _snwprintf (buf, _countof(buf), L&quot;0x%08x%s&quot;, pid, ms=
g);<br>
&gt; +=C2=A0 buf[_countof(buf) - 1] =3D &#39;\0&#39;;<br>
&gt; +<br>
&gt; +=C2=A0 WritePipeAsync (pipe, buf, wcslen (buf) * 2, count, events);<b=
r>
&gt; +}<br>
<br>
</span>Where does the extra blank line come from?=C2=A0 If I&#39;m not all =
confused<br>
(this is before my first cup of tea) this will write<br>
<br>
%08x\nProcess ID\n<br>
<br>
into the buffer, and not \n\n...</blockquote><div><br></div><div>May be its=
 my terminology of what is a &quot;line&quot;, not your tea. The currently =
used format is NUMBER\nLINE2\nLINE3 so there is no \n at the end of line 3.=
=C2=A0 In the present case that would be &quot;%08x\nProcess ID\n&quot; =C2=
=A0</div></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra">Thanks for looking into this.</div><div class=3D"gmail_extra"><br></div=
>Selva<br><br></div></div>

--001a11403cdcd2cc310535f305b1--

