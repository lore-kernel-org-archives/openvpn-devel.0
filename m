MIME-Version: 1.0
In-Reply-To: <201611290804.uAT84UDN009666@...2054...>
References: <1480386424-30876-1-git-send-email-selva.nair@...277...>
	<201611290804.uAT84UDN009666@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 16:01:34 -0500
Message-ID: <CAKuzo_hwb0Ysf-fG-EbZbSdSHNCAfByp9soWcJOxgTCaOqBKxA@...278...>
Content-Type: multipart/alternative; boundary=001a114c8946f73fb6054276e56d
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Map restart signals from
 event loop to SIGTERM during exit-notification wait
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

--001a114c8946f73fb6054276e56d
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 29, 2016 at 3:04 AM, Gert Doering <gert@...1296...> wrote:

> .. which fixes the issue for good.
>
> "Real signals" are still ignored (kill -USR1 from another window):
>
> Tue Nov 29 08:58:19 2016 event_wait : Interrupted system call (code=4)
> Tue Nov 29 08:58:19 2016 Ignoring SIGUSR1 received during exit notification
>
> (or pressing ctrl-c a second time while it's waiting for the exit
> notification
> to proceed)
>

Just to be sure, I think the second ctrl-C or SIGTERM during exit-notify
wait should cause a prompt exit without waiting for exit-notify to
complete. That was the original behaviour and is supposed to be unchanged...

Selva

--001a114c8946f73fb6054276e56d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Nov 29, 2016 at 3:04 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_9032781866802843526=
:62e" class=3D"m_9032781866802843526a3s m_9032781866802843526aXjCH m_903278=
1866802843526m158af1d1e66a7dd0">.. which fixes the issue for good.<br>
<br>
&quot;Real signals&quot; are still ignored (kill -USR1 from another window)=
:<br>
<br>
Tue Nov 29 08:58:19 2016 event_wait : Interrupted system call (code=3D4)<br>
Tue Nov 29 08:58:19 2016 Ignoring SIGUSR1 received during exit notification=
<br>
<br>
(or pressing ctrl-c a second time while it&#39;s waiting for the exit notif=
ication<br>
to proceed)</div></blockquote></div><br>Just to be sure, I think the second=
 ctrl-C or SIGTERM during exit-notify wait should cause a prompt exit witho=
ut waiting for exit-notify to complete. That was the original behaviour and=
 is supposed to be unchanged...</div><div class=3D"gmail_extra"><br></div><=
div class=3D"gmail_extra">Selva</div></div>

--001a114c8946f73fb6054276e56d--

