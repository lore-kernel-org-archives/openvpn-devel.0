References: <20161201065534.15050-1-a@...2181...>
	<631a86a3-e0f3-4391-2241-16848ce9c686@...1856...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <56536b18-a291-b0e2-25b8-60d6fa5fe76b@...1435...>
Date: Thu, 1 Dec 2016 11:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <631a86a3-e0f3-4391-2241-16848ce9c686@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] reload CRL only if file was modified
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 01-12-16 09:13, Steffan Karger wrote:
>   else if (0 != platform_stat(crl_file, &crl_stat))
>     {
>       msg (M_WARN, "WARNING: Failed to stat CRL file, using cached CRL.");
>     }

Ahum, as Gert noted on IRC, this missed a return statement to actually
*not* load the CRL.  So, better suggestion:

  else if (platform_stat(crl_file, &crl_stat) < 0)
    {
      msg (M_WARN, "WARNING: Failed to stat CRL file, using (re)loading
CRL.");
      return;
    }

-Steffan

