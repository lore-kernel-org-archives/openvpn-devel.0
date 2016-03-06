MIME-Version: 1.0
In-Reply-To: <201603060931.u269VG0n045886@...2054...>
References: <1457241722-23433-1-git-send-email-selva.nair@...277...>
	<201603060931.u269VG0n045886@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Mar 2016 08:34:38 -0500
Message-ID: <CAKuzo_h+RsgPKVJDCYf+5V5RBacdfHwYDxm9eTpoWbD4JmzJVw@...278...>
Content-Type: multipart/alternative; boundary=001a113d526c07b7f9052d616a92
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Use appropriate buffer size
 for WideCharToMultiByte output in interactive.c
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

--001a113d526c07b7f9052d616a92
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Mar 6, 2016 at 4:31 AM, Gert Doering <gert@...1296...> wrote:

>
> I'm not sure if I understand in which scenarios data is fed to the
> nascent openvpn.exe on stdin - buf if done at all, we should better do
> it right :-) - I do wonder, though, if WriteFile() could block here,
> leading to a dead worker thread...  all other pipe operations seem to
> go through AsyncPipeOp() - but that is orthogonal to this fix)


This is used for writing the management password to stdin. The GUI sends an
"ascii" password, but a client could potentially use some char set that
needs 3 or 4 bytes per char.

And you are right, the write should not block. We don't see any deadlock
even when openvpn errros out early, because of buffering, I suppose.. But
bettter to make this non-blocking.

Selva

--001a113d526c07b7f9052d616a92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Mar 6, 2016 at 4:31 AM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br>
I&#39;m not sure if I understand in which scenarios data is fed to the<br>
nascent openvpn.exe on stdin - buf if done at all, we should better do<br>
it right :-) - I do wonder, though, if WriteFile() could block here,<br>
leading to a dead worker thread...=C2=A0 all other pipe operations seem to<=
br>
go through AsyncPipeOp() - but that is orthogonal to this fix)</blockquote>=
</div><br></div><div class=3D"gmail_extra">This is used for writing the man=
agement password to stdin. The GUI sends an &quot;ascii&quot; password, but=
 a client could potentially use some char set that needs 3 or 4 bytes per c=
har.<br><br></div><div class=3D"gmail_extra">And you are right, the write s=
hould not block. We don&#39;t see any deadlock even when openvpn errros out=
 early, because of buffering, I suppose.. But bettter to make this non-bloc=
king.<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a113d526c07b7f9052d616a92--

