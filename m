References: <1444400025-22289-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5643AC41.6090501@...1856...>
Date: Wed, 11 Nov 2015 21:59:45 +0100
MIME-Version: 1.0
In-Reply-To: <1444400025-22289-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Support for disabled peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

The patch looks functionally ok.  Just one minor remark:

On 09-10-15 16:13, Lev Stipakov wrote:
> @@ -103,10 +107,14 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
>   		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
>   		      mi->did_real_hash = true;
>
> +		      /* In future we might want to use P_DATA_V2 but not need peer-id/float functionality */
>   		      for (i = 0; i < m->max_clients; ++i)
>   			{
>   			  if (!m->instances[i])
>   			    {
> +			      /* issued peer-id should fit into 3 bytes to avoid wrap and cannot have reserved value 0xFFFFFF */
> +			      ASSERT(i < 0xFFFFFF);
> +
>   			      mi->context.c2.tls_multi->peer_id = i;
>   			      m->instances[i] = mi;
>   			      break;

Checking against the max peer-id indeed makes sense, but this assert can 
be made simpler by just putting

    ASSERT (m->max-clients < 0xFFFFFF);

before the loop.  Additionally, I think we should add a user-friendly 
check in options.c, to give a proper error message on startup when a 
user tries to set --max-clients >= 0xFFFFFF.

Finally, why did you put this comment at this location?  Shouldn't it be 
in the place where we *send* the peer-id?  (That is the part that is not 
implemented now, right?)

-Steffan

