MIME-Version: 1.0
In-Reply-To: <1484080473-10415-1-git-send-email-davids@...515...>
References: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
	<1484080473-10415-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Jan 2017 22:21:35 -0500
Message-ID: <CAKuzo_hxZQ1fp9QezqodzBPRDw5ZU7Nmee05p+3xPUcGqteCPg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c07481c4a35450545c91ab9
Subject: Re: [Openvpn-devel] [PATCH 1/2] management: >REMOTE operation would
 overwrite ce change indicator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c07481c4a35450545c91ab9
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 10, 2017 at 3:34 PM, David Sommerseth <davids@...515...>
wrote:

> If the management interface on a client received a signal while waiting
> for input on the management channel, the "connection entry changed" status
> would be overwritten even though nothing was changed.  Which could lead
> into
> connecting to the wrong server.
>

Actually your earlier comment is right: that is,  IS_SIG(c) repeated in
next_connection_entry() makes what is returned from here irrelevant once a
signal has triggered. But I still think this is the "correct" approach.

ACK from me.

Selva

--94eb2c07481c4a35450545c91ab9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span class=3D"gmail-im">On Tue, Jan 10, 2017 at 3:34=
 PM, David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...2146...=
..." target=3D"_blank">davids@...515...</a>&gt;</span> wrote:<br></span><sp=
an class=3D"gmail-im"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If =
the management interface on a client received a signal while waiting<br>
for input on the management channel, the &quot;connection entry changed&quo=
t; status<br>
would be overwritten even though nothing was changed.=C2=A0 Which could lea=
d into<br>
connecting to the wrong server.<br></blockquote><div>=C2=A0</div></span><di=
v>Actually
 your earlier comment is right: that is,=C2=A0 IS_SIG(c) repeated in=C2=A0=
=20
next_connection_entry() makes what is returned from here irrelevant once
 a signal has triggered. But I still think this is the &quot;correct&quot; =
approach.<br><br></div>ACK from me.<br><br></div>Selva<br><br></div>

--94eb2c07481c4a35450545c91ab9--

