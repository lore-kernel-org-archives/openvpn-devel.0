MIME-Version: 1.0
References: <CAAUX2SXYyxz-A_cWsf+ZuCyPkHz_O+D+fdZNS2p_7qV6fDR4EA@...278...>
 <581cf124-143b-690c-37d2-72fb2bd0e39a@...277...>
In-Reply-To: <581cf124-143b-690c-37d2-72fb2bd0e39a@...277...>
From: Tony He <huangya90@...277...>
Date: Tue, 5 Apr 2022 21:04:11 +0800
Message-ID: <CAAUX2SXzyFLZmPCC0ruV9BYxEoEnJs41zRFw3hbVDypKQdFJxQ@...278...>
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
To: Jan Just Keijser <jan.just.keijser@...277...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi JJK,

Yeah, I know this way, but there is still context switching in the
kernel space and user space. I have been looking for a way
to benchmark in the kernel space. I expect there is a kernel module like be=
low:

insmod benchmark.ko AES-256-GCM
(After it's done,  this module will exit automatically)

Tony

Jan Just Keijser <jan.just.keijser@...277...> =E4=BA=8E2022=E5=B9=B44=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=BA=8C 19:26=E5=86=99=E9=81=93=EF=BC=9A
>
> hi Tony,
>
> On 02/04/22 11:40, Tony He wrote:
> > Hi Antonio,
> >
> > I am porting ovpn-dco to embedded ARMv8 device with hardware crypto
> > engine. However the performance is not very good.
> > It's about 130-140Mbps. I expect more. The SDK already provides kernel
> > CryptoAPI(CFI) interface  to access the crypto engine.
> > I want to know if the crypto operation is the bottleneck. Do you know
> > how to benchmark crypto performance in the kernel space?
> > Any advice is welcome. Thank you!
> >
> a quick & dirty way to test the hardware crypto engine is to use the
> Linux cryptodev engine in combination with openssl ; it's a bit tricky
> to get it working but it *is* a nice way to test hardware crypto.
>
> * https://github.com/cryptodev-linux/cryptodev-linux.git
> * do a custom openssl build with
>      ./Configure -DHAVE_CRYPTODEV -DUSE_CRYPTODEV_DIGESTS enable-engine
> enable-dso enable-devcryptoeng <platform>
> * run openssl speed using
>    ./openssl speed -elapsed -engine devcrypto -evp aes-128-cbc
>
> and compare the results with "-engine devcrypto" removed.
>
> HTH,
>
> JJK
>
>
>

