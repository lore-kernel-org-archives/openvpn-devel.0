MIME-Version: 1.0
In-Reply-To: <09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
	<CAKuzo_jXCPDbsn24i4LcsqovVXGNaQuc-PtwwucnVDvwpMQgYg@...278...>
	<09fc522c-b33f-1c9b-9def-854ae3c07c62@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 14:27:44 -0400
Message-ID: <CAKuzo_iC+gmgck4uY69k37tSMe-HAzn0uXJu7LwqxuMXP-Byxg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05602e159c1d0539e40b02
Subject: Re: [Openvpn-devel] autoconf/automake warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05602e159c1d0539e40b02
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 12, 2016 at 6:30 AM, David Sommerseth <
openvpn@...2080...> wrote:

> On 12/08/16 03:14, Selva Nair wrote:
> >
> >
> > On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>> wrote:
> >
> > -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >
> >
> > Hi,
> >
> > I noticed a few errors today when building OpenVPN on Fedora 23.
> > The attached patch resolves this.  But it breaks 'make' when it
> > reaches ./src/openvpnserv:
> >
> >
> > The patch is obviously useless as it breaks configuring.
> >
> >
> >
> > Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No
> > such file or directory
> >
> >
> > It is indeed caused by a bug in automake (bug#13928) because of
> > which variables in foo_SOURCES do not get expanded when
> > subdir-objects is specfied. Thus $(top_srcdir) in
> > $(top_srcdir)/src/openvpn/block_dns.c, for example,  causes a
> > folder literally named $(top_srcdir) created inside
> > src/openvpnserv/. But make wont find any files there and leads to
> > the missing file issues.
>
> Just thinking a bit around this and avoiding code duplication.  This
> might be a bit more hackish alternative, but bear with me :)
>
> If the Makefile.am in src/openvpnsrv has a build-target for the
> block_dns.c file which would just copy the source file to the
> openvpnserv/ directory ... would that work?
>
> Rough (not really tested) example is attached.


This is incomplete but could be made to work with some changes. However,
such a hackery is not needed in this particular case as one could simply
replace
$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h
in Makefile.am by
../../src/openvpn/block_dns.c ../../src/openvpn/block_dns.h
and use the subdir-objects option without issues.

But the problem is that, its not just these two files, we now have subdir
source references in places like
tests/unit_tests/plugins/auth-pam/Makefile.am as
well. Replacing $(top_srcdir) by something like "../../../../..." in deeply
nested directories would be error-prone and cumbersome. If/when more and
more tests get added this is going to get only worse.

I would say ignore the subdir-objects warning for now and we can
conditionally enable it when a version of automake that supports it without
breaking use of variables in foo_SOURCES becomes widely available. In the
mean time keep testing subdir-objects using a patched automake may be all
that we can do.

Selva

--94eb2c05602e159c1d0539e40b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Aug 12, 2016 at 6:30 AM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...<wbr=
>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204=
,204);border-left-style:solid;padding-left:1ex"><span>On 12/08/16 03:14, Se=
lva Nair wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Aug 11, 2016 at 2:50 PM, David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...1186...=
.2156...<wbr>.net</a><br>
</span><span>&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=
=3D"_blank">openvpn@...2157...<wbr>emmelig.net</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1<br>
&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I noticed a few errors today when building OpenVPN on Fedora 23.<br>
&gt; The attached patch resolves this.=C2=A0 But it breaks &#39;make&#39; w=
hen it<br>
&gt; reaches ./src/openvpnserv:<br>
&gt;<br>
&gt;<br>
&gt; The patch is obviously useless as it breaks configuring.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Makefile:505: ../../src/openvpn/.deps/openvp<wbr>nserv-block_dns.Po: N=
o<br>
&gt; such file or directory<br>
&gt;<br>
&gt;<br>
&gt; It is indeed caused by a bug in automake (bug#13928) because of<br>
&gt; which variables in foo_SOURCES do not get expanded when<br>
&gt; subdir-objects is specfied. Thus $(top_srcdir) in<br>
&gt; $(top_srcdir)/src/openvpn/bloc<wbr>k_dns.c, for example,=C2=A0 causes =
a<br>
&gt; folder literally named $(top_srcdir) created inside<br>
&gt; src/openvpnserv/. But make wont find any files there and leads to<br>
&gt; the missing file issues.<br>
<br>
</span>Just thinking a bit around this and avoiding code duplication.=C2=A0=
 This<br>
might be a bit more hackish alternative, but bear with me :)<br>
<br>
If the Makefile.am in src/openvpnsrv has a build-target for the<br>
block_dns.c file which would just copy the source file to the<br>
openvpnserv/ directory ... would that work?<br>
<br>
Rough (not really tested) example is attached.</blockquote></div><div class=
=3D"gmail_extra"><br></div>This is incomplete but could be made to work wit=
h some changes. However, such a hackery is not needed in this particular ca=
se as one could simply replace=C2=A0</div><div class=3D"gmail_extra">$(top_=
srcdir)/src/openvpn/bloc<wbr>k_dns.c $(top_srcdir)/src/openvpn/bloc<wbr>k_d=
ns.h=C2=A0</div><div class=3D"gmail_extra">in Makefile.am by</div><div clas=
s=3D"gmail_extra">../../src/openvpn/block_dns.c ../../src/openvpn/block_dns=
.h<br></div><div class=3D"gmail_extra">and use the subdir-objects option wi=
thout issues.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">But the problem is that, its not just these two files, we now have =
subdir source references in places like tests/unit_tests/plugins/auth-<wbr>=
pam/Makefile.am=C2=A0as well. Replacing $(top_srcdir) by something like &qu=
ot;../../../../...&quot; in deeply nested directories=C2=A0would be error-p=
rone and cumbersome. If/when more and more tests get added this is going to=
 get only worse.=C2=A0</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">I would say ignore the subdir-objects warning for now and =
we can conditionally enable it when a version of automake that supports it =
without breaking use of variables in foo_SOURCES becomes widely available. =
In the mean time keep testing subdir-objects using a patched automake may b=
e all that we can do.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra"><br><br></div></div>

--94eb2c05602e159c1d0539e40b02--

