MIME-Version: 1.0
In-Reply-To: <CAP+U6tJhzN+cJbSTqtHSwSAZoPm_7OnyOp=VYAUT99NvfdfRyg@...278...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
	<CAP+U6tJhzN+cJbSTqtHSwSAZoPm_7OnyOp=VYAUT99NvfdfRyg@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 28 Mar 2012 11:53:32 -0400
Message-ID: <CAEsd45TjH_uFruwz8J9a17VUEjKiYu2Kd4bMLpY7=mqWcBZHGA@...278...>
Content-Type: multipart/alternative; boundary=90e6ba6e8dd06868df04bc4f9ebc
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--90e6ba6e8dd06868df04bc4f9ebc
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 28, 2012 at 9:57 AM, Fabian Knittel
<fabian.knittel@...1547...>wrote:

gc_arena instances are used by explicitly passing a pointer to it. So,
> unless one of the functions takes an instance of gc_arena as a
> parameter, you don't need to prepare one. As many functions in OpenVPN
> take one, there's some dead code scattered about that needlessly
> creates and frees gc arenas (probably because uses have come and gone
> over time). So you can drop gc because it's not used.
>
> The argv family of functions apparently has its own memory management
> and therefore argv_new() should be paired with an argv_reset().
> Otherwise the memory allocated by argv_printf() is leaked.
>

Thanks, Fabian.

If I don't hear about anything else in the next couple of days I'll
resubmit with these fixes.

Regards, Jon

--90e6ba6e8dd06868df04bc4f9ebc
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Mar 28, 2012 at 9:57 AM, Fabian Knittel =
<span dir=3D"ltr">&lt;<a href=3D"mailto:fabian.knittel@...1547...">fabian.k=
nittel@...1547...</a>&gt;</span> wrote:</div><div class=3D"gmail_quote"><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">

gc_arena instances are used by explicitly passing a pointer to it. So,<br>
unless one of the functions takes an instance of gc_arena as a<br>
parameter, you don&#39;t need to prepare one. As many functions in OpenVPN<=
br>
take one, there&#39;s some dead code scattered about that needlessly<br>
creates and frees gc arenas (probably because uses have come and gone<br>
over time). So you can drop gc because it&#39;s not used.<br>
<br>
The argv family of functions apparently has its own memory management<br>
and therefore argv_new() should be paired with an argv_reset().<br>
Otherwise the memory allocated by argv_printf() is leaked.<br></blockquote>=
<div><br></div><div>Thanks, Fabian.</div><div><br></div><div>If I don&#39;t=
 hear about anything else in the next couple of days I&#39;ll resubmit with=
 these fixes.</div>

<div></div></div><br><div>Regards, Jon</div>

--90e6ba6e8dd06868df04bc4f9ebc--

