References: <4743b2e0-89bf-29f9-f406-867d35c9bb1d@...2181...>
 <20210415093454.18324-1-maximilian.fillinger@...2507...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <674c4226-6ed6-bfe4-a01a-0030d5ae2b18@...2181...>
Date: Sun, 18 Apr 2021 21:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <20210415093454.18324-1-maximilian.fillinger@...2507...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] Abort if CRL file can't be
 stat-ed in ssl_init
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Hi,

On 15/04/2021 11:34, Max Fillinger wrote:
> Now that the path for the CRL file is handled correctly when using
> chroot, there's no good reason for the file to be inaccessible during
> ssl_init().
> 
> This commit ensures that the CRL file is accessed successfully at least
> once, which fixes a bug where the mbedtls version of OpenVPN wouldn't
> use a reloaded CRL if it initially failed to access the file.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

It simply does what it says: when calling init_ssl() upon instance
initialization (i.e. upon openvpn startup, and upon USR1 on clients) if
the CRL is not accessible, then openvpn will abort.

This behaviour is what we need because "starting an instance without
having the CRL where it is expected" is equivalent to a configuration error.

Being unable to re-load the CRL at runtime is instead acceptable,
because some subsystem might be just recreating the CRL, therefore
openvpn will skip the reload and continue using what is currently in
memory. The CRL will be reloaded at the next occasion.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

