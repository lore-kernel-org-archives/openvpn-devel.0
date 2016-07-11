MIME-Version: 1.0
In-Reply-To: <1468248654-27073-1-git-send-email-arne@...1227...>
References: <1468248654-27073-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 11 Jul 2016 16:14:19 -0400
Message-ID: <CAKuzo_h+1YqaAYSXtUXiNvcewg74aBS+rTwHBU_QXhVFvZW0Vg@...278...>
Content-Type: multipart/alternative; boundary=001a114f6a244731ad053761cdfc
Subject: Re: [Openvpn-devel] [PATCH] Change the hold command to communicate
 the time that OpenVPN would wait to the UI.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114f6a244731ad053761cdfc
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Jul 11, 2016 at 10:50 AM, Arne Schwabe <arne@...1227...> wrote:

> Before the connect-retry change to do exponential backup this was not
> necessary
> since the time was fixed. With the exponential backoff the UI needs either
> to
> implement its own exponential backoff mechansim or needs a way of knowing
> the
> value of OpenVPN internal mechansim.
>

This is required only if the GUI keeps "hold on" between SIGUSR1 restarts
--- windows GUI does "hold off" before
hold release so hold will happen only the first time after a SIGHUP.


> ---
>  doc/management-notes.txt |  7 +++++--
>  src/openvpn/init.c       | 17 ++++++++++-------
>  src/openvpn/manage.c     |  8 ++++++--
>  src/openvpn/manage.h     |  2 +-
>  4 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index f68f3db..eb857ab 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -168,9 +168,12 @@ be reset by restarts.
>
>  OpenVPN will indicate that it is in a hold state by
>  sending a real-time notification to the management
> -client:
> +client, the parameter indicates how long OpenVPN would
> +wait without UI (as influenced connect-retry exponential
> +backoff. The UI need to wait for releasing the hold if it
> +wants similar behavior:
>

FWIW, some typos:

influenced -> influenced by
need --> needs
and a missing closing parenthesis?


>
> -  >HOLD:Waiting for hold release
> +  >HOLD:Waiting for hold release:10
>

Windows GUI is fine with this, but potentially a UI may break with this
change depending on how it parses the line. Just a warning to UI
maintainers..

Rest of the code looks good.

Selva

--001a114f6a244731ad053761cdfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Jul 11, 2016 at 10:50 AM, Arne =
Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1227..." target=3D"=
_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div>Before the connect-retry change to do exponential backup this was=
 not necessary<br>
since the time was fixed. With the exponential backoff the UI needs either =
to<br>
implement its own exponential backoff mechansim or needs a way of knowing t=
he<br>
value of OpenVPN internal mechansim.<br></div></blockquote><div><br></div><=
div>This is required only if the GUI keeps &quot;hold on&quot; between SIGU=
SR1 restarts --- windows GUI does &quot;hold off&quot; before</div><div>hol=
d release so hold will happen only the first time after a SIGHUP.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div>
---<br>
=C2=A0doc/management-notes.txt |=C2=A0 7 +++++--<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 ++++++++++-------<b=
r>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++++--<br>
=C2=A0src/openvpn/manage.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A04 files changed, 22 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/doc/management-notes.txt b/doc/management-notes.txt<br>
index f68f3db..eb857ab 100644<br>
--- a/doc/management-notes.txt<br>
+++ b/doc/management-notes.txt<br>
@@ -168,9 +168,12 @@ be reset by restarts.<br>
<br>
=C2=A0OpenVPN will indicate that it is in a hold state by<br>
=C2=A0sending a real-time notification to the management<br>
-client:<br>
+client, the parameter indicates how long OpenVPN would<br>
+wait without UI (as influenced connect-retry exponential<br>
+backoff. The UI need to wait for releasing the hold if it<br>
+wants similar behavior:<br></div></blockquote><div><br></div><div>FWIW, so=
me typos:</div><div><br></div><div>influenced -&gt; influenced by</div><div=
>need --&gt; needs</div><div>and a missing closing parenthesis?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div>
<br>
-=C2=A0 &gt;HOLD:Waiting for hold release<br>
+=C2=A0 &gt;HOLD:Waiting for hold release:10</div></blockquote></div><br>Wi=
ndows GUI is fine with this, but potentially a UI may break with this chang=
e depending on how it parses the line. Just a warning to UI maintainers..</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Rest of=
 the code looks good.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Selva</div></div>

--001a114f6a244731ad053761cdfc--

