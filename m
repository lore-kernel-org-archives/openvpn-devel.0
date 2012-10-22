MIME-Version: 1.0
In-Reply-To: <50851BE0.3020907@...1114...>
References: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
	<20121022084853.GF742@...1296...>
	<50851BE0.3020907@...1114...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 22 Oct 2012 08:11:41 -0400
Message-ID: <CAEsd45Tz-m76XHD0SE4JsDpom2sGbRh_YsZwV9QJvJzZYHwM1g@...278...>
Content-Type: multipart/alternative; boundary=bcaec54b46c4f8d71304cca4c36a
Subject: Re: [Openvpn-devel] Bug in program, bug in documentation,
 or something else?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, ecrist@...1286..., gert@...1296..., schwabe@...1400..., arne@...1227..., openvpn.list@...1114...

--bcaec54b46c4f8d71304cca4c36a
Content-Type: text/plain; charset=UTF-8

Thanks to all of you for your replies.

The consensus seems to be that the documentation is correct, and that if
OpenVPN behaves differently then that is a bug.

I'll try to get the user's configs/logs, or try to generate some test cases
that show this myself (and include a 2.1... test case to see if this
behavior was introduced in 2.2) and post them on this thread.

On Mon, Oct 22, 2012 at 6:11 AM, David Sommerseth <
openvpn.list@...1114...> wrote:

> On 22/10/12 10:48, Gert Doering wrote:
> > Hi Jonathan,
> >
> > On Sun, Oct 21, 2012 at 06:40:08PM -0400, Jonathan K. Bullard wrote:
> >> A Tunnelblick user has reported odd behavior with name resolution
> failures.
> >> I can't tell if it is a bug in OpenVPN, a bug in the documentation, or
> >> something else. The behavior is apparently the same in OpenVPN 2.2.1 and
> >> 2.3alpha1.
> > [..]
> >> Any ideas if this is a program bug, a documentation bug, or something
> else,
> >> for example, a problem that only occurs on OS X?
> >
> > "One of those" :-) - I don't know yet, and haven't looked into the code
> yet
> > (will do ASAP).
> >
> > The resolver code has been changed for 2.2 (getting rid of the old
> > randomization stuff), so it might be a bug introduced there, or a much
> > older bug that nobody ever noticed.
> >
> > Do you have an OpenVPN log that shows this behaviour?  Might help in
> > digging down to it...
>
> A client config file would help in addition.  I'm also wondering if
> connection profiles are used ... that is, more --remote options or
> <connection> blocks.
>
> Otherwise, I would not be surprised if there are some corner case here
> appearing, which surfaced more easily when the resolving code was
> re-written (as Gert mentioned).
>
> This resolver_retry_second option is only used in socket.c AFAICT, which
> most of us try to avoid looking too hard on, to avoid eye cancer and/or
> loosing our sanity ;-)  But there's work in progress on cleaning up that
> one, unfortunately that will take some time.  But we'll try to hunt down
> this which looks like an openvpn bug to me.
>
>
> kind regards,
>
> David Sommerseth
>
>

--bcaec54b46c4f8d71304cca4c36a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks to all of you for your replies.<div><br></div><div>The consensus see=
ms to be that the documentation is correct, and that if OpenVPN behaves dif=
ferently then that is a bug.<br><div><br></div><div>I&#39;ll try to get the=
 user&#39;s configs/logs, or try to generate some test cases that show this=
 myself (and include a 2.1... test case to see if this behavior was introdu=
ced in 2.2) and post them on this thread.<br>

<br><div class=3D"gmail_quote">On Mon, Oct 22, 2012 at 6:11 AM, David Somme=
rseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn.list@...1114..." targ=
et=3D"_blank">openvpn.list@...1114...</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">

<div class=3D"im">On 22/10/12 10:48, Gert Doering wrote:<br>
&gt; Hi Jonathan,<br>
&gt;<br>
&gt; On Sun, Oct 21, 2012 at 06:40:08PM -0400, Jonathan K. Bullard wrote:<b=
r>
&gt;&gt; A Tunnelblick user has reported odd behavior with name resolution =
failures.<br>
&gt;&gt; I can&#39;t tell if it is a bug in OpenVPN, a bug in the documenta=
tion, or<br>
&gt;&gt; something else. The behavior is apparently the same in OpenVPN 2.2=
.1 and<br>
&gt;&gt; 2.3alpha1.<br>
&gt; [..]<br>
&gt;&gt; Any ideas if this is a program bug, a documentation bug, or someth=
ing else,<br>
&gt;&gt; for example, a problem that only occurs on OS X?<br>
&gt;<br>
&gt; &quot;One of those&quot; :-) - I don&#39;t know yet, and haven&#39;t l=
ooked into the code yet<br>
&gt; (will do ASAP).<br>
&gt;<br>
&gt; The resolver code has been changed for 2.2 (getting rid of the old<br>
&gt; randomization stuff), so it might be a bug introduced there, or a much=
<br>
&gt; older bug that nobody ever noticed.<br>
&gt;<br>
&gt; Do you have an OpenVPN log that shows this behaviour? =C2=A0Might help=
 in<br>
&gt; digging down to it...<br>
<br>
</div>A client config file would help in addition. =C2=A0I&#39;m also wonde=
ring if<br>
connection profiles are used ... that is, more --remote options or<br>
&lt;connection&gt; blocks.<br>
<br>
Otherwise, I would not be surprised if there are some corner case here<br>
appearing, which surfaced more easily when the resolving code was<br>
re-written (as Gert mentioned).<br>
<br>
This resolver_retry_second option is only used in socket.c AFAICT, which<br>
most of us try to avoid looking too hard on, to avoid eye cancer and/or<br>
loosing our sanity ;-) =C2=A0But there&#39;s work in progress on cleaning u=
p that<br>
one, unfortunately that will take some time. =C2=A0But we&#39;ll try to hun=
t down<br>
this which looks like an openvpn bug to me.<br>
<br>
<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
</blockquote></div><br></div></div>

--bcaec54b46c4f8d71304cca4c36a--

