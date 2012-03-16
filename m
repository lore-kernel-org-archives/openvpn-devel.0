MIME-Version: 1.0
In-Reply-To: <CAP+U6tJySV=3tDipKtym7sS+M0jy1ZBFjc6sEVRs_2wQ=vYrrA@...278...>
References: <4F632647.30603@...515...>
	<CAOazyz1+mcBLnt7Uqd5_h75VmcLvWjXz1==u_-FW6wNOzcW+mQ@...278...>
	<CAP+U6tJySV=3tDipKtym7sS+M0jy1ZBFjc6sEVRs_2wQ=vYrrA@...278...>
Date: Fri, 16 Mar 2012 15:49:02 +0200
Message-ID: <CAOazyz11zNQO+5whPA=-LD-mXqfcNCEvqy2iF-vY-NChivB2kg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Mar 16, 2012 at 3:29 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> In my opinion, the build defaults should reflect what the project
> considers as the recommended defaults - the features we want to see in
> every typical OpenVPN server and client.

I strongly against that approach.
This is a common mix up between distribution and software project.

A software project provides the possibility of using the software in
different configurations.
A distribution is in charge of the "typical" configuration.

Your comment is true for rhel packager, people expect that yum install
openvpn will be a "typical" rhel configuration, what exactly this
configuration is depends on distribution procedures.

Why is lzo different than PKCS#11 or selinux? Which are "typical"?
Mind "typical" is probably different between server and client.

The software project should not make any assumption of its usage, nor
enable/disable features for the sake of best practices instead of
proper documentation.

Alon.

