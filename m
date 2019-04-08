References: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <bd3c0155-3558-6b2a-6562-da9a92df5496@...1147...>
Date: Mon, 8 Apr 2019 16:01:58 +0200
MIME-Version: 1.0
In-Reply-To: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] New tap-windows6 driver for Windows
 7/8/8.1/Server 2012r2 ready for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi Samuli,

On 05/04/19 16:00, Samuli Sepp=E4nen wrote:
> Hi,
>
> A new pre-release tap-windows6 driver (9.23.1) is available for testing.
> It should work on Windows 7/8/8.1/Server 2012r2. It _will not_ work  on
> Windows 10 or Windows Server 2016/2019.
>
> The driver includes several new features such as support for NDIS 6.30
> arm64 support, improvements in driver version display, etc.
>
> Download the installer from here:
>
> https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1-I601.exe
>
> For those who want the raw, signed driver files please download the zip
> file:
>
> https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1.zip
>
> I install-tested driver on Windows Server 2012r2 and there were no
> obvious problems.
>
> It would be great if other people could smoke-test the new driver - just
> install it on top of existing OpenVPN installation. In particular
> running OpenVPN with the driver would be useful.
>
I've installed the driver on my Win 7 Pro laptop and it installed and=20
runs just fine.
I also ran some performance tests and it seems the performance=20
characteristics have changed a bit:
iperf download speeds are reported higher (195 Mbps vs 150 Mbps) as long=20
as you don't specify any tuning options. Funnily enough you need to=20
specify these options if you want to get full performance on a regular=20
Ethernet interface (in which case I get 930 Mbps).

cheers,

JJK

