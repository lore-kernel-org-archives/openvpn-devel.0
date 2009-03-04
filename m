MIME-Version: 1.0
Date: Wed, 4 Mar 2009 14:11:43 -0300
Message-ID: <e9d751180903040911i70dac731qa32072ee6886ade7@...278...>
From: =?ISO-8859-1?Q?Jo=E3o_Paulo_Campello?= <jotape@...277...>
Content-Type: multipart/alternative; boundary=00163646d54262a85004644e258f
Subject: [Openvpn-devel] PAM (local OS) authentication is failing for future
	connections after a timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00163646d54262a85004644e258f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I"m re-sending this message since I haven't seen it show up on the list. My
apologies for any duplicates.

----
Hi,

I was searching for some posts regarding problems using "PAM authentication
module" and I've found this thread:

* [Openvpn-users] pam auth is failing for future connections after a timeout

The post is dated from 2005 and had only 2 replies, one of them which is
from James Yonan asking for more details on the error log.

The original post and error log details (sent by the thread creator) are
quoted below:

* ORIGINAL POST:

> Hello,
> Newbie here. I'm using the latest 2.0 version downloaded on June 12th.
> Everything works great except when a connection times out. The next
connection
> attempt (a few hours to a day later or so) does not allow the user to
login.
> The client side status appears to sit there and wait. The server side log
file
> shows a PAM fatal error and a return status of 0. I just restart the
openvpn
> server (application) and everything works great again. It's intermittent.
I can
> disconnect and reconnect several times without a problem. It only appears
to be
> a problem when a session times out after a few hours. Many thanks for any
> help, DAVID.

* ERROR LOG details:

> AUTH-PAM: BACKGROUND: user 'dgrimm01' failed to authenticate:
> Critical error - immediate abort
> Sun Jun 19 16:47:59 2005 166.82.5.53:32777 PLUGIN_CALL: POST
> /lib/security/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY
> status=1
> Sun Jun 19 16:47:59 2005 166.82.5.53:32777 PLUGIN_CALL: plugin function
> PLUGIN_AUTH_USER_PASS_VERIFY failed with status
> 1: /lib/security/openvpn-auth-pam.so
> Sun Jun 19 16:47:59 2005 166.82.5.53:32777 TLS Auth Error: Auth
> Username/Password verification failed for peer


I have exactly the same problem.

Did anybody have solved this issue? May you please tell me how to accomplish
that?

Any help is very much appreciated.

Thanks in advance,

Joao Paulo.

--00163646d54262a85004644e258f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div class=3D"im">I&quot;m re-sending this message since I haven&#39;t seen=
 it show up on the list. My apologies for any duplicates.<br><br>----<br>Hi=
,<br><br>I was searching for some posts regarding problems using &quot;PAM =
authentication module&quot; and I&#39;ve found this thread:<br>
<br>* [Openvpn-users] pam auth is failing for future connections after a ti=
meout<br></div>
<br>The post is dated from 2005 and had only 2 replies, one of them
which is from James Yonan asking for more details on the error log.<br><br>=
The original post and error log details (sent by the thread creator) are qu=
oted below:<br>

<br>* ORIGINAL POST:<br><br>
 &gt; Hello, <br>
 &gt; Newbie here.  I&#39;m using the latest 2.0 version downloaded on June=
 12th. <br>
 &gt; Everything works great except when a connection times out.  The next =
connection<br>
 &gt; attempt (a few hours to a day later or so) does not allow the user to=
 login. <br>
 &gt; The client side status appears to sit there and wait.  The server sid=
e log file<br>
 &gt; shows a PAM fatal error and a return status of 0.  I just restart the=
 openvpn<br>
 &gt; server (application) and everything works great again. It&#39;s inter=
mittent.  I can<br>
 &gt; disconnect and reconnect several times without a problem.  It only ap=
pears to be<br>
 &gt; a  problem when a session times out after a few hours.  Many thanks f=
or any<br>
 &gt; help, DAVID.<br><br>* ERROR LOG details:<br><br>&gt; AUTH-PAM: BACKGR=
OUND: user &#39;dgrimm01&#39; failed to authenticate: <br>&gt;=20
 Critical error - immediate abort<br>&gt;=20
 Sun Jun 19 16:47:59 2005 <a href=3D"http://166.82.5.53:32777/" target=3D"_=
blank">166.82.5.53:32777</a> PLUGIN_CALL: POST<br>&gt;=20
 /lib/security/openvpn-auth-<div class=3D"im">pam.so/PLUGIN_AUTH_USER_PASS_=
VERIFY <br>&gt;=20
 status=3D1<br>&gt;=20
 Sun Jun 19 16:47:59 2005 <a href=3D"http://166.82.5.53:32777/" target=3D"_=
blank">166.82.5.53:32777</a> PLUGIN_CALL: plugin function<br>&gt;=20
 PLUGIN_AUTH_USER_PASS_VERIFY failed with status <br>&gt;=20
 1: /lib/security/openvpn-auth-pam.so<br>&gt;=20
 Sun Jun 19 16:47:59 2005 <a href=3D"http://166.82.5.53:32777/" target=3D"_=
blank">166.82.5.53:32777</a> TLS Auth Error: Auth<br>&gt;=20
 Username/Password verification failed for peer
<br><br><br>I have exactly the same problem.<br><br>Did anybody have solved=
 this issue? May you please tell me how to accomplish that?<br><br>Any help=
 is very much appreciated.<br><br>Thanks in advance,<br><br>Joao Paulo.</di=
v>

--00163646d54262a85004644e258f--

