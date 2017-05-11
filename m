Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <d42aeed3-5d5f-9bbb-763a-918fc087be9a@...2162...>
Date: Thu, 11 May 2017 11:24:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170511092409.GU97029@...1296...>
References: <1494493257-8125-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1494493257-8125-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH (release/2.3)] Don't assert out on
 receiving too-large control packets (CVE-2017-7478)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Steffan Karger <steffan.karger@...1435...>
Cc: security@...515...

Hi,

On Thu, May 11, 2017 at 11:00:57AM +0200, Steffan Karger wrote:
> Commit 358f513c changed the maximum size of accepted control channel
> packets.  This was needed for crypto negotiation (which is needed for a
> nice transition to a new default cipher), but exposed a DoS
> vulnerability.  The vulnerability was found during the OpenVPN 2.4 code
> audit by Quarkslab (commisioned by OSTIF).
> 
> To fix the issue, we should not ASSERT() on external input (in this case
> the received packet size), but instead gracefully error out and drop the
> invalid packet.
> 
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  Changes.rst       | 5 +++++
>  src/openvpn/ssl.c | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 183e9fa..cc6ca2b 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -109,6 +109,11 @@ Version 2.3.15
>  
>  Security fixes
>  --------------
> +- Fix a pre-authentication denial-of-service attack on both clients and servers.
> +  By sending a too-large control packet, OpenVPN 2.3.12 and newer can be forced
> +  to hit an ASSERT() and stop the process.  If ``--tls-auth`` or ``--tls-crypt``
> +  is used, only attackers that have the ``--tls-auth`` or ``--tls-crypt`` key

When applying, please remove the "--tls-crypt" reference as 2.3 does not
have this (so it's confusing at best).

> +  can mount an attack. (OSTIF/Quarkslab audit finding 5.1, CVE-2017-7478)
>  - Fix an authenticated remote DoS vulnerability that could be triggered by
>    causing a packet id roll over.  An attack is rather inefficient; a peer
>    would need to get us to send at least about 196 GB of data.
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 32d0b6b..c8f093d 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -3228,7 +3228,12 @@ tls_pre_decrypt (struct tls_multi *multi,
>  			    /* Save incoming ciphertext packet to reliable buffer */
>  			    struct buffer *in = reliable_get_buf (ks->rec_reliable);
>  			    ASSERT (in);
> -			    ASSERT (buf_copy (in, buf));
> +			    if (!buf_copy (in, buf))
> +			      {
> +				msg (D_MULTI_DROPPED,
> +				     "Incoming control channel packet too big, dropping.");
> +				goto error;
> +			      }
>  			    reliable_mark_active_incoming (ks->rec_reliable, in, id, op);
>  			  }


ACK.  Same patch as in 2.4+master.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

