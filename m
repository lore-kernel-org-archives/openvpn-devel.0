MIME-Version: 1.0
In-Reply-To: <20160219113726.GZ24952@...1296...>
References: <1455864663-19751-1-git-send-email-selva.nair@...277...>
	<20160219113726.GZ24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Feb 2016 08:45:35 -0500
Message-ID: <CAKuzo_jEhjg5Gok-UbNowRMVMBf_WSU1YWm=yPebszd86hthbA@...278...>
Content-Type: multipart/alternative; boundary=001a11369a06deebd1052c1fb396
Subject: Re: [Openvpn-devel] [PATCH] Restrict options/configs for startup
 through interactive service
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

--001a11369a06deebd1052c1fb396
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for the quick feedback.

On Fri, Feb 19, 2016 at 6:37 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Feb 19, 2016 at 01:51:02AM -0500, Selva Nair wrote:
> > The pacth is in the next email.
> >
> > This is not yet tested extensively, but has passed some quick tests.
> > A simple approach of parsing the options string is used instead of
> passing structs:
> > the latter will break the GUI everytime a new option is added to the
> white-list.
> >
> > Current white-list is just what the GUI needs, but its easy to extend.
>
> Re-thinking the original argument, I agree that this is easier than
> a fixed structure (if only because you'd need to ensure that GUI and
> service are talking the same structure version...).
>
> I like what your patch is doing - it's more than "just the whitelist"
> but also the administrative restrictions ("if you are not administrator
> or part of the OpenVPN Admin group, only configs from a well-known
> directory, otherwise, do what you want").
>

And the admin (or at install time) could even change the "wheel" group name
to "Users" and bless every user too.


>
> From a C perspective, the code looks good to me.
>
> I'm a bit reluctant to ACK & merge it, I'd like a few more eyes look
> on this, from two angles
>
>  - is this feature-wise the way we want to go?  It "works for me"
>
>  - are the windows bits of the code change sane?  String manipulation and
>    wide strings and that stuff is something I have little experience with.
>

String conversions are indeed a pain. Could eliminate them if the code is
guaranteed to be compiled with -municode -D_UNICODE. Does anyone build a
non-unicode version on windows these days?

The whole of the service code will then need only one string conversion --
for passing the management password to stdin of openvpn.

Selva

--001a11369a06deebd1052c1fb396
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Thanks for the quick feedback.<br><br></div><div class=3D"gmai=
l_extra"><div class=3D"gmail_quote">On Fri, Feb 19, 2016 at 6:37 AM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div style=3D"overflow:hidden">Hi,<br>
<span><br>
On Fri, Feb 19, 2016 at 01:51:02AM -0500, Selva Nair wrote:<br>
&gt; The pacth is in the next email.<br>
&gt;<br>
&gt; This is not yet tested extensively, but has passed some quick tests.<b=
r>
&gt; A simple approach of parsing the options string is used instead of pas=
sing structs:<br>
&gt; the latter will break the GUI everytime a new option is added to the w=
hite-list.<br>
&gt;<br>
&gt; Current white-list is just what the GUI needs, but its easy to extend.=
<br>
<br>
</span>Re-thinking the original argument, I agree that this is easier than<=
br>
a fixed structure (if only because you&#39;d need to ensure that GUI and<br>
service are talking the same structure version...).<br>
<br>
I like what your patch is doing - it&#39;s more than &quot;just the whiteli=
st&quot;<br>
but also the administrative restrictions (&quot;if you are not administrato=
r<br>
or part of the OpenVPN Admin group, only configs from a well-known<br>
directory, otherwise, do what you want&quot;).<br></div></blockquote><div><=
br></div><div>And the admin (or at install time) could even change the &quo=
t;wheel&quot; group name to &quot;Users&quot; and bless every user too.<br>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"overflow:hidde=
n">
<br>
From a C perspective, the code looks good to me.<br>
<br>
I&#39;m a bit reluctant to ACK &amp; merge it, I&#39;d like a few more eyes=
 look<br>
on this, from two angles<br>
<br>
=C2=A0- is this feature-wise the way we want to go?=C2=A0 It &quot;works fo=
r me&quot;<br>
<br>
=C2=A0- are the windows bits of the code change sane?=C2=A0 String manipula=
tion and<br>
=C2=A0 =C2=A0wide strings and that stuff is something I have little experie=
nce with.</div></blockquote></div><br></div><div class=3D"gmail_extra">Stri=
ng conversions are indeed a pain. Could eliminate them if the code is guara=
nteed to be compiled with -municode -D_UNICODE. Does anyone build a non-uni=
code version on windows these days?<br><br></div><div class=3D"gmail_extra"=
>The whole of the service code will then need only one string conversion --=
 for passing the management password to stdin of openvpn.<br><br></div><div=
 class=3D"gmail_extra">Selva<br></div></div>

--001a11369a06deebd1052c1fb396--

