From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 7 Mar 2013 16:40:50 +0100
Message-ID: <3078233.lZhjXvd0QM@...1526...>
In-Reply-To: <5137B770.7060303@...1227...>
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
	<1361526263-1740-4-git-send-email-heiko.hund@...1489...>
	<5137B770.7060303@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/3] add new option for X.509 name
	verification
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

On Wednesday 06 March 2013 22:38:56 Arne Schwabe wrote:
> I looked through these and I think they are okay. Since most users don't
> know what RDN, RDN prefix and DN are an example like

I just sent a second version of 3/3 including examples in the man page, as you 
suggested.

> Most user and certificates will probably use the second form with
> subject. I also think that for standard x509 certificates it may be a
> good option to also include name-suffix so you can do:
> 
> verify-x509-name .blinkt.de name-suffix

While this could be added, I'd rather wait until someone demands it strongly, 
as I think the "name-prefix" flags is of use for a very limited audience 
already and included mostly for compatibility with the --tls-remote feature 
set.

Thanks for the review!

Heiko

