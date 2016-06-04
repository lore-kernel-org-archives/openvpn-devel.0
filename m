MIME-Version: 1.0
In-Reply-To: <CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 4 Jun 2016 01:17:25 -0400
Message-ID: <CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
Content-Type: multipart/alternative; boundary=001a11449adc91978005346cf568
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

--001a11449adc91978005346cf568
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 3, 2016 at 2:37 PM, Selva Nair <selva.nair@...277...> wrote:

>
> On Fri, Jun 3, 2016 at 2:14 PM, Gert Doering <gert@...1296...> wrote:
>
>> On Fri, Jun 03, 2016 at 07:49:23PM +0200, David Sommerseth wrote:
>> > From: David Sommerseth <dazo@...2145...>
>> >
>> > Continuing to fix breakage caused by commit 40cb4cfc5d011102.
>> [..]
>>
>> Not having actually tested this, looking at it seems to properly quote
>> the bits that caused buildbot explosion and "make dist" fails (also as
>> discussed between David and Samuli on IRC).
>>
>> So - ACK!  Please apply and let's make the buildbots all green again :-)
>
>
> Don't know about bots, at least one human cross-compiling for windows is
> happy now..
>

The joy was short-lived. mingw cross-compile from release/2.3 tarball is
also broken:

    error: cannot find input file: `vendor/Makefile.in'

Thankfully, cherry-pick 41ab12f06253c fixes it.

IMO, the unit testing patches shouldn't have been merged into the release
branch

Selva


>
> Selva
>

--001a11449adc91978005346cf568
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Jun 3, 2016 at 2:37 PM, Selva Nair <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div class=3D"gmail_extra"><span class=3D""><br><div class=
=3D"gmail_quote">On Fri, Jun 3, 2016 at 2:14 PM, Gert Doering <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1725...=
..</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><span>On Fri, Jun 03, 2016 at 07:49:23PM +0200, David Sommerseth wrote:<=
br>
&gt; From: David Sommerseth &lt;<a href=3D"mailto:dazo@...2145..." target=
=3D"_blank">dazo@...2145...</a>&gt;<br>
&gt;<br>
&gt; Continuing to fix breakage caused by commit 40cb4cfc5d011102.<br>
</span>[..]<br>
<br>
Not having actually tested this, looking at it seems to properly quote<br>
the bits that caused buildbot explosion and &quot;make dist&quot; fails (al=
so as<br>
discussed between David and Samuli on IRC).<br>
<br>
So - ACK!=C2=A0 Please apply and let&#39;s make the buildbots all green aga=
in :-)</blockquote></div><br></span>Don&#39;t know about bots, at least one=
 human cross-compiling for windows is happy now..</div></div></blockquote><=
div><br></div><div>The joy was short-lived. mingw cross-compile from releas=
e/2.3 tarball is also broken:<br><br>=C2=A0=C2=A0=C2=A0 error: cannot find =
input file: `vendor/Makefile.in&#39;<br><br></div><div>Thankfully, cherry-p=
ick 41ab12f06253c fixes it.<br></div><div><br>IMO, the unit testing patches=
 shouldn&#39;t have been merged into the release branch<br><br></div><div>S=
elva<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><span class=3D""><font color=3D"#888888"><div c=
lass=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></font=
></span></div>
</blockquote></div><br></div></div>

--001a11449adc91978005346cf568--

