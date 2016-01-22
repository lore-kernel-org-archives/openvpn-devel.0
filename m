MIME-Version: 1.0
In-Reply-To: <CAPTYJtutoE8LzyiROqu3Vzar6LVfUjbdNh-q+3tMB6Pa7FQJgw@...278...>
References: <CAPTYJtutoE8LzyiROqu3Vzar6LVfUjbdNh-q+3tMB6Pa7FQJgw@...278...>
Date: Fri, 22 Jan 2016 19:31:37 +0800
Message-ID: <CAPTYJttd0dwGui5kcgBmD-ROv+C=X7gpJ1UVFQcs7AoWvm7Czg@...278...>
From: Daniel Sim <daniel.ssq89@...277...>
Content-Type: multipart/alternative; boundary=001a113d30b6e9c9270529ea8f1d
Subject: [Openvpn-devel] Rewrite of OpenVPNServ.exe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a113d30b6e9c9270529ea8f1d
Content-Type: text/plain; charset=UTF-8

Hi,

I have rewritten openvpnserv.exe in C# to support auto-restart on
termination and to support suspend/resume.

I hope this fixes bug #595 and #71 but it needs testing.

The source code is hosted at https://github.com/xkjyeah/openvpnserv2

A binary is also available in the repository and you **might** be able to
drag-and-drop it into \openvpn\bin for it to just work.

The rationale for this project is to maintain compatibility with the
current version as much as possible (e.g. retaining .ovpn config files)
without resorting to NSSM, the configuration of which has eluded me.

I welcome your comments and suggestions for improvement.

Regards,

Daniel Sim

--001a113d30b6e9c9270529ea8f1d
Content-Type: text/html; charset=UTF-8

<p dir="ltr">Hi,</p>
<p dir="ltr">I have rewritten openvpnserv.exe in C# to support auto-restart on termination and to support suspend/resume.</p>
<p dir="ltr">I hope this fixes bug #595 and #71 but it needs testing.</p>
<p dir="ltr">The source code is hosted at <a href="https://github.com/xkjyeah/openvpnserv2">https://github.com/xkjyeah/openvpnserv2</a></p>
<p dir="ltr">A binary is also available in the repository and you **might** be able to drag-and-drop it into \openvpn\bin for it to just work.</p>
<p dir="ltr">The rationale for this project is to maintain compatibility with the current version as much as possible (e.g. retaining .ovpn config files) without resorting to NSSM, the configuration of which has eluded me.</p>
<p dir="ltr">I welcome your comments and suggestions for improvement.</p>
<p dir="ltr">Regards,</p>
<p dir="ltr">Daniel Sim</p>

--001a113d30b6e9c9270529ea8f1d--

