MIME-Version: 1.0
In-Reply-To: <20151210084614.GA24952@...1296...>
References: <1449691435-5928-1-git-send-email-gert@...1296...>
	<CAKuzo_iHtJjJRfubaBbSCn1=sTa9R_WUFR68JLj4p9as71_EDA@...278...>
	<20151210084614.GA24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 09:42:34 -0500
Message-ID: <CAKuzo_gW1vvu4-Cv=WZz-EREwzzd8gr7Hvn5PQrodECwJb-Ydg@...278...>
Content-Type: multipart/alternative; boundary=089e012298ecd6f5a505268c3875
Subject: Re: [Openvpn-devel] [PATCH] Fix isatty() check for good.
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

--089e012298ecd6f5a505268c3875
Content-Type: text/plain; charset=UTF-8

Hi,

As this fixes an important bug, please do merge as is.

I vaguely recall askpass behaves differently on linux than, say, bsd, so
even if reading from a pipe (when no controlling tty) is possible, it may
not always work. Will test it some other time..

On Thu, Dec 10, 2015 at 3:46 AM, Gert Doering <gert@...1296...> wrote:

> > Other than that, the patch does the right thing, and works well. Tested
> > using git- master with and without systemd. ACK from me.
>
> Given these two comments, shall we merge it "as it is", or do you want to
> suggest different text?  I'm fine with changing the text, but have no
> good suggestions.


Well, any wording is going to be incomplete, perhaps, so leave it as is..

Selva

--089e012298ecd6f5a505268c3875
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br></div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">As this fixes an important bu=
g, please do merge as is.<br><br></div><div class=3D"gmail_extra">I vaguely=
 recall askpass behaves differently on linux than, say, bsd, so even if rea=
ding from a pipe (when no controlling tty) is possible, it may not always w=
ork. Will test it some other time..<br><br></div><div class=3D"gmail_extra"=
><div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 3:46 AM, Gert Doering <=
span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">g=
ert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><spa=
n class=3D"">&gt; Other than that, the patch does the right thing, and work=
s well. Tested<br>
&gt; using git- master with and without systemd. ACK from me.<br>
<br>
</span>Given these two comments, shall we merge it &quot;as it is&quot;, or=
 do you want to<br>
suggest different text?=C2=A0 I&#39;m fine with changing the text, but have=
 no<br>
good suggestions.</blockquote><div><br></div><div>Well, any wording is goin=
g to be incomplete, perhaps, so leave it as is..<br><br></div><div>Selva<br=
></div></div><br><br></div></div>

--089e012298ecd6f5a505268c3875--

