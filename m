MIME-Version: 1.0
References: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ.ref@...278...>
 <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
 <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
In-Reply-To: <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
From: Jon Chiappetta <root@...2904...>
Date: Wed, 6 Aug 2025 07:03:51 -0400
Message-ID: <CAOh3LPMj6WQgsUS00Jke0nNvRW8U0hTY78RYG5FTgCVQF38daA@...278...>
Content-Type: multipart/alternative; boundary="00000000000062cc77063bb04c63"
Subject: Re: [Openvpn-devel] Modifying OpenVPN Source Code to Allow for
 Bulk-Reads, Max-MTU, and Jumbo-TCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000062cc77063bb04c63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your reply Arne.

I didn't want to interrupt the regular OpenVPN development workflow process
here with some theoretical development questions. I still need to clean up
the code so that it would set and respect a user's option to turn this
feature on (1 client-side setting, multi server-side settings) and to also
not automatically override important variables/values/methods/functions
within the rest of the code base either (first time going through the
code). I also need to see if any better code optimizations could be made as
I'm not an expert on this code base like the others here may be.

Is there any development setup guide I could follow in the future which
would allow me to submit a pull request to the OpenVPN codebase in an
official manner?

Thanks again for your work and time,
Jon Chiappetta



On Wed, Aug 6, 2025 at 1:34=E2=80=AFAM Arne Schwabe <arne@...1227...> wrote:

> Am 06.08.25 um 05:46 schrieb Jon Chiappetta via Openvpn-devel:
> > Hi,
> >
> > This is my first time posting to a mailing list. I worked on a possible
> > performance proof-of-concept modification to the OpenVPN source code.
> > The code is in rough shape as I just wrote it this long weekend but I
> > wanted to see if anyone had any interesting feedback for such work.
> >
> > Blog Post: https://fossjon.com/2025/08/05/modifying-openvpn-source-code-
> > to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved-
> > performance/ <https://fossjon.com/2025/08/05/modifying-openvpn-source-
> > code-to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved-
> > performance/>
> >
>
>
>  > Max MTU which now matches the rest of your network clients (1500 bytes)
>
> I have no idea what this means. OpenVPN always supported different MTU
> sizes and MTU 1500 is standard.
>
>  > Bulk reads from the tun interface (6 reads)
>  > TCP connection protocol only (single jumbo write transfers)
>  > Performance improvements now allows for (6 reads x 1500 bytes =3D=3D 9=
000
> bytes)
>
>
> So basically, from your explanation the main thing is to try to
> write/read multiple packets in one batch on the TCP socket instead of
> just reading/writing a single packet.  I can see that this improves
> performance.
>
> Do you have any idea how much this actually improves performance? Your
> blog post shows a speedtest with 500 MBit/s but that is not actually
> saying much. In my own test setup, the current OpenVPN is capable over a
> Gigabit, a before/after from your test setup would nice to see.
>
> > POC Diff: https://github.com/stoops/openvpn/compare/main <https://
> > github.com/stoops/openvpn/compare/main>=E2=80=A6mods
>
> Might be good enough for a POC but from quick glance it looks like there
> needs to cleanup make this an actual commit.
> >
> > If this is the wrong place I apologize in advance,
> > Thanks for your time,
>
> No, this is the right place.
>
> Arne
>

--00000000000062cc77063bb04c63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank=C2=A0you for your reply=C2=A0Arne.=C2=A0<div><br></d=
iv><div>I didn&#39;t want to interrupt the regular OpenVPN development work=
flow process here with some theoretical development questions. I still need=
 to clean up the code so that it would set and respect a user&#39;s option =
to turn this feature on (1 client-side setting, multi server-side settings)=
 and to also not automatically override important variables/values/methods/=
functions within the rest of the code base either (first time going through=
 the code). I also need to see if any better code optimizations could be ma=
de as I&#39;m not an expert on this code base like the others here may be.=
=C2=A0<div><br></div><div>Is there any development setup guide I could foll=
ow in the future which would allow me to submit a pull request to the OpenV=
PN codebase in an official manner?=C2=A0</div><div><br></div><div>Thanks ag=
ain for your work and time,</div><div>Jon Chiappetta</div><div><br></div><d=
iv><br></div></div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 6, 2025 at 1:34=E2=80=
=AFAM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">Am 06.08.25 um 05:46 schrieb Jon Ch=
iappetta via Openvpn-devel:<br>
&gt; Hi,<br>
&gt; <br>
&gt; This is my first time posting to a mailing list. I worked on a possibl=
e <br>
&gt; performance proof-of-concept modification to the OpenVPN source code. =
<br>
&gt; The code is in rough shape as I just wrote it this long weekend but I =
<br>
&gt; wanted to see if anyone had any interesting feedback for such work.<br>
&gt; <br>
&gt; Blog Post: <a href=3D"https://fossjon.com/2025/08/05/modifying-openvpn=
-source-code-" rel=3D"noreferrer" target=3D"_blank">https://fossjon.com/202=
5/08/05/modifying-openvpn-source-code-</a> <br>
&gt; to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved- <br>
&gt; performance/ &lt;<a href=3D"https://fossjon.com/2025/08/05/modifying-o=
penvpn-source-" rel=3D"noreferrer" target=3D"_blank">https://fossjon.com/20=
25/08/05/modifying-openvpn-source-</a> <br>
&gt; code-to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved=
- <br>
&gt; performance/&gt;<br>
&gt; <br>
<br>
<br>
=C2=A0&gt; Max MTU which now matches the rest of your network clients (1500=
 bytes)<br>
<br>
I have no idea what this means. OpenVPN always supported different MTU <br>
sizes and MTU 1500 is standard.<br>
<br>
=C2=A0&gt; Bulk reads from the tun interface (6 reads)<br>
=C2=A0&gt; TCP connection protocol only (single jumbo write transfers)<br>
=C2=A0&gt; Performance improvements now allows for (6 reads x 1500 bytes =
=3D=3D 9000 <br>
bytes)<br>
<br>
<br>
So basically, from your explanation the main thing is to try to <br>
write/read multiple packets in one batch on the TCP socket instead of <br>
just reading/writing a single packet.=C2=A0 I can see that this improves <b=
r>
performance.<br>
<br>
Do you have any idea how much this actually improves performance? Your <br>
blog post shows a speedtest with 500 MBit/s but that is not actually <br>
saying much. In my own test setup, the current OpenVPN is capable over a <b=
r>
Gigabit, a before/after from your test setup would nice to see.<br>
<br>
&gt; POC Diff: <a href=3D"https://github.com/stoops/openvpn/compare/main" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/stoops/openvpn/compa=
re/main</a> &lt;https:// <br>
&gt; <a href=3D"http://github.com/stoops/openvpn/compare/main" rel=3D"noref=
errer" target=3D"_blank">github.com/stoops/openvpn/compare/main</a>&gt;=E2=
=80=A6mods<br>
<br>
Might be good enough for a POC but from quick glance it looks like there <b=
r>
needs to cleanup make this an actual commit.<br>
&gt; <br>
&gt; If this is the wrong place I apologize in advance,<br>
&gt; Thanks for your time,<br>
<br>
No, this is the right place.<br>
<br>
Arne<br>
</blockquote></div>

--00000000000062cc77063bb04c63--

