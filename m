Message-ID: <4BD852E3.5040104@...1114...>
Date: Wed, 28 Apr 2010 17:23:15 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
	<1272466514-18866-4-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-4-git-send-email-fabian.knittel@...1338...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] vlan: slightly clean-up
	buf_filter_incoming_vlan_tags()
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
To: Fabian Knittel <fabian.knittel@...1338...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/04/10 16:55, Fabian Knittel wrote:
> This patch changes buf_filter_incoming_vlan_tags() to use a less nested
> code-style.  It also improves documentation of the function.
> 
> In addition, the function is made static, as it is only used locally.
> 
> Code based on a snippet by Peter Stuge.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
> ---
>  multi.c |   39 ++++++++++++++++++++++++---------------
>  1 files changed, 24 insertions(+), 15 deletions(-)

I see absolutely no reasons why we shouldn't write easily readable code,
thus I'm giving this patch an ACK.

Usage of nesting should not be considered a part of any coding style,
it's more about writing readable code.  And code which is more difficult
to read, is more easily prune to bugs.


kind regards,

David Sommerseth



> diff --git a/multi.c b/multi.c
> index 1a8bbbf..83c5aa3 100644
> --- a/multi.c
> +++ b/multi.c
> @@ -1925,24 +1925,33 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
>  }
>  
>  #ifdef ENABLE_VLAN_TAGGING
> -bool
> +/*
> + * Decides whether or not to drop an ethernet frame.  VLAN-tagged frames are
> + * dropped.  All other frames are accepted.
> + *
> + * @param buf The ethernet frame.
> + * @return    Returns true if the frame should be dropped, false otherwise.
> + */
> +static bool
>  buf_filter_incoming_vlan_tags (const struct buffer *buf)
>  {
> -  if (BLEN (buf) >= (int) sizeof (struct openvpn_8021qhdr))
> -    {
> -      const struct openvpn_8021qhdr *vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
> +  const struct openvpn_8021qhdr *vlanhdr;
> +  uint16_t vid;
>  
> -      if (ntohs (vlanhdr->tpid) == OPENVPN_ETH_P_8021Q)
> -        {
> -	  const uint16_t vid = vlanhdr_get_vid(vlanhdr);
> -	  if (vid != 0)
> -	    {
> -	      msg (D_VLAN_DEBUG, "dropping tagged incoming frame, vid: %u", vid);
> -	      return true;
> -	    }
> -	}
> -    }
> -  return false;
> +  if (BLEN (buf) < (int) sizeof (struct openvpn_8021qhdr))
> +    return false; /* Frame too small.  */
> +
> +  vlanhdr = (const struct openvpn_8021qhdr *) BPTR (buf);
> +
> +  if (ntohs (vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
> +    return false; /* Frame is untagged.  */
> +
> +  vid = vlanhdr_get_vid(vlanhdr);
> +  if (vid == 0)
> +    return false; /* Frame only priority-tagged.  */
> +
> +  msg (D_VLAN_DEBUG, "dropping VLAN-tagged incoming frame, vid: %u", vid);
> +  return true;
>  }
>  #endif
>  

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYUt8ACgkQDC186MBRfro4PACgnle/89mrJEQrhEpcVT5iBWfB
fq4AnibsHY2G5XBezR/lluwz1fM865Kn
=09Oe
-----END PGP SIGNATURE-----

