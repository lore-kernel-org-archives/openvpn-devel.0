References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
 <CAKuzo_gx7Y28dtT+85HtSkKMh_UMU_+ZmbPV7-CLtLSrRP6mag@...278...>
 <7c8cb31e-13be-d4d2-7833-5503d1b385c8@...1147...>
 <02c60a84-e208-d4a4-491f-d18a2dab2934@...277...>
 <6d800e7a-1e75-dfbc-6cd0-f9ee948a8a4b@...277...>
 <80f0084c-0dde-317d-34bf-bd02d056a055@...277...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <f9cd5d15-3e76-acc3-3839-1d1f1304ee4a@...1147...>
Date: Fri, 30 Mar 2018 00:05:38 +0200
MIME-Version: 1.0
In-Reply-To: <80f0084c-0dde-317d-34bf-bd02d056a055@...277...>
Subject: Re: [Openvpn-devel] aes-gcm and iperf on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: fragmentux <fragmentux@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

(renamed the topic to reflect what it's about)

On 27/03/18 01:09, fragmentux wrote:
> I am not convinced 'iperf -r' is reliable (bold claim maybe .. )
>
> iperf3 have dropped -r in favour of -R "reverse mode"
> server sends and client receives. but not both on the same run ..
>
> After numerous hangs and some bazaar results with iperf2
> i opted to upgrade to iperf3 .. still some slightly odd results
> but no hangs so far ..
>
I've measured it with 'iperf -s' on Win7 and get the same results.
Important difference: with the Cygwin version of iperf I get a 240 Mbps 
/ 50 Mbps
With the Win32 version (v2.0.8) i get 330 / 100 Mbps (plus or minus 5 %)

The asymmetry is caused by the hardware used - if I use two Linux 
servers I also see asymmetry, as I am pushing the CPU of one of the 
Linux boxen a bit. The difference of my laptop running Linux vs running 
Win 7 is quite huge, however: on Linux I am getting well above 600 Mbps 
both ways.

cheers,

JJK


