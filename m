MIME-Version: 1.0
In-Reply-To: <42777399.uRlGseOKiX@...2001...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<42777399.uRlGseOKiX@...2001...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Feb 2016 14:31:03 -0500
Message-ID: <CAKuzo_h6+EbVeUUz3Ab2ygWb9OGVr0yM+xbXaUnoYMqdUzhvVw@...278...>
Content-Type: multipart/alternative; boundary=089e013a2a26f5d447052ace8bee
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e013a2a26f5d447052ace8bee
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 1, 2016 at 1:41 PM, Heiko Hund <heiko.hund@...1489...> wrote:

> On Monday 1 February 2016 11:34:47 Selva Nair wrote:
> > A more serious problem is related to the the service requiring
> connections
> > from UI with impersonation allowed. Again, an unprivileged process
> > pretending to be the service could escalate privileges if an OpenVPNGUI
> > instance running as admin connects to it. This looks easy to exploit.
> >
> > Possible mitigation:
> > (i) The GUI should not connect to the interactive service if running with
> > elevated privileges
> > (ii) openvpn.exe should not honor the --msg-channel option if running
> with
> > elevated privileges
>
> Yeah. The point is no to run the GUI as admin anymore in the first place.
> So
> we could just do (ii) and be sure that this is circumvented.


As discussed in the IRC meeting, the critical issue was whether the GUI
(running as admin) connecting to a rogue named pipe server could allow
privilege escalation by that server process. I did some tests on this.

On Windows XP this is exploitable --- i.e., with a pipe server running as a
limited user with the GUI started using runas admin. However, on Windows 7
and 10 attempts at elevation failed at least by the approach I imagined.
And based on what I hear, Vista and above appear to be immune from this
attack.

It may be better to make the GUI not connect to the service pipe if running
as admin.

Thanks,

Selva

--089e013a2a26f5d447052ace8bee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Feb 1, 2016 at 1:41 PM, Heiko Hund <span dir=3D"ltr">&lt;<a href=3D=
"mailto:heiko.hund@...1489..." target=3D"_blank">heiko.hund@...1489...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On Monday 1 Febru=
ary 2016 11:34:47 Selva Nair wrote:</span><span><br>
&gt; A more serious problem is related to the the service requiring connect=
ions<br>
&gt; from UI with impersonation allowed. Again, an unprivileged process<br>
&gt; pretending to be the service could escalate privileges if an OpenVPNGU=
I<br>
&gt; instance running as admin connects to it. This looks easy to exploit.<=
br>
&gt;<br>
&gt; Possible mitigation:<br>
&gt; (i) The GUI should not connect to the interactive service if running w=
ith<br>
&gt; elevated privileges<br>
&gt; (ii) openvpn.exe should not honor the --msg-channel option if running =
with<br>
&gt; elevated privileges<br>
<br>
</span>Yeah. The point is no to run the GUI as admin anymore in the first p=
lace. So<br>
we could just do (ii) and be sure that this is circumvented.=C2=A0</blockqu=
ote><div><br></div><div>As discussed in the IRC meeting, the critical issue=
 was whether the GUI (running as admin) connecting to a rogue named pipe se=
rver could allow privilege escalation by that server process. I did some te=
sts on this.=C2=A0</div><div><br></div><div>On Windows XP this is exploitab=
le --- i.e., with a pipe server running as a limited user with the GUI star=
ted using runas admin. However, on Windows 7 and 10 attempts at elevation f=
ailed at least by the approach I imagined. And based on what I hear, Vista =
and above appear to be immune from this attack.</div><div><br></div><div>It=
 may be better to make the GUI not connect to the service pipe if running a=
s admin.=C2=A0</div><div><br></div><div>Thanks,</div><div><br></div><div>Se=
lva</div></div></div></div>

--089e013a2a26f5d447052ace8bee--

