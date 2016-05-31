MIME-Version: 1.0
In-Reply-To: <574DAECE.8000202@...2080...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
	<CAKuzo_gyWfFnOe72CKkyPfAHAfN5uF8jWqp2jCosdZkJBYwoBw@...278...>
	<574DAECE.8000202@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 May 2016 11:40:23 -0400
Message-ID: <CAKuzo_hYZJQYCmQ23hvUGtXADT0X8h=RSQRnaWmL2vnMCLwH8A@...278...>
Content-Type: multipart/alternative; boundary=001a11448a96200b270534253217
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11448a96200b270534253217
Content-Type: text/plain; charset=UTF-8

On Tue, May 31, 2016 at 11:33 AM, David Sommerseth <
openvpn@...2080...> wrote:

> > I just thought 64 is good enough and kept it simple like the
> > connection_list.
> >
> > Will consider making it dynamic if we go for a v2.
>
> I think a fixed list of 64 slots is more than good enough in this case.
> I even considered suggesting 32 slots, but 64 is reasonable as a maximum
> currently.  An average openvpn config is probably roughly 10-15 lines
> all in all (not considering inline files). If someone pushes more than
> 50-60 options, then something more funky is probably going on as well.
>
> *If* this limit gets too annoying, then I we can reconsider using a
> dynamic list.
>

This being filters its not really determined by how many options are being
pushed..

That said, agreed 64 may be plenty to filter out almost anything. The
paranoid can explicitly specify everything they want to keep as "accept"
and end with a 'pull-filter reject ""' to reject everything else.

Selva

--001a11448a96200b270534253217
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, May 31, 2016 at 11:33 AM, David Sommerseth <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt;=
 I just thought 64 is good enough and kept it simple like the<br>
&gt; connection_list.<br>
&gt;<br>
&gt; Will consider making it dynamic if we go for a v2.<br>
<br>
</span>I think a fixed list of 64 slots is more than good enough in this ca=
se.<br>
I even considered suggesting 32 slots, but 64 is reasonable as a maximum<br>
currently.=C2=A0 An average openvpn config is probably roughly 10-15 lines<=
br>
all in all (not considering inline files). If someone pushes more than<br>
50-60 options, then something more funky is probably going on as well.<br>
<br>
*If* this limit gets too annoying, then I we can reconsider using a<br>
dynamic list.<br></blockquote></div><br>This being filters its not really d=
etermined by how many options are being pushed..=C2=A0</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">That said, agreed 64 may b=
e plenty to filter out almost anything. The paranoid can explicitly specify=
 everything they want to keep as &quot;accept&quot; and end with a &#39;pul=
l-filter reject &quot;&quot;&#39; to reject everything else.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div><div clas=
s=3D"gmail_extra"><br></div></div>

--001a11448a96200b270534253217--

