MIME-Version: 1.0
In-Reply-To: <5006C3D5.8000508@...1114...>
References: <1340730302-3077-1-git-send-email-alon.barlev@...277...>
	<CAEsd45QsjHX19m8kFsTEixyk1O9VB7gn25rj7aarSe9vuvahXw@...278...>
	<5006C3D5.8000508@...1114...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 18 Jul 2012 11:09:54 -0400
Message-ID: <CAEsd45RKiq+pcieNQen2gO8eSf1rbVv-60Hn+aZE=1ZLQBzu7A@...278...>
Content-Type: multipart/alternative; boundary=bcaec51b17c9aa74e104c51c108b
Subject: Re: [Openvpn-devel] [PATCH] plugin: load plugin relative to
	plugindir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--bcaec51b17c9aa74e104c51c108b
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 18, 2012 at 10:10 AM, David Sommerseth <
openvpn.list@...1114...> wrote:

> * The computer is configured to allow OpenVPN to run without root
>   password
>

Yes. The vulnerability requires configuring the computer to allow *the
user*to start OpenVPN
*as root* without entering the root password.

However, since configuration file paths and script paths can also be
arbitrary paths, they can be used to escalate privileges in this computer
configuration, too. (The configuration file could contain an "up" to an
attack script, or an attack script could be used as the argument to --up.)

So "closing" this plugin vulnerability isn't much help because there are
other similar attack vectors.

If at some time OpenVPN is modified to disallow absolute paths to scripts
and/or the configuration file, that would be a major problem for
Tunnelblick for the reasons outlined earlier. It's one thing to not be able
to use down-root, especially if it becomes unnecessary, but OpenVPN can't
be used at all without scripts and configuration files!

Instead of disallowing absolute paths, how about verifying at execution
time that the plugin (or configuration file, or script) cannot be modified
except by a privileged user? That is, instead of restricting the location
of script/plugin/configuration files to an arbitrary protected place or
places, instead making sure that the files themselves are protected.

(Note: Tunnelblick doesn't contain the vulnerability because it doesn't
allow the user to start OpenVPN as root. Instead, a suid "helper" program
is used to launch OpenVPN as root. That helper program controls the options
(including the path to the configuration file and scripts) that OpenVPN is
started with, and the configuration file and scripts cannot be modified by
an unprivileged user.)

--bcaec51b17c9aa74e104c51c108b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jul 18, 2012 at 10:10 AM, David Sommerse=
th <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn.list@...1114..." target=
=3D"_blank">openvpn.list@...1114...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">

* The computer is configured to allow OpenVPN to run without root<br>
=C2=A0 password<br></blockquote><div><br></div><div>Yes. The vulnerability =
requires configuring the computer to allow=C2=A0<b><i>the user</i></b> to s=
tart OpenVPN=C2=A0<i><b>as root</b></i> without entering the root password.=
</div><div>

<br></div><div>However, since configuration file paths and script paths can=
 also be arbitrary paths, they can be used to escalate privileges in this c=
omputer configuration, too. (The configuration file could contain an &quot;=
up&quot; to an attack script, or an attack script could be used as the argu=
ment to --up.)</div>

<div><br></div><div>So &quot;closing&quot; this plugin vulnerability isn&#3=
9;t much help because there are other similar attack vectors.</div><div><br=
></div><div>If at some time OpenVPN is modified to disallow absolute paths =
to scripts and/or the configuration file, that would be a major problem for=
 Tunnelblick for the reasons outlined earlier. It&#39;s one thing to not be=
 able to use down-root, especially if it becomes unnecessary, but OpenVPN c=
an&#39;t be used at all without scripts and configuration files!</div>

<div><br></div><div>Instead of disallowing absolute paths, how about verify=
ing at execution time that the plugin (or configuration file, or script) ca=
nnot be modified except by a privileged user? That is, instead of restricti=
ng the location of script/plugin/configuration files to an arbitrary protec=
ted place or places, instead making sure that the files themselves are prot=
ected.</div>

<div><br><div>(Note: Tunnelblick doesn&#39;t contain the vulnerability beca=
use it doesn&#39;t allow the user to start OpenVPN as root.=C2=A0Instead, a=
 suid &quot;helper&quot; program is used to launch OpenVPN as root. That he=
lper program controls the options (including the path to the configuration =
file and scripts) that OpenVPN is started with, and the configuration file =
and scripts cannot be modified by an unprivileged user.)</div>

</div><div><br></div></div>

--bcaec51b17c9aa74e104c51c108b--

