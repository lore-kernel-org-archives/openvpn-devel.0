MIME-Version: 1.0
In-Reply-To: <e9d751180903030629g6512e307ne8bedf82049bd0ae@...278...>
References: <e9d751180903030629g6512e307ne8bedf82049bd0ae@...278...>
Date: Tue, 3 Mar 2009 11:40:58 -0300
Message-ID: <e9d751180903030640j707f1e57j56fd0e9e2c519165@...278...>
From: =?ISO-8859-1?Q?Jo=E3o_Paulo_Campello?= <jotape@...277...>
Content-Type: multipart/alternative; boundary=00163646d6a66062ee046437ec17
Subject: [Openvpn-devel] pam auth is failing for future connections after a
	timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--00163646d6a66062ee046437ec17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I was searching for some posts regarding problems using "PAM authentication
module" and I've found this thread:

* [Openvpn-users] pam auth is failing for future connections after a timeout

As I have found no answer in "openvpn-users" mailing lists, I'm
cross-posting to openvpn-users and openvpn-devel. Sorry for any
inconvenience.

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

--00163646d6a66062ee046437ec17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<div class="gmail_quote">Hi,<br><br>I was searching for some posts regarding problems using &quot;PAM authentication module&quot; and I&#39;ve found this thread:<br><br>* [Openvpn-users] pam auth is failing for future connections after a timeout<br>
<br>As I have found no answer in &quot;openvpn-users&quot; mailing lists, I&#39;m cross-posting to openvpn-users and openvpn-devel. Sorry for any inconvenience.<br>
<br>The post is dated from 2005 and had only 2 replies, one of them which is from James Yonan asking for more details on the error log.<br><br>The original post and error log details (sent by the thread creator) are quoted below:<br>

<br>* ORIGINAL POST:<br><br>
 &gt; Hello, <br>
 &gt; Newbie here.  I&#39;m using the latest 2.0 version downloaded on June 12th. <br>
 &gt; Everything works great except when a connection times out.  The next connection<br>
 &gt; attempt (a few hours to a day later or so) does not allow the user to login. <br>
 &gt; The client side status appears to sit there and wait.  The server side log file<br>
 &gt; shows a PAM fatal error and a return status of 0.  I just restart the openvpn<br>
 &gt; server (application) and everything works great again. It&#39;s intermittent.  I can<br>
 &gt; disconnect and reconnect several times without a problem.  It only appears to be<br>
 &gt; a  problem when a session times out after a few hours.  Many thanks for any<br>
 &gt; help, DAVID.<br><br>* ERROR LOG details:<br><br>&gt; AUTH-PAM: BACKGROUND: user &#39;dgrimm01&#39; failed to authenticate: <br>&gt; 
 Critical error - immediate abort<br>&gt; 
 Sun Jun 19 16:47:59 2005 <a href="http://166.82.5.53:32777" target="_blank">166.82.5.53:32777</a> PLUGIN_CALL: POST<br>&gt; 
 /lib/security/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY <br>&gt; 
 status=1<br>&gt; 
 Sun Jun 19 16:47:59 2005 <a href="http://166.82.5.53:32777" target="_blank">166.82.5.53:32777</a> PLUGIN_CALL: plugin function<br>&gt; 
 PLUGIN_AUTH_USER_PASS_VERIFY failed with status <br>&gt; 
 1: /lib/security/openvpn-auth-pam.so<br>&gt; 
 Sun Jun 19 16:47:59 2005 <a href="http://166.82.5.53:32777" target="_blank">166.82.5.53:32777</a> TLS Auth Error: Auth<br>&gt; 
 Username/Password verification failed for peer
<br><br><br>I have exactly the same problem.<br><br>Did anybody have solved this issue? May you please tell me how to accomplish that?<br><br>Any help is very much appreciated.<br><br>Thanks in advance,<br><br>Joao Paulo.<br>
<br><small>
</small></div>

--00163646d6a66062ee046437ec17--

