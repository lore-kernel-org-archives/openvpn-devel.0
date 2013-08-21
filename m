MIME-Version: 1.0
In-Reply-To: <52133EC8.2060003@...1114...>
References: <CAFHpkQHAAdBdPdtrtVpzUzwT5WdeEwWYpqPag=mLnSX-pMLaEw@...278...>
	<20130819104455.GH16543@...1296...>
	<5212620F.3060106@...515...>
	<20130819210137.GS16543@...1296...>
	<5213306D.2050205@...515...>
	<20130820092900.GA16543@...1296...>
	<52133EC8.2060003@...1114...>
Date: Tue, 20 Aug 2013 20:41:15 -0500
Message-ID: <CAK6ywbJ_74XGtF4GjmG5P7N8D3zZ+A5Y47v6JZoP1gfDzC9JnQ@...278...>
From: Nicholas Hall <ngharo@...277...>
Content-Type: multipart/alternative; boundary=e89a8ff2528ae1bf0c04e46b4415
Subject: Re: [Openvpn-devel] [Openvpn-users] pull requests on github
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e89a8ff2528ae1bf0c04e46b4415
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Do you need a middle man to monitor github and forword patches to the devel
mailing list along with commenting back and forth between github?  I'm not
well versed in compiled languages but I am no stranger to basic code review
and developer interactions.

I'd volunteer if you need someone to do this.  I'm a long time lurker,
user, and contributor to EasyRSA.

Apologize for the top post. Currently mobile.
On Aug 20, 2013 5:04 AM, "David Sommerseth" <openvpn.list@...1114...>
wrote:

> On 20/08/13 11:29, Gert Doering wrote:
> > Hi,
> >
> > On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp=E4nen wrote:
> >>> We've had questions on #openvpn-devel about pull request 7, which was
> the
> >>> first time (on request *7*) that anyone was taking note that we offer
> >>> pull requests at all - so there's 7 pull requests out there that are
> ignored.
> >> Well, we don't have the manpower to look at Trac bug reporting, and we
> >> still don't disable bug reporting, do we? :)
> >
> > This is a problem, indeed.  But it's not an argument for adding yet
> another
> > queue that we don't look at.
>
> In addition, we don't have "competing" alternatives to bug tracking on
> the table.  And we need bug tracking, unfortunately.
>
> >> Anyways, I can keep an eye on the pull requests and if something
> >> interesting pops up, I can forward those people to openvpn-devel. Or, =
if
> >> we really want to disable pull requests, we should monitor the OpenVPN
> >> forks in GitHub for something interesting, and encourage people to push
> >> their stuff to main development line.
> >
> > I've never understood the hype around github, tbh.  If you see value in
> > adding to your workload, feel free to - but really, evidence speaks
> against
> > enabling pull requests.
>
> +1
>
> > Also, Dazo and I won't actually *use* git-pull to fetch those, so one
> > of the big reasons why you would want that ("to enable git pull")
> wouldn't
> > apply anyway.  We have agreed on a workflow how to integrate patches, a=
nd
> > "pull" is not part of it.  "git am" and "git push" are...
>
> Even James sends patches to the mailing list for review nowadays, so we
> don't even do git pull from his repos.
>
> We've settled a long time ago that we wanted to review patches on the ML
> to keep track of the process in a distributed manner (reviews are not
> stored in a single server or with a single provider).
>
> Github can have some kind of review as well, but is doing it in a
> centralised manner.  And it would require us to write new scripts to
> automate git pulls as well - to get those extra review lines we add to
> the commit logs.  And if Github disappears, changes URL schema or
> similar things, we've lost the references to the review.  On the mailing
> list, there is at least the Message-ID which is unique enough to even
> use in google searches.  Nothing is really lost if gmane.org or
> sourceforge.net shuts down.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>
>
> -------------------------------------------------------------------------=
-----
> Introducing Performance Central, a new site from SourceForge and
> AppDynamics. Performance Central is your source for news, insights,
> analysis and resources for efficient Application Performance Management.
> Visit us today!
> http://pubads.g.doubleclick.net/gampad/clk?id=3D48897511&iu=3D/4140/ostg.=
clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--e89a8ff2528ae1bf0c04e46b4415
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Do you need a middle man to monitor github and forword patch=
es to the devel mailing list along with commenting back and forth between g=
ithub?=A0 I&#39;m not well versed in compiled languages but I am no strange=
r to basic code review and developer interactions.</p>

<p dir=3D"ltr">I&#39;d volunteer if you need someone to do this.=A0 I&#39;m=
 a long time lurker, user, and contributor to EasyRSA.</p>
<p dir=3D"ltr">Apologize for the top post. Currently mobile.</p>
<div class=3D"gmail_quote">On Aug 20, 2013 5:04 AM, &quot;David Sommerseth&=
quot; &lt;<a href=3D"mailto:openvpn.list@...1114...">openvpn.list@...1332...=
.</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 20/08/13 11:29, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp=E4nen wrote:<br>
&gt;&gt;&gt; We&#39;ve had questions on #openvpn-devel about pull request 7=
, which was the<br>
&gt;&gt;&gt; first time (on request *7*) that anyone was taking note that w=
e offer<br>
&gt;&gt;&gt; pull requests at all - so there&#39;s 7 pull requests out ther=
e that are ignored.<br>
&gt;&gt; Well, we don&#39;t have the manpower to look at Trac bug reporting=
, and we<br>
&gt;&gt; still don&#39;t disable bug reporting, do we? :)<br>
&gt;<br>
&gt; This is a problem, indeed. =A0But it&#39;s not an argument for adding =
yet another<br>
&gt; queue that we don&#39;t look at.<br>
<br>
In addition, we don&#39;t have &quot;competing&quot; alternatives to bug tr=
acking on<br>
the table. =A0And we need bug tracking, unfortunately.<br>
<br>
&gt;&gt; Anyways, I can keep an eye on the pull requests and if something<b=
r>
&gt;&gt; interesting pops up, I can forward those people to openvpn-devel. =
Or, if<br>
&gt;&gt; we really want to disable pull requests, we should monitor the Ope=
nVPN<br>
&gt;&gt; forks in GitHub for something interesting, and encourage people to=
 push<br>
&gt;&gt; their stuff to main development line.<br>
&gt;<br>
&gt; I&#39;ve never understood the hype around github, tbh. =A0If you see v=
alue in<br>
&gt; adding to your workload, feel free to - but really, evidence speaks ag=
ainst<br>
&gt; enabling pull requests.<br>
<br>
+1<br>
<br>
&gt; Also, Dazo and I won&#39;t actually *use* git-pull to fetch those, so =
one<br>
&gt; of the big reasons why you would want that (&quot;to enable git pull&q=
uot;) wouldn&#39;t<br>
&gt; apply anyway. =A0We have agreed on a workflow how to integrate patches=
, and<br>
&gt; &quot;pull&quot; is not part of it. =A0&quot;git am&quot; and &quot;gi=
t push&quot; are...<br>
<br>
Even James sends patches to the mailing list for review nowadays, so we<br>
don&#39;t even do git pull from his repos.<br>
<br>
We&#39;ve settled a long time ago that we wanted to review patches on the M=
L<br>
to keep track of the process in a distributed manner (reviews are not<br>
stored in a single server or with a single provider).<br>
<br>
Github can have some kind of review as well, but is doing it in a<br>
centralised manner. =A0And it would require us to write new scripts to<br>
automate git pulls as well - to get those extra review lines we add to<br>
the commit logs. =A0And if Github disappears, changes URL schema or<br>
similar things, we&#39;ve lost the references to the review. =A0On the mail=
ing<br>
list, there is at least the Message-ID which is unique enough to even<br>
use in google searches. =A0Nothing is really lost if <a href=3D"http://gman=
e.org" target=3D"_blank">gmane.org</a> or<br>
<a href=3D"http://sourceforge.net" target=3D"_blank">sourceforge.net</a> sh=
uts down.<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
<br>-----------------------------------------------------------------------=
-------<br>
Introducing Performance Central, a new site from SourceForge and<br>
AppDynamics. Performance Central is your source for news, insights,<br>
analysis and resources for efficient Application Performance Management.<br>
Visit us today!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D48897511&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D48897511&amp;iu=3D/4140/ostg.clktrk</a><br>___________________=
____________________________<br>

Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
<br></blockquote></div>

--e89a8ff2528ae1bf0c04e46b4415--

