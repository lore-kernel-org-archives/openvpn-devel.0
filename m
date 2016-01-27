Resent-Message-ID: <20160205083627.GJ24952@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 Jan 2016 14:46:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160127134656.GZ24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
	<56A7D1F6.8030805@...515...>
	<20160126212431.GW24952@...1296...>
	<CAKuzo_jKX6+KAw3cfPR-VTGe1A_bMh=R93i+4p=eC4BbCqWtAg@...278...>
	<56A87C5A.3050104@...515...>
	<20160127082046.GY24952@...1296...>
	<CAPTYJtuHGBZ2UvQKsX3wKyxpACj0Xh-Xbn1u6qzE0XdP3Waqsw@...278...>
MIME-Version: 1.0
In-Reply-To: <CAPTYJtuHGBZ2UvQKsX3wKyxpACj0Xh-Xbn1u6qzE0XdP3Waqsw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Daniel Sim <daniel.ssq89@...277...>

Hi,

On Wed, Jan 27, 2016 at 05:34:57PM +0800, Daniel Sim wrote:
> Unless there are undiscovered vulnerabilities in the .NET framework itself,
> 
>    1. It is necessary to move away from pure C programs for Windows.
>    Microsoft's documentation for the services API apart from the .NET
>    framework is non-existent / hard to find. The lack of documentation will
>    make such programs increasingly hard to maintain. Fact is, GUIs written in
>    pure C/C++ are not really encouraged by Microsoft anymore, and even
>    openvpn-gui would benefit from moving to C#.

This is actually a fairly strong (I would even say "compelling") argument
for the C# rewrite.  "Working and reliably supported API" is a killer :-)

("Having to install .NET runtime" might not be such a big issue nowadays,
as most of the machines should have it already)

[..]
> The source code for openvpnserv.exe (C) isn't long, and neither is the
> source code for openvpnserv2 (C#). I think one could review it in less than
> an hour. However, to implement the same features in the old openvpnserv
> would have required quite a bit of low-level juggling.

In case we stay with openvpnserv2, I think some followup questions
need to be asked...

 - do we want to migrate "interactive service" functionality into 
   openvpnserv2 as well?  More code, but not overly complex stuff
   (if the network/route API in C# isn't totally different from C) - 
   and all the arguments from above apply to the interactive service
   as well, of course

 - should "the service(s)" live inside the main openvpn repo, in the
   GUI repo, in their own repo, ...?

 - what code change rules apply?  I tend to opt for "openvpn main repo"
   rules, that is, no change goes in without review & ACK - a bad or
   malicious commit to the service could compromise the system security 
   about as badly as a bad commit inside openvpn.  I am aware that this 
   is a totally annoying process, especially if the code author has to
   wait for months for an ACK to a trivial change - but hopefully a 
   somewhat larger active developer base can improve on this.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...


