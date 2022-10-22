Mime-Version: 1.0
Message-Id: <11858130-7897-4996-9823-0723391def47@...2702...>
In-Reply-To: <30459709-4f14-5f76-072d-24cbc75ac0eb@...2181...>
References: <8f4f2e11-6418-58ac-0fd5-f9a19450102a@...2181...>
 <20221022083842.4093941-1-git@...2701...>
 <30459709-4f14-5f76-072d-24cbc75ac0eb@...2181...>
Date: Sat, 22 Oct 2022 21:53:20 +0000
From: "John Thomson" <git@...2701...>
Subject: Re: [Openvpn-devel] [PATCH v2] ovpn-dco: fix kernel 6.1 compile
 issue in ovpn_peer_create
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On Sat, 22 Oct 2022, at 13:38, Antonio Quartulli wrote:
> Hi,
>
> On 22/10/2022 10:38, John Thomson wrote:
>> Linux 5.19 replaces netif_tx_napi_add, but maintains a definition to the
>> new function in: 58caed3dacb4 ("netdev: reshuffle netif_napi_add() APIs
>> to allow dropping weigh") [0]
>>=20
>> Linux 6.1 removes netif_tx_napi_add in c3f760ef1287 ("net: remove
>> netif_tx_napi_add()") [1]
>>=20
>> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D58caed3dacb4354a25a1aa8d2febc3e9648ba1f4
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dc3f760ef128789252e7c4f10d3c1721422dceba9
>>=20
>> Signed-off-by: John Thomson <git@...2701...>
>
> Thanks a lot for this!
> Your patch has been applied to the master branch with a few minor style=20
> fixes.

Thank you for the help and quick turnaround.
I really should have found all the #if LINUX_VERSION_CODE in linux-compat m=
yself the first time=E2=80=A6 Sorry

>
>> ---
>> v2: Do not throw ifdefs into the middle of the code
>>=20
>> compile tested only: openwrt toolchain aarch64: kernel v6.1rc1, kernel 5=
.10
>
> Out of curiosity: are you using the openvpn-dev feed for openwqrt?=20
> (https://github.com/OpenVPN/openvpn-dev-openwrt)

Not yet, only just learned of it.
I was walking through building all the Openwrt kernel modules with kernel 6=
.1rc1 and came across ovpn-dco in the Openwrt packages feed.


Cheers,

--=20
  John Thomson

