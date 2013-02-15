From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 15 Feb 2013 18:39:11 +0100
Message-ID: <2485195.ksrFaVsMX6@...1526...>
In-Reply-To: <511CC1F1.6010409@...1114...>
References: <511CC1F1.6010409@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RFC - Usefulness of the --tls-remote semantic
	warning
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On Thursday 14 February 2013 11:52:33 David Sommerseth wrote:
> This is just a minor issue which has been annoying me a little bit.
> I've attached a patch which ensures that the --tls-remote semantic
> warning is only printed once.
> 
> However, I wonder how useful that warning really is these days.  Do
> we really need that warning?  The warning comes from this commit [1]:

I just removed this warning while working on the --tls-remote compat / 
depreciation patchset. So, don't bother sending a patch of your own. I'll post 
the patchset next week after some testing.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


