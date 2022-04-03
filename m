MIME-Version: 1.0
References: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
In-Reply-To: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
From: Tony He <huangya90@...277...>
Date: Sun, 3 Apr 2022 10:44:56 +0800
Message-ID: <CAAUX2SW-ZR3WcCLsoY=m-b5rKFpyXF51M43k_c7rjYDzTLphKw@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] How to benchmark kernel crypto
 performance?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I used below ugly way to benchmark the performance roughly. In POC,
confirmed the hardware crypto engine is the bottleneck and  not very
fast
for packet not over than 1500 bytes. Overhead is required for queuing
the data to crypto engine and sending data back to kernel.

        ktime_get_real_ts64(&init_time);
        ret =3D crypto_wait_req(crypto_aead_encrypt(req), &wait);
        ktime_get_real_ts64(&comp_time);

        init_usecs  =3D (init_time.tv_sec * 1000 * 1000) +
(init_time.tv_nsec / 1000);
        comp_usecs  =3D (comp_time.tv_sec * 1000 * 1000) +
(comp_time.tv_nsec / 1000);
        delta_usecs +=3D comp_usecs - init_usecs;

        total_size +=3D skb->len - head_size;
        if(total_size > 100000000){
                mbits =3D total_size * 8;
                printk("total_size is %u bytes, time is %u, the rate
is %u\n", total_size, delta_usecs,  mbits/delta_usecs);
                total_size =3D 0;
                delta_usecs =3D 0;
        }

......
......
Tony

Tony He <huangya90@...277...> =E4=BA=8E2022=E5=B9=B44=E6=9C=882=E6=97=A5=E5=
=91=A8=E5=85=AD 17:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Antonio,
>
> I am porting ovpn-dco to embedded ARMv8 device with hardware crypto
> engine. However the performance is not very good.
> It's about 130-140Mbps. I expect more. The SDK already provides kernel
> CryptoAPI(CFI) interface  to access the crypto engine.
> I want to know if the crypto operation is the bottleneck. Do you know
> how to benchmark crypto performance in the kernel space?
> Any advice is welcome. Thank you!
>
> Tony

