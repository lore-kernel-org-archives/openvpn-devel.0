MIME-Version: 1.0
In-Reply-To: <201611241100.uAOB0o0r069804@...2054...>
References: <1479958527-29491-1-git-send-email-selva.nair@...277...>
	<201611241100.uAOB0o0r069804@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 24 Nov 2016 07:46:11 -0500
Message-ID: <CAKuzo_jnATCn7qfR2BEOLDUn_kOEny_6B-AZDdpgBeLXuWocgw@...278...>
Content-Type: multipart/alternative; boundary=001a1137623222813605420b6536
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Set IPv6 DNS servers using
	interactive service
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

--001a1137623222813605420b6536
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 24, 2016 at 6:00 AM, Gert Doering <gert@...1296...> wrote:

> +out:
> +  err = 0;
> +  free (cmdline);
> +  return err;
> +}
>
> .. which did not make sense, so I removed the "err = 0" line.


Good catch. That was a left over from testing ...

Selva

--001a1137623222813605420b6536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Nov 24, 2016 at 6:00 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span>+out:<br>
+=C2=A0 err =3D 0;<br>
+=C2=A0 free (cmdline);<br>
+=C2=A0 return err;<br>
+}<br>
<br>
</span>.. which did not make sense, so I removed the &quot;err =3D 0&quot; =
line.</blockquote></div><br></div><div class=3D"gmail_extra">Good catch. Th=
at was a left over from testing ...<br><br></div><div class=3D"gmail_extra"=
>Selva<br></div></div>

--001a1137623222813605420b6536--

