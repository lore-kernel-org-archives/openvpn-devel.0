From: Bernhard Schmidt <berni@...376...>
Date: Fri, 30 Jun 2017 08:30:05 +0000 (UTC)
Message-ID: <oj526d$ai7$1@...2213...>
References: <60ed4f7c-3fad-3569-87f6-c40a653bee33@...515...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] New maintainer(s) wanted for Debian's OpenVPN
 packages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen <samuli@...515...> wrote:

Hi everyone,

> Alberto Gonzales Iniesta ("agi") is, after 15 years of excellent work,
> letting others take over maintainance of Debian's OpenVPN packages[1]:
>
><https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=865555>
>
> If you're interested in maintaining (or co-maintaining) OpenVPN packages
> on Debian, please comment in the above bug report.

Jörg Frings-Fürst and me have taken over maintainership of OpenVPN in
Debian. Thanks to Alberto for the maintainership in the last decade.

We will slowly wade through the open bugs. There are a couple of things
in the pipeline already (updated debian specific systemd units, build
against OpenSSL 1.1.0, ...), and we will try to keep up with new
upstream releases when they happen.

I'd like to remind here that Debian has a strict policy for updating
packages in stable. We will not ever update the upstream release within
stable, so Debian 9 (stretch) will stay on OpenVPN 2.4.0.

Security bugs will be fixed through applying individual patches from the
2.4-branch on top of 2.4.0.

We can fix major annoyances or usability issues in Debian stable point
releases (approx. every 2-4 months), if they can be fixed by backporting
commits from the git repo on top of 2.4.0. If you have something like
this feel free to drop us a note (or even better, file a bug in the
Debian BTS).

We'll have a look at Samuli's source package within the next weeks and
try to reduce the diff between Debian and his packages as much as
possible.

Best Regards,
Bernhard


