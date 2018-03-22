MIME-Version: 1.0
In-Reply-To: <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Mar 2018 13:12:17 -0400
Message-ID: <CAKuzo_gx7Y28dtT+85HtSkKMh_UMU_+ZmbPV7-CLtLSrRP6mag@...278...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: Eric Thorpe <eric@...1918...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Mar 22, 2018 at 12:16 PM, Jan Just Keijser <janjust@...1147...> wrote:
> Hi Eric, all,
>
> On 22/03/18 04:25, Eric Thorpe wrote:
>
> Hi All,
>
> One of the Viscosity developers here. The TAP driver used by Viscosity is
> based on the OpenVPN TAP-Windows driver. We're surprised to hear of any
> performance differences, as the changes we've made are very minimal.
>
> Besides a name and version number change, the only other modification is a
> change to the reported network adapter speed, which has Windows report the
> driver as 1000 Mbit instead of 100 Mbit.
>
> This change was made not because of any actual performance gains, but
> because of user reports that certain firewall or AV software tries to QoS
> the adapter based on its reported adapter speed, which is of course a
> problem if the VPN connection is capable of more than 100 Mbit.
>
> Please find a patch file of the changes attached.
>
>
> first of all, thanks for responding so quickly.
> I've done some further testing with Viscosity 1.6.8 (openvpn 2.3.14 based)
> compared to OpenVPN 2.4.5 and I am seeing a performance difference in a
> gigabit test setup.  Strangely enough, it turns out that it's the *absence
> of* AES256-GCM that makes my Viscosity client faster.
> My test setup is as follows:
>
> - server: CentOS 7, openvpn 2.4.4, gigabit ethernet
> - client: Win7 Pro, gigabit ethernet:
>
> Speeds (using "iperf -s" and "iperf -c 10.200.0.1 -r -l 4M -t 30"):
>
> viscosity:
> 380 Mbps +/- 10 Mbps to server
> 100 Mbps +/- 5 Mpbs from server
>
> Openvpn 2.4.5  --ncp-disable --cipher aes-256-cbc --auth sha256
> 377 Mbps +/- 10 Mbps to server
>   99 Mbps +/- 5 Mpbs from server
>
> Openvpn 2.4.5 (aes256-gcm)
>  240 Mbps +/- 8 Mbps to server
>   55 Mbps +/- 5 Mpbs from server
>
> So strangely enough it seems that AES-256-GCM is **slower** for Windows
> clients. Note that in this setup the server config never changed.

I haven't tested openvpn itself but have noticed in openssl speed
tests that AES-256-CBC is significantly faster than AES-256-GCM on
Windows (opposite to Linux). That was with openssl 1.0.x, probably
1.1.0 is similar (2.4.5 Windows release is built with 1.1.0).

However, the raw cipher speeds are much larger than these throughputs
so its surprising that the change of cipher alone makes such a
difference.

Why is the throughput so asymmetric?

Selva

