References: <20161129063843.14526-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <a387ba70-4c39-5fb6-e14e-34f380a388e5@...1856...>
Date: Tue, 29 Nov 2016 20:40:11 +0100
MIME-Version: 1.0
In-Reply-To: <20161129063843.14526-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

One more thing.

On 29-11-16 07:38, Antonio Quartulli wrote:
> +  if (!crl_file_inline)
> +    platform_stat(crl_file, &crl_stat);

If platform_stat() fails, we now silently ignore the error and continue
using the old CRL.  I think using the old CRL is fine, but we should
print a warning to tell the user so:

  if (!crl_file_inline && 0 != platform_stat(crl_file, &crl_stat))
    msg (M_WARN, "WARNING: Failed to stat CRL file, using cached CRL.");

-Steffan

