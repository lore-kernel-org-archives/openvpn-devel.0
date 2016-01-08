MIME-Version: 1.0
References: <567EA6B5.9040108@...277...>
	<20160108185312.GO24952@...1296...>
In-Reply-To: <20160108185312.GO24952@...1296...>
From: Mike Auty <mike.auty@...277...>
Date: Fri, 08 Jan 2016 20:32:43 +0000
Message-ID: <CAHxAb_VkaGTxf=Cue=B3MWGhQhRukHPs4DcnEyOZrT9Jxz52-w@...278...>
Content-Type: multipart/alternative; boundary=001a114106fad5a7830528d87d53
Subject: Re: [Openvpn-devel] Fabian Knittel's 802.1q/VLAN tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2108...>

--001a114106fad5a7830528d87d53
Content-Type: text/plain; charset=UTF-8

Hiya Gert,

Thanks for the reply.  Obviously I'd prefer to see this merged into the
main codebase than have to maintain the changes externally as the tree
changes, but I understand the nature of volunteer projects.  I'm happy to
submit the patches individually, but I'm slightly concerned that the
original author made corrections as he went along, meaning there are many
more patches than actual changes to the code.

I'm not sure how to squash the patches down and maintain the authorship and
appropriate comments?  Is there a simple way to do this or will I have to
have ask the author to recraft and minimize the commits?

If this feature doesn't make it into 2.4, is it significant enough to have
to wait for 2.5 before it becomes mainlined or could it see the light of
day in a 2.4.x release?  I'd primarily like to ensure that all requirements
for getting it integrated are met and that it does then get integrated
(since the patchset had existed against various trees since 2011 and trying
to follow the history it isn't clear why it hasn't been merged earlier
other than interest).

I'm not sure how to generate more interest (and I'm slightly surprised more
people aren't asking for this feature, given it can reduce multiple
instances of openvpn down to a single multi-vlan endpoint).  Do you have
any suggestions for how to deal with this requirement (given the others are
largely technical)?

Thanks for your help,

Mike 5:)

On Fri, 8 Jan 2016, 18:53 Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sat, Dec 26, 2015 at 02:39:49PM +0000, Mike Auty wrote:
> [..]
> > Given I didn't author most of these patches (I fixed up a tiny bit of
> > documentation at the end), I was wondering how best to supply these so
> > that they could be considered for inclusion in the main tree?  Should
> > I submit a pull request from my repo with all the patches applied [4],
> > or post the git format-patches to this mailing list, or is there
> > another method I should be using?
>
> I'm aware of these patches (as is David), but so far the interest has not
> been high enough to prioritize them and get them properly reviewed and
> tested.  As you have noticed, the patch set is fairly big, and touches
> quite a bit of code - and since we'll have to maintain that code from
> that point on, it needs to fulfill "enough interest" and "the currently
> active maintainers understand it well enough" (for the packet code, that
> would be mostly Arne and I...)
>
> Process-wise, we do not deal in pull requests but patches need to be sent
> (with git send-email) to the openvpn-devel list for public review, and
> merging with a reference to the public list archive.
>
> I'm not saying that these patches won't go in - but it will not happen
> in the close future.  Main focus right now is to get lots of small things
> fixed, get AEAD, pushable ciphers and iservice in, and release 2.4.0
> (so people can enjoy proper dual-stack support, proper IPv6-over-IPv6
> support, full peer-id floating, etc.) - and since interest for vlan
> tagging has not been that high, it's likely not going in.
>
> Sorry if that wasn't the reply you wanted to hear.  We're doing our best,
> but days are short...
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--001a114106fad5a7830528d87d53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hiya Gert,</p>
<p dir=3D"ltr">Thanks for the reply.=C2=A0 Obviously I&#39;d prefer to see =
this merged into the main codebase than have to maintain the changes extern=
ally as the tree changes, but I understand the nature of volunteer projects=
.=C2=A0 I&#39;m happy to submit the patches individually, but I&#39;m sligh=
tly concerned that the original author made corrections as he went along, m=
eaning there are many more patches than actual changes to the code.=C2=A0=
=C2=A0 </p>
<p dir=3D"ltr">I&#39;m not sure how to squash the patches down and maintain=
 the authorship and appropriate comments?=C2=A0 Is there a simple way to do=
 this or will I have to have ask the author to recraft and minimize the com=
mits?</p>
<p dir=3D"ltr">If this feature doesn&#39;t make it into 2.4, is it signific=
ant enough to have to wait for 2.5 before it becomes mainlined or could it =
see the light of day in a 2.4.x release?=C2=A0 I&#39;d primarily like to en=
sure that all requirements for getting it integrated are met and that it do=
es then get integrated (since the patchset had existed against various tree=
s since 2011 and trying to follow the history it isn&#39;t clear why it has=
n&#39;t been merged earlier other than interest).</p>
<p dir=3D"ltr">I&#39;m not sure how to generate more interest (and I&#39;m =
slightly surprised more people aren&#39;t asking for this feature, given it=
 can reduce multiple instances of openvpn down to a single multi-vlan endpo=
int).=C2=A0 Do you have any suggestions for how to deal with this requireme=
nt (given the others are largely technical)?</p>
<p dir=3D"ltr">Thanks for your help,</p>
<p dir=3D"ltr">Mike 5:)</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 8 Jan 2016, 18:53=
=C2=A0Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Sat, Dec 26, 2015 at 02:39:49PM +0000, Mike Auty wrote:<br>
[..]<br>
&gt; Given I didn&#39;t author most of these patches (I fixed up a tiny bit=
 of<br>
&gt; documentation at the end), I was wondering how best to supply these so=
<br>
&gt; that they could be considered for inclusion in the main tree?=C2=A0 Sh=
ould<br>
&gt; I submit a pull request from my repo with all the patches applied [4],=
<br>
&gt; or post the git format-patches to this mailing list, or is there<br>
&gt; another method I should be using?<br>
<br>
I&#39;m aware of these patches (as is David), but so far the interest has n=
ot<br>
been high enough to prioritize them and get them properly reviewed and<br>
tested.=C2=A0 As you have noticed, the patch set is fairly big, and touches=
<br>
quite a bit of code - and since we&#39;ll have to maintain that code from<b=
r>
that point on, it needs to fulfill &quot;enough interest&quot; and &quot;th=
e currently<br>
active maintainers understand it well enough&quot; (for the packet code, th=
at<br>
would be mostly Arne and I...)<br>
<br>
Process-wise, we do not deal in pull requests but patches need to be sent<b=
r>
(with git send-email) to the openvpn-devel list for public review, and<br>
merging with a reference to the public list archive.<br>
<br>
I&#39;m not saying that these patches won&#39;t go in - but it will not hap=
pen<br>
in the close future.=C2=A0 Main focus right now is to get lots of small thi=
ngs<br>
fixed, get AEAD, pushable ciphers and iservice in, and release 2.4.0<br>
(so people can enjoy proper dual-stack support, proper IPv6-over-IPv6<br>
support, full peer-id floating, etc.) - and since interest for vlan<br>
tagging has not been that high, it&#39;s likely not going in.<br>
<br>
Sorry if that wasn&#39;t the reply you wanted to hear.=C2=A0 We&#39;re doin=
g our best,<br>
but days are short...<br>
<br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297..." target=3D"_=
blank">gert@...1297...</a><br>
</blockquote></div>

--001a114106fad5a7830528d87d53--

