MIME-Version: 1.0
In-Reply-To: <CAEsd45TCOgEOYzf3rYq5GrpXWHaL37Mn_4gwtjGrhxH3EjicCw@...278...>
References: <CAEsd45TNByqmFtmY54eB8506SyE=te7S89WLD3YpwdbLY7-mLA@...278...>
	<CAEsd45TCOgEOYzf3rYq5GrpXWHaL37Mn_4gwtjGrhxH3EjicCw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 30 May 2015 16:37:19 -0400
Message-ID: <CAEsd45ToQ=NDraEyepx8PBawvEz6L1U6S1w8c1LEEonMjtL_BA@...278...>
Content-Type: multipart/alternative; boundary=001a1134fad287fb6505175291db
Subject: Re: [Openvpn-devel] [Patch] Fail if options have extra parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1134fad287fb6505175291db
Content-Type: text/plain; charset=UTF-8

Please ignore this patch; it is an old version. I will resubmit. Sorry for
the noise.

On Fri, May 29, 2015 at 11:54 AM, Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Sorry, forgot to add a link to the ticket for this:
>
> https://community.openvpn.net/openvpn/ticket/557
>
> On Fri, May 29, 2015 at 11:38 AM, Jonathan K. Bullard
> <jkbullard@...277...> wrote:
> > The attached patch causes an error if an option has are extra
> > parameters; previously they were ignored.
> >
> > This feature was discussed on the openvpn-devel mailing list:
> > http://thread.gmane.org/gmane.network.openvpn.devel/9599
> >
> > The patch is for the master branch only -- the consensus of the
> > mailing list discussion was that the patch should not be included in
> > the 2.3 branch.
> >
> > The (modified) message "Unrecognized option or missing or extra
> > parameter(s)" is used except for a few options:
> >
> >      * The --help option: An extra parameter for --help generates a
> > specific error message after showing the syntax message. This is done
> > to help a user who tries "--help tls-cipher" or similar, hoping to get
> > more information about the "tls-cipher" option.
> >
> >      * The --dhcp-option option: It has its own similar message, into
> > which " or extra" has been inserted.
> >
> >      * Ten options such as --up that accept a command (instead of a
> > path) already detect extra parameters and generate specific error
> > messages that mention double-quoting commands which contain imbedded
> > spaces.
>

--001a1134fad287fb6505175291db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore this patch; it is an old version. I will res=
ubmit. Sorry for the noise.</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, May 29, 2015 at 11:54 AM, Jonathan K. Bullard <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">=
jkbullard@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Sorry, forgot to add a link to the ticket for this:<br>
<br>
<a href=3D"https://community.openvpn.net/openvpn/ticket/557" target=3D"_bla=
nk">https://community.openvpn.net/openvpn/ticket/557</a><br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Fri, May 29, 2015 at 11:38 AM, Jonathan K. Bullard<br>
&lt;<a href=3D"mailto:jkbullard@...277...">jkbullard@...277...</a>&gt; wrot=
e:<br>
&gt; The attached patch causes an error if an option has are extra<br>
&gt; parameters; previously they were ignored.<br>
&gt;<br>
&gt; This feature was discussed on the openvpn-devel mailing list:<br>
&gt; <a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/9599" t=
arget=3D"_blank">http://thread.gmane.org/gmane.network.openvpn.devel/9599</=
a><br>
&gt;<br>
&gt; The patch is for the master branch only -- the consensus of the<br>
&gt; mailing list discussion was that the patch should not be included in<b=
r>
&gt; the 2.3 branch.<br>
&gt;<br>
&gt; The (modified) message &quot;Unrecognized option or missing or extra<b=
r>
&gt; parameter(s)&quot; is used except for a few options:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * The --help option: An extra parameter for --help=
 generates a<br>
&gt; specific error message after showing the syntax message. This is done<=
br>
&gt; to help a user who tries &quot;--help tls-cipher&quot; or similar, hop=
ing to get<br>
&gt; more information about the &quot;tls-cipher&quot; option.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * The --dhcp-option option: It has its own similar=
 message, into<br>
&gt; which &quot; or extra&quot; has been inserted.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Ten options such as --up that accept a command (=
instead of a<br>
&gt; path) already detect extra parameters and generate specific error<br>
&gt; messages that mention double-quoting commands which contain imbedded<b=
r>
&gt; spaces.<br>
</div></div></blockquote></div><br></div>

--001a1134fad287fb6505175291db--

