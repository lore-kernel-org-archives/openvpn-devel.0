References: <35b26cf2-5b2e-be38-6cd5-99356bece635@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <64366f4d-97f9-b4fe-9073-b5ae47ef3d29@...1856...>
Date: Thu, 3 Nov 2016 22:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <35b26cf2-5b2e-be38-6cd5-99356bece635@...2080...>
Subject: Re: [Openvpn-devel] Considering to send AUTH_FAILED on TLS errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi David,

On 03-11-16 22:03, David Sommerseth wrote:
> During the review of the CRL improvement patch, I briefly mentioned
> that clients do not disconnect gracefully if the TLS layer does not
> accept the client certificate (like when it is on a CRL).
> 
> I have spent some time looking through the code to see what is needed.
>  And what is a fairly simple thing seems to get fairly complicated.
> So I'm just starting this discussion to see if we can find some good
> approaches.
> 
> The main challenge is that we should use the send_auth_failed()
> function, which takes a struct context object as well as a reason.
>
> [..snip..]
> 
> The question is ... does anyone else see a different or better
> approach?  Thoughts, comments?

Well, you can't send AUTH_FAILED over the control channel, because there
is no control channel, because one of the certs was revoked and the TLS
handshake failed.

You do have a valid point that it would be nice to handle revocations
more gracefully though.  TLS sends a "certificate_revoked" alert if this
is the case (see https://tools.ietf.org/html/rfc5246#page-31).  It might
however be that we close the connection before the TLS lib can send this
alert.  I'd need to investigate that.

-Steffan

