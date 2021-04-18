References: <dcd5b87c-6a68-a191-dae9-cc35ecb99b65@...2181...>
 <20210415091248.18149-1-maximilian.fillinger@...2507...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <64fd6c2d-91e6-a2dd-747d-cfde76275d1e@...2181...>
Date: Sun, 18 Apr 2021 17:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <20210415091248.18149-1-maximilian.fillinger@...2507...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] In init_ssl,
 open the correct CRL path pre-chroot
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

On 15/04/2021 11:12, Max Fillinger wrote:
> When using the chroot option, the init_ssl function can be called before
> entering the chroot or, when OpenVPN receives a SIGHUP, afterwards. This
> commit ensures that OpenVPN tries to open the correct path for the CRL
> file in either situation.
> 
> This commit does not address key and certificate files. For these, the
> --persist-key option should be used.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

Compile tested against my zoo of SSL libraries and got no complaint.
GitLab CI did not complain either.

I reproduced the bug by having the file reachable by the option parser
(chroot+crl_path), but unreachable by the first run of init_ssl() (no
chroot included in the path here).


I could see that this patch addresses this issue and prevent the first
init_ssl() from failing.

Subsequent CRL reloads also work as expected.

Acked-by: Antonio Quartulli <antonio@...515...>

Being this a bugfix for chroot, it should be merged to 2.5 too, if possible.

Regards,



-- 
Antonio Quartulli

