MIME-Version: 1.0
In-Reply-To: <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
References: <CAJY0qZKNO_aamQfi56BG_XK2vrOCyPAQf-My1N56qqV7TsUG7A@...278...>
 <eaae68e6-e30d-f63b-59c5-64515c8f8bcd@...1147...>
 <e4a2d28a-ff8d-4797-e0af-3bcf98828cb3@...1856...>
From: Derek Zimmer <derek@...2095...>
Date: Fri, 1 Jun 2018 00:50:49 +0000
Message-ID: <CAJY0qZKw+HgQ1vS-W13nw2=gj8d-uxeOqyZia4-gEbaGNTyFLQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000aa4a0d056d89f99a"
Subject: Re: [Openvpn-devel] Does the OpenVPN protocol itself handle
 windowing?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000aa4a0d056d89f99a
Content-Type: text/plain; charset="UTF-8"

I'm still working on this, as I think it is worthwhile for us to explore
and get some hard data on how all of these things perform in a real world
environment.

I've been stalled by transitioning to a new job.

>Same here. I guess this interacts with other properties, like the delay
>OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
>fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
>magnitude (at the crypto level).

This might be interesting, and it also might be why my real world testing
doesn't match what we see at https://community.openvpn.net/openvpn
/wiki/Gigabit_Networks_Linux
<https://community.openvpn.net/openvpn/wiki/Gigabit_Networks_Linux>

It looks like this experiment was conducted on machines on a LAN with
virtually no latency / forwarding being done, so while it does show us some
theoretical numbers they don't seem to apply to the real-world use-cases
that we are hoping to get these types of performance figures for.

As soon as we start adding latency and jitter performance seems to tank
with these optimizations.

So that I am not chasing phantoms, do we have any real-world examples of
the claim by janjust@...1147... or are we just going off of the
Gigabit_Networks_Linux page? If we have real world examples of
configurations that can push more than 250Mbit (on a 1Gb controller) or
2.5Gbit (on a 10Gb controller) over connections with more than 10ms of
latency then it would allow me to significantly narrow my search for
problem areas.

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

On Sun, May 6, 2018 at 8:04 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi,
>
> On 04-05-18 17:45, Jan Just Keijser wrote:
> > On 04/05/18 16:41, Derek Zimmer wrote:
> >> What conclusions can we draw from this?
> >>
> > My main conclusion has always been that OpenVPN is limited by the number
> > of user-to-kernel space transitions , not by anything else.
>
> Same here. I guess this interacts with other properties, like the delay
> OpenVPN itself adds.  And that is where AES-GCM, with it's blazingly
> fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of
> magnitude (at the crypto level).
>
> Some while ago, I looked a bit into this, and started at looking to
> improve the user/kernel interfaces.  I posted a proof-of-concept patch
> that might be interesting to check out if you're doing performance testing:
> https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13699.html
>
> I'd be very interested to know if using recvmmsg() improves the
> performance in you measurements.  (I never got to picking this up again,
> because dayjob, bug reports and life in general got in the way...)
>
> -Steffan
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000aa4a0d056d89f99a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;m still working on this, as I think it is =
worthwhile for us to explore
 and get some hard data on how all of these things perform in a real=20
world environment.</div><div><br></div><div>I&#39;ve been stalled by transi=
tioning to a new job.<br></div><div><br></div><div>&gt;Same here. I guess t=
his interacts with other properties, like the delay<br>
<span style=3D"background-color:rgb(255,255,255)"><span class=3D"il">&gt;Op=
enVPN</span></span> itself adds.=C2=A0 And that is where AES-GCM, with it&#=
39;s blazingly<br>
&gt;fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of=
<br>
&gt;magnitude (at the crypto level).<br><br></div>This might be interesting=
, and it also might be why my real world testing doesn&#39;t match what we =
see at <a href=3D"https://community.openvpn.net/openvpn/wiki/Gigabit_Networ=
ks_Linux" rel=3D"noreferrer" target=3D"_blank">https://community.<span clas=
s=3D"il">openvpn</span>.net/<wbr><span class=3D"il">openvpn</span>/wiki/Gig=
abit_Networks_<wbr>Linux<br></a></div><a href=3D"https://community.openvpn.=
net/openvpn/wiki/Gigabit_Networks_Linux" rel=3D"noreferrer" target=3D"_blan=
k"></a><div class=3D"gmail_extra"><div><div class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature"><br></div><div class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature">It looks like this experiment was conducted =
on machines on a LAN with virtually no latency / forwarding being done, so =
while it does show us some theoretical numbers they don&#39;t seem to apply=
 to the real-world use-cases that we are hoping to get these types of perfo=
rmance figures for.<br></div><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><br></div><div class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature">As soon as we start adding latency and jitter perform=
ance seems to tank with these optimizations.</div><div class=3D"gmail_signa=
ture" data-smartmail=3D"gmail_signature"><br></div><div class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature">So that I am not chasing phantoms=
, do we have any real-world examples of the claim by janjust<wbr>@<a href=
=3D"http://nikhef.nl">nikhef.nl</a> or are we just going off of the Gigabit=
_Networks_Linux page? If we have real world examples of configurations that=
 can push more than 250Mbit (on a 1Gb controller) or 2.5Gbit (on a 10Gb con=
troller) over connections with more than 10ms of latency then it would allo=
w me to significantly narrow my search for problem areas.<br></div><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><br></div><div cl=
ass=3D"gmail_signature" data-smartmail=3D"gmail_signature">Derek Zimmer<br>=
Chief Executive Officer<br>Open Source Technology Improvement Fund</div></d=
iv>
<br><div class=3D"gmail_quote">On Sun, May 6, 2018 at 8:04 AM, Steffan Karg=
er <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_b=
lank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hi,<br>
<span class=3D""><br>
On 04-05-18 17:45, Jan Just Keijser wrote:<br>
&gt; On 04/05/18 16:41, Derek Zimmer wrote:<br>
</span><span class=3D"">&gt;&gt; What conclusions can we draw from this?<br>
&gt;&gt;<br>
&gt; My main conclusion has always been that OpenVPN is limited by the numb=
er<br>
&gt; of user-to-kernel space transitions , not by anything else.<br>
<br>
</span>Same here. I guess this interacts with other properties, like the de=
lay<br>
OpenVPN itself adds.=C2=A0 And that is where AES-GCM, with it&#39;s blazing=
ly<br>
fast hardware acceleration, outperforms AES-CBC + HMAC-SHA in orders of<br>
magnitude (at the crypto level).<br>
<br>
Some while ago, I looked a bit into this, and started at looking to<br>
improve the user/kernel interfaces.=C2=A0 I posted a proof-of-concept patch=
<br>
that might be interesting to check out if you&#39;re doing performance test=
ing:<br>
<a href=3D"https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg13699.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/msg13699.html</a><=
br>
<br>
I&#39;d be very interested to know if using recvmmsg() improves the<br>
performance in you measurements.=C2=A0 (I never got to picking this up agai=
n,<br>
because dayjob, bug reports and life in general got in the way...)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--000000000000aa4a0d056d89f99a--

