MIME-Version: 1.0
In-Reply-To: <20160204093823.GX24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
	<20160204093823.GX24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 4 Feb 2016 10:40:35 -0500
Message-ID: <CAKuzo_isz+mde2P6=D=mMPQNEmcRQKmU-XNySVJxBK2eNzU-CA@...278...>
Content-Type: multipart/alternative; boundary=089e011762d1707e59052af38fce
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
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

--089e011762d1707e59052af38fce
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Feb 4, 2016 at 4:38 AM, Gert Doering <gert@...1296...> wrote:

> > Anyway, the iservice works well and the only real problem I ran into was
> > lack of write access to the default log_dir. That leads to a log-jam as
> the
> > stdout is now a pipe which the service is not actively reading from.
> Could
> > be handled in the GUI + registry by making sure openvpn is started with a
> > writable log file..
>
> Yes, I've seen this as well.  As far as I understand, there's a registry
> key that can be changed to include the user's home in the log path - it's
> on a piece of paper on my desk, while I'm at work, so can't look right
> now... Heiko?
>

> (And yes, this needs to be adjusted in the installer, whichever way we
> go - globally writeable log directory, or user-individual logging)


Its the "HKLM\OpenVPN\log_dir" key set by the installer when the service is
installed. For the automatic service, users may want it to stay at such a
system-wide location, while the interactive service does not use it
directly. But the UI (OpenVPNGUI) uses it to construct the log file path
and passes it in the command line options.

To make the log location user-dependent, we could include env variables in
the registry key -- say  %UserProfile%/OpenVPN/log  But that requires the
service to read the key as REG_EXPAND_SZ and then expand it.

For now, I'll make a patch for the GUI to construct a writable log path
when iservice is used. It looks ok to let the UI to decide where to write
logs to. We could document that starting openvpn using iservice needs the
--log or --log-append option with a writable log file. If its not writable
openvpn will fallback to stdout which will not work.

> Anyway, the service part of the code looks good and does well what it
> > promises to do.
>
> Thanks.  I take this as an ACK from your for the service change, and
> Arne's mail as an ACK for the openvpn side, and merge it tonight.
>
> Then we can go about improving things further (... while we wait for
> the other large 2.4 feature to fully show up, AEAD...)


Sounds good!

Selva

--089e011762d1707e59052af38fce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Feb 4, 2016 at 4:38 AM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span>&gt; =
Anyway, the iservice works well and the only real problem I ran into was<br>
&gt; lack of write access to the default log_dir. That leads to a log-jam a=
s the<br>
&gt; stdout is now a pipe which the service is not actively reading from. C=
ould<br>
&gt; be handled in the GUI + registry by making sure openvpn is started wit=
h a<br>
&gt; writable log file..<br>
<br>
</span>Yes, I&#39;ve seen this as well.=C2=A0 As far as I understand, there=
&#39;s a registry<br>
key that can be changed to include the user&#39;s home in the log path - it=
&#39;s<br>
on a piece of paper on my desk, while I&#39;m at work, so can&#39;t look ri=
ght<br>
now... Heiko?<br></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex"><br>(And yes, this needs to =
be adjusted in the installer, whichever way we<br>go - globally writeable l=
og directory, or user-individual logging)</blockquote><div>=C2=A0</div><div=
>Its the &quot;HKLM\OpenVPN\log_dir&quot; key set by the installer when the=
 service is installed. For the automatic service, users may want it to stay=
 at such a system-wide location, while the interactive service does not use=
 it directly. But the UI (OpenVPNGUI) uses it to construct the log file pat=
h and passes it in the command line options.=C2=A0</div><div><br></div><div=
>To make the log location user-dependent, we could include env variables in=
 the registry key -- say =C2=A0%UserProfile%/OpenVPN/log =C2=A0But that req=
uires the service to read the key as REG_EXPAND_SZ and then expand it.=C2=
=A0</div><div><br></div><div>For now, I&#39;ll make a patch for the GUI to =
construct a writable log path when iservice is used. It looks ok to let the=
 UI to decide where to write logs to. We could document that starting openv=
pn using iservice needs the=C2=A0</div><div>--log or --log-append option wi=
th a writable log file. If its not writable openvpn will fallback to stdout=
 which will not work.</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span>
&gt; Anyway, the service part of the code looks good and does well what it<=
br>
&gt; promises to do.<br>
<br>
</span>Thanks.=C2=A0 I take this as an ACK from your for the service change=
, and<br>
Arne&#39;s mail as an ACK for the openvpn side, and merge it tonight.<br>
<br>
Then we can go about improving things further (... while we wait for<br>
the other large 2.4 <span><span>feature</span></span> to fully show up, AEA=
D...)</blockquote></div><div class=3D"gmail_extra"><br></div>Sounds good!</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<b=
r></div></div>

--089e011762d1707e59052af38fce--

