MIME-Version: 1.0
In-Reply-To: <5755C95E.9080401@...2080...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<5755C95E.9080401@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 6 Jun 2016 16:08:29 -0400
Message-ID: <CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
Content-Type: multipart/alternative; boundary=001a114115c20535860534a1a427
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
	framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114115c20535860534a1a427
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Jun 6, 2016 at 3:05 PM, David Sommerseth <
openvpn@...2080...> wrote:

>
> > IMO, the unit testing patches shouldn't have been merged into the
> > release branch
>
> I did think consider this, but ended up applying them to release/2.3 as
> well.  My thought is that once we start having more unit tests included,
> we should be able to at least add some of those tests to the release/2.3
> branch too.  There are code which is refactored so much it won't be easy
> to do, but there are also plenty of code which haven't changed that
> dramatically.
>
> I see these first patches from Jens as framework (or infrastructure)
> patches, it doesn't mean we commit ourselves to adding unit-testing to
> release/2.3, but it gives the possibility to do so.  Our 2.3 releases
> will continue to live in parallel with the future 2.4 release for quite
> some time.


I'm of the view that "unit tests" aid development but not much useful for
maintenance. So why add unit tests to a stable code-base that should only
get bug fixes (i.e., fixes for bugs that show up in real use).

On top of that, adding unit tests into an existing code like openvpn will
involve a lot of refactoring. The ROI on backporting any such tests to 2.3
does not look worth the effort.

Selva

--001a114115c20535860534a1a427
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Jun 6, 2016 at 3:05 PM, David S=
ommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." targe=
t=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<span><br>
&gt; IMO, the unit testing patches shouldn&#39;t have been merged into the<=
br>
&gt; release branch<br>
<br>
</span>I did think consider this, but ended up applying them to release/2.3=
 as<br>
well.=C2=A0 My thought is that once we start having more unit tests include=
d,<br>
we should be able to at least add some of those tests to the release/2.3<br>
branch too.=C2=A0 There are code which is refactored so much it won&#39;t b=
e easy<br>
to do, but there are also plenty of code which haven&#39;t changed that<br>
dramatically.<br>
<br>
I see these first patches from Jens as framework (or infrastructure)<br>
patches, it doesn&#39;t mean we commit ourselves to adding unit-testing to<=
br>
release/2.3, but it gives the possibility to do so.=C2=A0 Our 2.3 releases<=
br>
will continue to live in parallel with the future 2.4 release for quite<br>
some time.</blockquote></div></div><div class=3D"gmail_extra"><br></div><di=
v class=3D"gmail_extra">I&#39;m of the view that &quot;unit tests&quot; aid=
 development but not much useful for maintenance. So why add unit tests to =
a stable code-base that should only get bug fixes (i.e., fixes for bugs tha=
t show up in real use).</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">On top of that, adding unit tests into an existing code l=
ike openvpn will involve a lot of refactoring. The ROI on backporting any s=
uch tests to 2.3 does not look worth the effort.=C2=A0<br></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a114115c20535860534a1a427--

