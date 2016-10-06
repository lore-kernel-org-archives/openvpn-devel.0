References: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
	<20161006121736.GB78279@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <50515770-ae2b-ee70-9ada-452f69cce800@...1227...>
Date: Thu, 6 Oct 2016 14:25:42 +0200
MIME-Version: 1.0
In-Reply-To: <20161006121736.GB78279@...1296...>
Subject: Re: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
 t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 06.10.16 um 14:17 schrieb Gert Doering:
> Hi,
>
> On Thu, Oct 06, 2016 at 01:02:57PM +0100, debbie10t wrote:
>> -R
>> Instead of using all-zeros as the packet data, generate random bytes. 
>> Use to defeat, e.g., link data compression
> -R is unlikely to have an effect here, as test 6 is run without
> compression anyway (to the contrary, it would *fail* your tests that
> succeed today due to compression :-) )
>
>
You just giving a good point to add -R anyway!

Arne

