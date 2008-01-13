Message-ID: <9e0cf0bf0801130951h22c0ce35sb8c09b48297463f1@...278...>
Date: Sun, 13 Jan 2008 19:51:03 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <478A4D83.6060709@...1068...>
MIME-Version: 1.0
References: <478A4D83.6060709@...1068...>
Subject: Re: [Openvpn-devel] NTLMv2 patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mirek Zajic <zajic@...1068...>
Cc: openvpn-devel@lists.sourceforge.net

On 1/13/08, Mirek Zajic <zajic@...1068...> wrote:
> I'm sending the patch for NTLMv2 proxy authorization support. Please
> note that I diffed against version 2.0.9 because it was the version that
> I modified. Hope that it's not too confusing.

It is.
Please rebase to latest svn.

svn checkout http://svn.openvpn.net/projects/openvpn/branches/BETA21
apply your patch
svn diff

Or if you don't which to mess with svn do:
svn export http://svn.openvpn.net/projects/openvpn/branches/BETA21

Alon.

