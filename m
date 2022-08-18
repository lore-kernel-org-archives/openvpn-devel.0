Message-ID: <ea930e4b-9386-f000-0d7c-3e68c021b14d@...1227...>
Date: Thu, 18 Aug 2022 22:06:14 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
 <31c0b4fd-9adb-0a79-e959-4e2c892ae3f8@...2525...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <31c0b4fd-9adb-0a79-e959-4e2c892ae3f8@...2525...>
Subject: Re: [Openvpn-devel] wolfSSL unit test failures
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 18.08.22 um 17:21 schrieb Juliusz Sosinowicz:
> Hi Arne,
> 
> thank you for your report. In the future, please send reports to 
> support@...2525... to guarantee the fastest possible response. This 
> also helps us track bug reports. I have forwarded this report for you.
> 
> Either I or someone else will investigate this and get back to you with 
> a solution soon.
> 

To be honest, I do not really have interest in that. We ourselves do not 
use wolfSSL at all with OpenVPN and we included wolfSSL with the promise 
from wolfSSL (the company) that they will maintain the implementation 
for OpenVPN. I merely send this as a reminder to fix the current with 
wolfSSL so OpenVPN 2.6 can be released with wolfSSL support.

But if we have to spend time going through support requests and to keep 
something maintained that we ourselves have no intrinsic motivation to 
support, I will advocate to set/change the status of wolfSSL in OpenVPN 
to "unmaintained".

Arne

