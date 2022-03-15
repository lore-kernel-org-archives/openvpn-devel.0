Message-ID: <a4e4d381-80a8-4f80-62ec-a7d9f12c1a1f@...2181...>
Date: Tue, 15 Mar 2022 16:11:25 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220313193154.9350-1-openvpn@...2080...>
 <20220313193154.9350-3-openvpn@...2080...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220313193154.9350-3-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/3] plug-ins: Disallow multiple
 deferred authentication plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/03/2022 20:31, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
> 
> The plug-in API in OpenVPN 2.x is not designed for running multiple
> deferred authentication processes in parallel. The authentication
> results of such configurations are not to be trusted.  For now we bail
> out when this discovered with an error in the log.
> 
> CVE: 2022-0547
> Signed-off-by: David Sommerseth <davids@...515...>

Same as the patch for master.

Acked-by: Antonio Quartulli <a@...2181...>


> +                        error = true;
> +                        msg(M_FATAL,
> +                            "Exiting due to multiple authentication plug-ins "
> +                            "performing deferred authentication. Only one "
> +                            "authentication plug-in doing deferred auth is "
> +                            "allowed.  Ignoring the result and stopping now, "
> +                            "the current authentication result is not to be "
> +                            "trusted.");

Frank reported that we should use double space after the full-stop. 
Honestly I'd prefer just single-space everywhere as it is more 
"traditional".

This said, Gert can make the final decision and modify the patch on the fly.

Cheers,


-- 
Antonio Quartulli

