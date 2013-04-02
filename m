MIME-Version: 1.0
In-Reply-To: <515AE151.5030900@...1227...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
	<20130401184834.GE428@...1296...>
	<CAEsd45RkiWG0F9st=s-SE0SW428yE-bEFL6WBMJBgXHTjYwXQA@...278...>
	<515AE151.5030900@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Tue, 2 Apr 2013 14:24:43 -0400
Message-ID: <CAEsd45RkTJta9D_xOj7koLg_uDfZnJcGUQ9hhX++NS+J6Us82w@...278...>
Content-Type: multipart/alternative; boundary=f46d043d67ef53d71104d964dcdd
Subject: Re: [Openvpn-devel] building on OSX (for Tunnelblick)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Harold Molina-Bulla <h.molina@...277...>

--f46d043d67ef53d71104d964dcdd
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 2, 2013 at 9:46 AM, Arne Schwabe <arne@...1227...> wrote:

> > Tunnelblick is still being built on OS X 10.6.8 with Xcode 3.2.2
> > because it still supports PowerPC, which later versions of Xcode
> > (which are required for use on 10.7+) don't support.
> Is there a specific reason for Xcode 3.2.2? I set up a 10.6.8 snow
> leopard with 3.2.2 and did not have net/if_utun.h. However Xcode 3.2.6
> includes net/if_utun.h and utun works on the test machine (and also
> include the powerpc-* gcc binaries)
>

Xcode 3.2.6 does not generate PPC code for the *Tunnelblick* part (written
in Objective-C).

At least, it doesn't have a way to select an architecture of "Universal
32-bit" (meaning 32-bit PPC & i386), only "32-bit Intel", "64-bit Intel",
or "Standard (32/64-bit Intel)".

There is an "Other" setting, but I haven't been able to set that to
anything that makes "Universal 32-bit" (meaning 32-bit PPC & i386).

In the past I've been willing to forego 64-bit to get 32-bit PPC/Intel, but
of course 32/64 PPC/Intel would be great.

--f46d043d67ef53d71104d964dcdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2013 at 9:46 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">


&gt; Tunnelblick is still being built on OS X 10.6.8 with Xcode 3.2.2<br>
&gt; because it still supports PowerPC, which later versions of Xcode<br>
&gt; (which are required for use on 10.7+) don&#39;t support.<br>
Is there a specific reason for Xcode 3.2.2? I set up a 10.6.8 snow<br>
leopard with 3.2.2 and did not have net/if_utun.h. However Xcode 3.2.6<br>
includes net/if_utun.h and utun works on the test machine (and also<br>
include the powerpc-* gcc binaries)<br></blockquote><div><br></div><div>Xco=
de 3.2.6 does not generate PPC code for the <u>Tunnelblick</u> part (writte=
n in Objective-C).</div><div><br></div><div>At least, it doesn&#39;t have a=
 way to select an architecture of &quot;Universal 32-bit&quot; (meaning 32-=
bit PPC &amp; i386), only &quot;32-bit Intel&quot;, &quot;64-bit Intel&quot=
;, or &quot;Standard (32/64-bit Intel)&quot;.</div>

<div><br></div><div>There is an &quot;Other&quot; setting, but I haven&#39;=
t been able to set that to anything that makes &quot;Universal 32-bit&quot;=
 (meaning 32-bit PPC &amp; i386).</div><div><br></div><div>In the past I&#3=
9;ve been willing to forego 64-bit to get 32-bit PPC/Intel, but of course 3=
2/64 PPC/Intel would be great.</div>

<div><br></div></div>

--f46d043d67ef53d71104d964dcdd--

