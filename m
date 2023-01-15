MIME-Version: 1.0
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <CAKuzo_i+zwgpg_zq050WQtNm+s0p-OMDkLGUUHn+hSApJfrorA@...278...>
 <1d60ed5a-0a1c-9723-b797-78663f477633@...1227...>
In-Reply-To: <1d60ed5a-0a1c-9723-b797-78663f477633@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 15 Jan 2023 11:51:58 -0500
Message-ID: <CAKuzo_gSCb_mydAbHeaVdbHOG9Km2fZLyOaQoCrrCDqQei0sJA@...278...>
Content-Type: multipart/alternative; boundary="000000000000e0931d05f2504963"
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--000000000000e0931d05f2504963
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Jan 15, 2023 at 8:53 AM Arne Schwabe <arne@...1227...> wrote:

> Am 15.01.23 um 14:23 schrieb Selva Nair:
> > Hi,
> >
> >     We would like to be able to continue to build/ship OpenVPN with mbed
> >     TLS. We want all contributors to ask if they agree to license change
> >     that adds explicit permission to link with Apache 2 licensed
> libraries:
> >
> >
> >     Special exception for linking OpenVPN with Apache 2 licensed
> libraries:
> >
> >         In addition, as a special exception, OpenVPN Inc and contributors
> >         give permission to link the code of this program to libraries
> >     with the
> >         "APACHE LICENSE, VERSION 2.0", and distribute linked combination
> >         including the two.  You must obey the GNU General Public License
> in
> >         all respects for all of the code used other than these
> >     libraries.  If
> >         you modify this file, you may extend this exception to your
> >     version of
> >         the file, but you are not obligated to do so.  If you do not
> wish to
> >         do so, delete this exception statement from your version.
> >
> >
> > Instead of this exemption I would vote for a change to 'GPL v2 or any
> > later version'.
> > That would keep the license in the spirit by which people like me
> > contributed.
> >
> > Using an existing license that has already been vetted also avoids the
> need
> > for legal counsel.
> >
> > I do not understand the argument about 'GPLv2 and later...' and embedded
> > devices. Those who
> > are currently embedding based on GPL v2 can continue to do so, those who
> > want/need v3
> > can do so too. Those who need v3 but also want to lock the firmware on a
> > consumer device
> > may be affected. But that's a choice they make, why would we want to
> > promote that?
> >
> > Some may find this discussion a waste of time but let's not belittle
> > people's contributions.
> > I do care about how my work is licensed.
>
> Okay. I think the embedded thing is a bit of a misunderstanding. I am
> not trying to promote that. What I wanted is to express why changing to
> GPLv3 might not be an option as some license holders of OpenVPN will not
> be okay with changing to GPL3 since they need that.


Thanks for the clarification. I was not aware of that.
That's very unfortunate, though. So some want to keep the loopholes of GPL
v2, and also the goodies that come with an Apache 2.0 exception, all
together!

So the situation is basically, we need somehow to still be able to link
> Apache 2.0 licensed SSL libraries. While we have an exception for
> OpenSSL, some might argue that this only covers the old OpenSSL license.
>
> So to go forward we either need to change OpenVPN 2.x to a license
> compatible with Apache 2.0 like GPL3 or adding an excerption for linking
> against Apache 2.0.
>
> At the hackathon we discussed the options and there already voices
> against going GPL3 instead of GPL2 but everyone there was okay with
> staying with GPL2 and adding an exception.
>
> This approach of taking the exception route instead of GPL3 is mostly a
> pragmatic approach to be able to have something that might have a chance
> of succeeding.


Given all that, I'll reluctantly agree to the proposed exception.

It's not critical at this stage, but the wording "...libraries with the
'APACHE LICENSE, VERSION 2.0', ..." sounds ambiguous. Is that a legally
vetted form or a draft?

Selva

--000000000000e0931d05f2504963
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sun, Jan 15, 2023 at 8:53 AM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 15.01=
.23 um 14:23 schrieb Selva Nair:<br>
&gt; Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We would like to be able to continue to build/ship =
OpenVPN with mbed<br>
&gt;=C2=A0 =C2=A0 =C2=A0TLS. We want all contributors to ask if they agree =
to license change<br>
&gt;=C2=A0 =C2=A0 =C2=A0that adds explicit permission to link with Apache 2=
 licensed libraries:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Special exception for linking OpenVPN with Apache 2=
 licensed libraries:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In addition, as a special exception, =
OpenVPN Inc and contributors<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0give permission to link the code of t=
his program to libraries<br>
&gt;=C2=A0 =C2=A0 =C2=A0with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;APACHE LICENSE, VERSION 2.0&quo=
t;, and distribute linked combination<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0including the two.=C2=A0 You must obe=
y the GNU General Public License in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0all respects for all of the code used=
 other than these<br>
&gt;=C2=A0 =C2=A0 =C2=A0libraries.=C2=A0 If<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0you modify this file, you may extend =
this exception to your<br>
&gt;=C2=A0 =C2=A0 =C2=A0version of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the file, but you are not obligated t=
o do so.=C2=A0 If you do not wish to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do so, delete this exception statemen=
t from your version.<br>
&gt; <br>
&gt; <br>
&gt; Instead of this exemption=C2=A0I would vote for a change to &#39;GPL v=
2 or any <br>
&gt; later version&#39;.<br>
&gt; That would keep the license in the spirit by which people like me <br>
&gt; contributed.<br>
&gt; <br>
&gt; Using an existing=C2=A0license that has already been vetted also avoid=
s the need<br>
&gt; for legal counsel.<br>
&gt; <br>
&gt; I do not understand the argument about &#39;GPLv2 and later...&#39; an=
d embedded <br>
&gt; devices. Those who<br>
&gt; are currently=C2=A0embedding based on GPL v2 can continue to do so, th=
ose who <br>
&gt; want/need v3<br>
&gt; can do so too. Those who need=C2=A0v3 but also want to lock the firmwa=
re=C2=A0on a <br>
&gt; consumer device<br>
&gt; may be affected. But that&#39;s a choice they make, why would we want =
to <br>
&gt; promote that?<br>
&gt; <br>
&gt; Some may find this discussion a waste of time but let&#39;s not belitt=
le <br>
&gt; people&#39;s contributions.<br>
&gt; I do care about how my work is licensed.<br>
<br>
Okay. I think the embedded thing is a bit of a misunderstanding. I am <br>
not trying to promote that. What I wanted is to express why changing to <br>
GPLv3 might not be an option as some license holders of OpenVPN will not <b=
r>
be okay with changing to GPL3 since they need that.=C2=A0</blockquote><div>=
<br></div><div>Thanks for the clarification. I was not aware of that.=C2=A0=
</div><div>That&#39;s very=C2=A0unfortunate, though. So some want to keep t=
he loopholes of GPL v2, and also the goodies that come=C2=A0with an Apache=
=C2=A02.0 exception, all together!</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
So the situation is basically, we need somehow to still be able to link <br>
Apache 2.0 licensed SSL libraries. While we have an exception for <br>
OpenSSL, some might argue that this only covers the old OpenSSL license.<br>
<br>
So to go forward we either need to change OpenVPN 2.x to a license <br>
compatible with Apache 2.0 like GPL3 or adding an excerption for linking <b=
r>
against Apache 2.0.<br>
<br>
At the hackathon we discussed the options and there already voices <br>
against going GPL3 instead of GPL2 but everyone there was okay with <br>
staying with GPL2 and adding an exception.<br>
<br>
This approach of taking the exception route instead of GPL3 is mostly a <br>
pragmatic approach to be able to have something that might have a chance <b=
r>
of succeeding.</blockquote><div><br></div><div>Given all that, I&#39;ll rel=
uctantly agree to the proposed exception.=C2=A0</div><div><br></div><div>It=
&#39;s not critical at this stage, but the wording &quot;...libraries with =
the &#39;APACHE LICENSE, VERSION 2.0&#39;, ...&quot; sounds ambiguous. Is t=
hat a legally vetted form or a draft?</div><div><br></div><div>Selva</div><=
/div></div>

--000000000000e0931d05f2504963--

