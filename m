MIME-Version: 1.0
In-Reply-To: <95391fd4-7b2f-389c-3752-4123d016286d@...68...>
References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<95391fd4-7b2f-389c-3752-4123d016286d@...68...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 14 Oct 2016 21:51:38 +0200
Message-ID: <CAA1AbxLYBTUPyQBZy-pvyV8gmgBjvLcB4DFAV8_aJuNFspMB5w@...278...>
Content-Type: multipart/alternative; boundary=001a113d07f4f4d8a8053ed88da4
Subject: Re: [Openvpn-devel] Separate apt repositories for 2.4-alpha/beta/rc
	releases?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113d07f4f4d8a8053ed88da4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 14 Oct 2016 9:14 p.m., "Matthias Andree" <matthias.andree@...68...> wrot=
e:
>
> Am 14.10.2016 um 17:28 schrieb Samuli Sepp=C3=A4nen:
> > Hi,
> >
> > Should we have a separate apt repository for "unstable" apt packages?
> > Right now our apt repositories hold 2.3.x packages, meaning that
> > upgrades have historically been fairly minor.
> >
> > That said, users who use _our_ apt repositories have expressed interest
> > in using something newer than what is available in their distribution's
> > repositories.
> >
> > Would 2.3.12 -> 2.4-alpha1 be too big an upgrade?
> >
> Yes, definitely. Please create a separate distribution for .deb packages
> derived from pre-releases.

Indeed. We shouldn't upgrade people who are expecting stable releases to
alpha versions.

-Steffan

--001a113d07f4f4d8a8053ed88da4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On 14 Oct 2016 9:14 p.m., &quot;Matthias Andree&quot; &lt;<a=
 href=3D"mailto:matthias.andree@...68...">matthias.andree@...68...</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Am 14.10.2016 um 17:28 schrieb Samuli Sepp=C3=A4nen:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Should we have a separate apt repository for &quot;unstable&quot;=
 apt packages?<br>
&gt; &gt; Right now our apt repositories hold 2.3.x packages, meaning that<=
br>
&gt; &gt; upgrades have historically been fairly minor.<br>
&gt; &gt;<br>
&gt; &gt; That said, users who use _our_ apt repositories have expressed in=
terest<br>
&gt; &gt; in using something newer than what is available in their distribu=
tion&#39;s<br>
&gt; &gt; repositories.<br>
&gt; &gt;<br>
&gt; &gt; Would 2.3.12 -&gt; 2.4-alpha1 be too big an upgrade?<br>
&gt; &gt;<br>
&gt; Yes, definitely. Please create a separate distribution for .deb packag=
es<br>
&gt; derived from pre-releases.</p>
<p dir=3D"ltr">Indeed. We shouldn&#39;t upgrade people who are expecting st=
able releases to alpha versions. </p>
<p dir=3D"ltr">-Steffan </p>

--001a113d07f4f4d8a8053ed88da4--

