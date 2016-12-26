References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
	<20161226080538.GU78624@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fc8c1bf4-7dae-842b-47d2-214cc8a82c69@...1227...>
Date: Mon, 26 Dec 2016 09:41:00 +0000
MIME-Version: 1.0
In-Reply-To: <20161226080538.GU78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
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
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Am 26.12.16 um 08:05 schrieb Gert Doering:
> Hi,
> 
> On Mon, Dec 26, 2016 at 12:20:53AM +0100, Steffan Karger wrote:
>> The oldest OpenSSL we support in release/2.4 and master is 0.9.8, and
>> has SHA256 support (was introduced in 2004).  Also, the --tls-crypt
>> feature already unconditionally requires SHA256 to be available.
> 
> Good enough for me.  
> 
> Have to look more closely at the actual patch, though :)
> 
> As for "build on MacOS", I seem to remember from plaisthos' buildslave
> that we cannot currently build on an "unmodified" MacOS anyway, but have
> to install a more recent (or more complete?) OpenSSL beforehand - so 
> that particular ship has sailed.


There are no OpenSSL header files available for OpenSSL. So building
against that system version is harder than installing a new version.

Arne


