Message-ID: <52147426.40500@...515...>
Date: Wed, 21 Aug 2013 11:02:46 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAFHpkQHAAdBdPdtrtVpzUzwT5WdeEwWYpqPag=mLnSX-pMLaEw@...278...>
	<20130819104455.GH16543@...1296...>	<5212620F.3060106@...515...>
	<20130819210137.GS16543@...1296...>	<5213306D.2050205@...515...>
	<20130820092900.GA16543@...1296...>	<52133EC8.2060003@...1114...>
	<CAK6ywbJ_74XGtF4GjmG5P7N8D3zZ+A5Y47v6JZoP1gfDzC9JnQ@...278...>
In-Reply-To: <CAK6ywbJ_74XGtF4GjmG5P7N8D3zZ+A5Y47v6JZoP1gfDzC9JnQ@...278...>
Content-Type: multipart/alternative;
	boundary="------------050609010102000304070702"
Subject: Re: [Openvpn-devel] [Openvpn-users] pull requests on github
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Nicholas Hall <ngharo@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050609010102000304070702
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Nicholas,

We can always use a good lurkers and contributors :). You could
definitely keep an eye on what happening on GitHub (OpenVPN forks and/or
pull requests) and keep us updated on interesting changes. The last time
I looked there was ~1 pull request per month. It possible that there are
also forks with some useful changes.

Just to make this clear... I'm not suggesting we actually start merging
the pull requests. That's something we decided against earlier. What I'm
suggesting is that we keep them enabled and (let Nicholas) forward the
authors to the proper developer channels. In this context a pull request
is an expression of an _intent_ - "I'd like to have my code merged in
OpenVPN". If the authors can express this intent a very lightweight
fashion I'm all for it.

Once we know someone wants their code merged, we can say "Hey, we
noticed you wanted to get this code to OpenVPN. Could you send your
patch to openvpn-devel?". It's much more difficult to say "Nah, too much
bureaucracy involved" when asked directly, than when one is looking at
our developer docs in the Wiki. With some luck we can lure more active
developers to openvpn-devel and #openvpn-devel.

Samuli

> Do you need a middle man to monitor github and forword patches to the
> devel mailing list along with commenting back and forth between
> github?  I'm not well versed in compiled languages but I am no
> stranger to basic code review and developer interactions.
>
> I'd volunteer if you need someone to do this.  I'm a long time lurker,
> user, and contributor to EasyRSA.
>
> Apologize for the top post. Currently mobile.
>
> On Aug 20, 2013 5:04 AM, "David Sommerseth"
> <openvpn.list@...1114... <mailto:openvpn.list@...1114...>>
> wrote:
>
>     On 20/08/13 11:29, Gert Doering wrote:
>     > Hi,
>     >
>     > On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp=E4nen wrote:
>     >>> We've had questions on #openvpn-devel about pull request 7,
>     which was the
>     >>> first time (on request *7*) that anyone was taking note that
>     we offer
>     >>> pull requests at all - so there's 7 pull requests out there
>     that are ignored.
>     >> Well, we don't have the manpower to look at Trac bug reporting,
>     and we
>     >> still don't disable bug reporting, do we? :)
>     >
>     > This is a problem, indeed.  But it's not an argument for adding
>     yet another
>     > queue that we don't look at.
>
>     In addition, we don't have "competing" alternatives to bug tracking on
>     the table.  And we need bug tracking, unfortunately.
>
>     >> Anyways, I can keep an eye on the pull requests and if something
>     >> interesting pops up, I can forward those people to
>     openvpn-devel. Or, if
>     >> we really want to disable pull requests, we should monitor the
>     OpenVPN
>     >> forks in GitHub for something interesting, and encourage people
>     to push
>     >> their stuff to main development line.
>     >
>     > I've never understood the hype around github, tbh.  If you see
>     value in
>     > adding to your workload, feel free to - but really, evidence
>     speaks against
>     > enabling pull requests.
>
>     +1
>
>     > Also, Dazo and I won't actually *use* git-pull to fetch those,
>     so one
>     > of the big reasons why you would want that ("to enable git
>     pull") wouldn't
>     > apply anyway.  We have agreed on a workflow how to integrate
>     patches, and
>     > "pull" is not part of it.  "git am" and "git push" are...
>
>     Even James sends patches to the mailing list for review nowadays,
>     so we
>     don't even do git pull from his repos.
>
>     We've settled a long time ago that we wanted to review patches on
>     the ML
>     to keep track of the process in a distributed manner (reviews are not
>     stored in a single server or with a single provider).
>
>     Github can have some kind of review as well, but is doing it in a
>     centralised manner.  And it would require us to write new scripts to
>     automate git pulls as well - to get those extra review lines we add to
>     the commit logs.  And if Github disappears, changes URL schema or
>     similar things, we've lost the references to the review.  On the
>     mailing
>     list, there is at least the Message-ID which is unique enough to even
>     use in google searches.  Nothing is really lost if gmane.org
>     <http://gmane.org> or
>     sourceforge.net <http://sourceforge.net> shuts down.
>
>
>     --
>     kind regards,
>
>     David Sommerseth
>
>
>     ---------------------------------------------------------------------=
---------
>     Introducing Performance Central, a new site from SourceForge and
>     AppDynamics. Performance Central is your source for news, insights,
>     analysis and resources for efficient Application Performance
>     Management.
>     Visit us today!
>     http://pubads.g.doubleclick.net/gampad/clk?id=3D48897511&iu=3D/4140/o=
stg.clktrk
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



--------------050609010102000304070702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Nicholas,<br>
      <br>
      We can always use a good lurkers and contributors :). You could
      definitely keep an eye on what happening on GitHub (OpenVPN forks
      and/or pull requests) and keep us updated on interesting changes.
      The last time I looked there was ~1 pull request per month. It
      possible that there are also forks with some useful changes.<br>
      <br>
      Just to make this clear... I'm not suggesting we actually start
      merging the pull requests. That's something we decided against
      earlier. What I'm suggesting is that we keep them enabled and (let
      Nicholas) forward the authors to the proper developer channels. In
      this context a pull request is an expression of an _intent_ - "I'd
      like to have my code merged in OpenVPN". If the authors can
      express this intent a very lightweight fashion I'm all for it.<br>
      <br>
      Once we know someone wants their code merged, we can say "Hey, we
      noticed you wanted to get this code to OpenVPN. Could you send
      your patch to openvpn-devel?". It's much more difficult to say
      "Nah, too much bureaucracy involved" when asked directly, than
      when one is looking at our developer docs in the Wiki. With some
      luck we can lure more active developers to openvpn-devel and
      #openvpn-devel.<br>
      <br>
      Samuli<br>
      <br>
    </div>
    <blockquote
cite="mid:CAK6ywbJ_74XGtF4GjmG5P7N8D3zZ+A5Y47v6JZoP1gfDzC9JnQ@...278..."
      type="cite">
      <p dir="ltr">Do you need a middle man to monitor github and
        forword patches to the devel mailing list along with commenting
        back and forth between github?&nbsp; I'm not well versed in compiled
        languages but I am no stranger to basic code review and
        developer interactions.</p>
      <p dir="ltr">I'd volunteer if you need someone to do this.&nbsp; I'm a
        long time lurker, user, and contributor to EasyRSA.</p>
      <p dir="ltr">Apologize for the top post. Currently mobile.</p>
      <div class="gmail_quote">On Aug 20, 2013 5:04 AM, "David
        Sommerseth" &lt;<a moz-do-not-send="true"
          href="mailto:openvpn.list@...1114...">openvpn.list@...1114...</a>&gt;
        wrote:<br type="attribution">
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          On 20/08/13 11:29, Gert Doering wrote:<br>
          &gt; Hi,<br>
          &gt;<br>
          &gt; On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp&auml;nen
          wrote:<br>
          &gt;&gt;&gt; We've had questions on #openvpn-devel about pull
          request 7, which was the<br>
          &gt;&gt;&gt; first time (on request *7*) that anyone was
          taking note that we offer<br>
          &gt;&gt;&gt; pull requests at all - so there's 7 pull requests
          out there that are ignored.<br>
          &gt;&gt; Well, we don't have the manpower to look at Trac bug
          reporting, and we<br>
          &gt;&gt; still don't disable bug reporting, do we? :)<br>
          &gt;<br>
          &gt; This is a problem, indeed. &nbsp;But it's not an argument for
          adding yet another<br>
          &gt; queue that we don't look at.<br>
          <br>
          In addition, we don't have "competing" alternatives to bug
          tracking on<br>
          the table. &nbsp;And we need bug tracking, unfortunately.<br>
          <br>
          &gt;&gt; Anyways, I can keep an eye on the pull requests and
          if something<br>
          &gt;&gt; interesting pops up, I can forward those people to
          openvpn-devel. Or, if<br>
          &gt;&gt; we really want to disable pull requests, we should
          monitor the OpenVPN<br>
          &gt;&gt; forks in GitHub for something interesting, and
          encourage people to push<br>
          &gt;&gt; their stuff to main development line.<br>
          &gt;<br>
          &gt; I've never understood the hype around github, tbh. &nbsp;If
          you see value in<br>
          &gt; adding to your workload, feel free to - but really,
          evidence speaks against<br>
          &gt; enabling pull requests.<br>
          <br>
          +1<br>
          <br>
          &gt; Also, Dazo and I won't actually *use* git-pull to fetch
          those, so one<br>
          &gt; of the big reasons why you would want that ("to enable
          git pull") wouldn't<br>
          &gt; apply anyway. &nbsp;We have agreed on a workflow how to
          integrate patches, and<br>
          &gt; "pull" is not part of it. &nbsp;"git am" and "git push" are...<br>
          <br>
          Even James sends patches to the mailing list for review
          nowadays, so we<br>
          don't even do git pull from his repos.<br>
          <br>
          We've settled a long time ago that we wanted to review patches
          on the ML<br>
          to keep track of the process in a distributed manner (reviews
          are not<br>
          stored in a single server or with a single provider).<br>
          <br>
          Github can have some kind of review as well, but is doing it
          in a<br>
          centralised manner. &nbsp;And it would require us to write new
          scripts to<br>
          automate git pulls as well - to get those extra review lines
          we add to<br>
          the commit logs. &nbsp;And if Github disappears, changes URL schema
          or<br>
          similar things, we've lost the references to the review. &nbsp;On
          the mailing<br>
          list, there is at least the Message-ID which is unique enough
          to even<br>
          use in google searches. &nbsp;Nothing is really lost if <a
            moz-do-not-send="true" href="http://gmane.org"
            target="_blank">gmane.org</a> or<br>
          <a moz-do-not-send="true" href="http://sourceforge.net"
            target="_blank">sourceforge.net</a> shuts down.<br>
          <br>
          <br>
          --<br>
          kind regards,<br>
          <br>
          David Sommerseth<br>
          <br>
          <br>
------------------------------------------------------------------------------<br>
          Introducing Performance Central, a new site from SourceForge
          and<br>
          AppDynamics. Performance Central is your source for news,
          insights,<br>
          analysis and resources for efficient Application Performance
          Management.<br>
          Visit us today!<br>
          <a moz-do-not-send="true"
href="http://pubads.g.doubleclick.net/gampad/clk?id=48897511&amp;iu=/4140/ostg.clktrk"
            target="_blank">http://pubads.g.doubleclick.net/gampad/clk?id=48897511&amp;iu=/4140/ostg.clktrk</a><br>
          _______________________________________________<br>
          Openvpn-devel mailing list<br>
          <a moz-do-not-send="true"
            href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>
          <a moz-do-not-send="true"
            href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel"
            target="_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------050609010102000304070702--

