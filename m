From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 31 Jul 2012 13:31:50 +0200
Message-ID: <1738242.yJcaVCkhX0@...1526...>
In-Reply-To: <5016BEFA.8030901@...1114...>
References: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
	<5016BEFA.8030901@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC] give plugins a method to pass log lines
	to openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Hi David.

Thanks for the feedback.

On Monday 30 July 2012 19:06:02 David Sommerseth wrote:
> My immediate thought/question is: Why can we not export msg() to
> plug-ins?  Or at least provide something more like a functional
> oriented API to work with?

Actually that's my favored way as well. I just thought I'd stick to the, 
admittedly rather strange, way plugins interact with openvpn for the start. 
I'll hack a patch that provides a plugin_log() function, with the same 
semantics as the struct based approach.
 
> But it should also prefix
> these log lines as coming from a plug-in (preferably with the plug-in
> name included)... 

I don't think enforcing something like this makes much sense, as evil plugins, 
trying to forge log lines to appear originating from the core process, will 
just call x_msg() directly then.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


