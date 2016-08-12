MIME-Version: 1.0
In-Reply-To: <20160812184556.GG78279@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471023669-25102-1-git-send-email-gert@...1296...>
	<CAKuzo_jySkzG-fHJzz79-EvScbwnaN_PwD+e4dv17=WCxpagvA@...278...>
	<20160812184556.GG78279@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 15:32:57 -0400
Message-ID: <CAKuzo_iGNaBV+J79UQw-84MJVsAB3cp0idPZimMrtPvs14kEEA@...278...>
Content-Type: multipart/alternative; boundary=001a1135903e525a4d0539e4f415
Subject: Re: [Openvpn-devel] [PATCH v2] Change timestamps to ISO 8601 format.
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

--001a1135903e525a4d0539e4f415
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 12, 2016 at 2:45 PM, Gert Doering <gert@...1296...> wrote:

>
> On Fri, Aug 12, 2016 at 02:25:54PM -0400, Selva Nair wrote:
> > > +- all time stamps, including log file, status file and management
> > > interface,
> > > +  are now output in ISO 8601 standard format.
> > > +
> >
> > Currently the >LOG message to the management is like
> >
> > >LOG:1471025385,,Closing TUN/TAP interface
> >
> > with unix time as timestamp. Similarly for INFO message in response to
> 'log
> > n' request or the state message.The patch would not change those, would
> it?
>
> Those wouldn't be affected, no.  Only those that have the "old" ctime()
> format today - what I spotted on the management interface is "status"
> output, both in the header and in each idividual client line.


Thanks for the clarification. AFAIK, we do not parse status output in
OpenVPN GUI. A UI for server would need to parse those and it would have
been nicer to have status timestamps sent to management be in unix time as
well -- not a fault of this patch.

Selva

--001a1135903e525a4d0539e4f415
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 12, 2016 at 2:45 PM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span><br>
On Fri, Aug 12, 2016 at 02:25:54PM -0400, Selva Nair wrote:<br>
&gt; &gt; +- all time stamps, including log file, status file and managemen=
t<br>
&gt; &gt; interface,<br>
&gt; &gt; +=C2=A0 are now output in ISO 8601 standard format.<br>
&gt; &gt; +<br>
&gt;<br>
&gt; Currently the &gt;LOG message to the management is like<br>
&gt;<br>
&gt; &gt;LOG:1471025385,,Closing TUN/TAP interface<br>
&gt;<br>
&gt; with unix time as timestamp. Similarly for INFO message in response to=
 &#39;log<br>
&gt; n&#39; request or the state message.The patch would not change those, =
would it?<br>
<br>
</span>Those wouldn&#39;t be affected, no.=C2=A0 Only those that have the &=
quot;old&quot; ctime()<br>
format today - what I spotted on the management interface is &quot;status&q=
uot;<br>
output, both in the header and in each idividual client line.</blockquote><=
/div><div class=3D"gmail_extra"><br></div>Thanks for the clarification.=C2=
=A0AFAIK, we do not parse status output in OpenVPN GUI. A UI for server wou=
ld need to parse those and it would have been nicer to have status timestam=
ps sent to management be in unix time as well -- not a fault of this patch.=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva=
</div></div>

--001a1135903e525a4d0539e4f415--

