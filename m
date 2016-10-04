References: <1474732310-13672-1-git-send-email-lstipakov@...277...>
	<1474732449-13759-1-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2ad2231f-9e17-7709-b488-5ee201200f68@...1856...>
Date: Tue, 4 Oct 2016 18:47:04 +0200
MIME-Version: 1.0
In-Reply-To: <1474732449-13759-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH master] Exclude peer-id from pulled
 options digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 24-09-16 17:54, Lev Stipakov wrote:
> Peer-id might change on restart and this should not trigger reopening
> tun.
> 
> Trac #649

Feature-ACK.

The same holds for ncp stuff though, so I think we should do the same
for cipher, auth and keysize.  Unless those change the tun-mtu, hmm...
That might need further investigation, so maybe keep that separate from
the peer-id issue.

> +	      char line[OPTION_PARM_SIZE];
> +	      while (buf_parse (&buf_orig, ',', line, sizeof (line)))
> +		{
> +		  /* peer-id might change on restart and this should not trigger reopening tun */
> +		  if (strstr (line, "peer-id ") != line)
> +		    {
> +		      md_ctx_update (&c->c2.pulled_options_state, (const uint8_t *) line, strlen(line));
> +		    }
> +		}

This looks like it should be a separate (static) function
'push_update_digest(state, msg)', or something like that.

> +		    md_ctx_cleanup (&c->c2.pulled_options_state);

Are you sure?  I don't see a "-    md_ctx_cleanup (...)" in the patch
for master (there is in 2.3 though).  Do you fix a bug here, or is this
a cherry-picking mistake?

-Steffan

