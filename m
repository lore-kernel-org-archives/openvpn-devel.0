MIME-Version: 1.0
In-Reply-To: <1448835033-24287-1-git-send-email-iam@...2070...>
References: <565A3985.3030800@...1227...>
	<1448835033-24287-1-git-send-email-iam@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 30 Nov 2015 01:10:16 -0500
Message-ID: <CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
Content-Type: multipart/alternative; boundary=001a11453cf44fc99f0525bbe607
Subject: Re: [Openvpn-devel] [PATCH v7-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11453cf44fc99f0525bbe607
Content-Type: text/plain; charset=UTF-8

Hi,

On Sun, Nov 29, 2015 at 5:10 PM, ValdikSS <iam@...2070...> wrote:

> This option blocks all out-of-tunnel communication on TCP/UDP port 53
> (except
> for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.


v7 looks good and behaves as promised..

Tested v7-master and v7-2.3 (the latter built with and without wfp) on
windows 7 and windows 10 (64 bit only). For windows 7, also see the note
below.

Selva

Note: On windows7 I would suggest to use this option with either a script
that does "ipconfig /registerdns" or with the config option --register-dns
(the latter is slow as it restarts the dnsclient service etc., but may be
pushed). Without registerdns, at least on my win7 machine, any public dns
servers on other interfaces get queries through the tunnel for a long while
after the connection is up. As if those dns servers have been specified on
the tunnel interface! It doesn't appear to have anything to do with this
patch.

--001a11453cf44fc99f0525bbe607
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sun, Nov 29, 2015 at 5:10 PM, Va=
ldikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_b=
lank">iam@...2070...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span>This option blocks all out-of-tunnel communication on TCP/UDP port =
53 (except<br>
for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.</span></bl=
ockquote></div><br></div><div class=3D"gmail_extra">v7 looks good and behav=
es as promised.. <br></div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Tested v7-master and v7-2.3 (the latter built with and wit=
hout wfp) on windows 7 and windows 10 (64 bit only). For windows 7, also se=
e the note below.<br></div><div class=3D"gmail_extra"><br>Selva<br><br></di=
v><div class=3D"gmail_extra">Note: On windows7 I would suggest to use this =
option with either a script that does &quot;ipconfig /registerdns&quot; or =
with the config option --register-dns (the latter is slow as it restarts th=
e dnsclient service etc., but may be pushed). Without registerdns, at least=
 on my win7 machine, any public dns servers on other interfaces get queries=
 through the tunnel for a long while after the connection is up. As if thos=
e dns servers have been specified on the tunnel interface! It doesn&#39;t a=
ppear to have anything to do with this patch.<br></div></div>

--001a11453cf44fc99f0525bbe607--

