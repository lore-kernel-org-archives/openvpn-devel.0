Message-ID: <5593FDEE.3010809@...1147...>
Date: Wed, 01 Jul 2015 16:49:18 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>	<5593EBF6.4060203@...1114...>	<1896EA4F53C84141B287C36403D7DE21@...1853...>
	<20150701144158.GD382@...1296...>
In-Reply-To: <20150701144158.GD382@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 01/07/15 16:41, Gert Doering wrote:
> Hi,
>
> On Wed, Jul 01, 2015 at 03:05:44PM +0100, debbie10t@...277... wrote:
>> Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.1.12,
>> 104.28.0.12
>> Connecting to swupdate.openvpn.org
>> (swupdate.openvpn.org)|104.28.1.12|:443... connected.
>
> Something interesting is going on.  I thought it might be related to
> the two different IP addresses, and maybe one has the file and one
> does not - but it works for both from here...
>
> Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.0.12|:443... connected.
> openvpn-install-2.3 100%[=====================>]   1.72M  1.06MB/s   in 1.6s
>
> Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.1.12|:443... connected.
> openvpn-install-2.3 100%[=====================>]   1.72M  1.04MB/s   in 1.6s
>
> funny.
>
> Samuli, can you investigate?
>
I'm getting something else entirely:

from EL5:

Resolving swupdate.openvpn.org... 104.28.1.12, 104.28.0.12
Connecting to swupdate.openvpn.org|104.28.1.12|:443... connected.
OpenSSL: error:14077438:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert 
internal error
Unable to establish SSL connection.


from EL6 it just works


JJK


