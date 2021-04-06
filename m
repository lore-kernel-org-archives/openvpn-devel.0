References: <E1lSJph-0004I0-FL@...2479...>
 <8b081dd5-2c1d-c71b-8af0-d4c886e4260e@...1227...>
 <E1lTjOz-0003I1-MM@...2479...>
 <20210406111429.GY976@...1296...>
 <4053ef1e-e0f3-2355-488e-49ee378959c7@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <68526595-bde0-8d04-18d4-5058b5a0f9bf@...1227...>
Date: Tue, 6 Apr 2021 18:31:37 +0200
MIME-Version: 1.0
In-Reply-To: <4053ef1e-e0f3-2355-488e-49ee378959c7@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Change CTR DRBG update function call to
 new mbedtls 2.16.0 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, Gert Doering <gert@...1296...>, Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.04.21 um 13:51 schrieb Antonio Quartulli:
> Hi,
> 
> On 06/04/2021 13:14, Gert Doering wrote:
>> Now... what *is* the oldest mbedtls version we should reasonably support?
>>
>> For OpenSSL, we're stuck to 1.0.2 for the time being as that's still
>> the primary (and bugfix-backported) version on FreeBSD 11 and on RHEL
>> versions still supported.  For mbedTLS I have no idea.
> 
> Good question. I was wondering the same.
> 
> Debian 10 (stable) is on mbedtls-2.16.0
> CentOS 8 is on mbedtls-2.16.9
> Fedora EPEL 8 (and up to Fedora 35) is on mbedtls-2.16.9
> 
> ** Ubuntu 18.04 is on mbedtls-2.8.0 **
> Ubuntu 20.04 is on mbedtls-2.16.4
> 
> At this point I believe that assuming mbedtls >= 2.16.0 is meaningful.
> 
> Distros shipping something older are probably not going to ship a recent
> OpenVPN either.
> 
> Opinions?
> 

If we adjust the minimum mbed TLS version we should also change the
check in configure.ac that checks for the minimum version as well.

mbed TLS 2.16.0 has been released end of 2018, so that version is "only"
a bit over two years old. Currently mbed TLS 2.7 is still a supported
LTS release, so if it is not too much effort, I think we should still
support it.

Arne

