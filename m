MIME-Version: 1.0
In-Reply-To: <CAKuzo_gW1vvu4-Cv=WZz-EREwzzd8gr7Hvn5PQrodECwJb-Ydg@...278...>
References: <1449691435-5928-1-git-send-email-gert@...1296...>
	<CAKuzo_iHtJjJRfubaBbSCn1=sTa9R_WUFR68JLj4p9as71_EDA@...278...>
	<20151210084614.GA24952@...1296...>
	<CAKuzo_gW1vvu4-Cv=WZz-EREwzzd8gr7Hvn5PQrodECwJb-Ydg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 11:29:49 -0500
Message-ID: <CAKuzo_i7WR5bfV3AEzLWjvym6wt-ib4jgcgg_5iFq456CKh+bA@...278...>
Content-Type: multipart/alternative; boundary=001a11478ae05f8a7105268db815
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

--001a11478ae05f8a7105268db815
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 9:42 AM, Selva Nair <selva.nair@...277...> wrote:

> I vaguely recall askpass behaves differently on linux than, say, bsd, so
> even if reading from a pipe (when no controlling tty) is possible, it may
> not always work. Will test it some other time..
>

Meant to say "getpass" not "askpass"

Selva

--001a11478ae05f8a7105268db815
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 9:42 AM, Selva Nair <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_ex=
tra">I vaguely recall askpass behaves differently on linux than, say, bsd, =
so even if reading from a pipe (when no controlling tty) is possible, it ma=
y not always work. Will test it some other time..<br></div></blockquote></d=
iv><br></div><div class=3D"gmail_extra">Meant to say &quot;getpass&quot; no=
t &quot;askpass&quot;<br><br></div><div class=3D"gmail_extra">Selva<br></di=
v></div>

--001a11478ae05f8a7105268db815--

