Message-ID: <dbb88584-ebba-dafb-d32f-cc35b0e95f9b@...2080...>
Date: Thu, 1 Sep 2022 15:14:54 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
 <31c0b4fd-9adb-0a79-e959-4e2c892ae3f8@...2525...>
 <ea930e4b-9386-f000-0d7c-3e68c021b14d@...1227...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <ea930e4b-9386-f000-0d7c-3e68c021b14d@...1227...>
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

On 18/08/2022 22:06, Arne Schwabe wrote:
> 
> But if we have to spend time going through support requests and to keep 
> something maintained that we ourselves have no intrinsic motivation to 
> support, I will advocate to set/change the status of wolfSSL in OpenVPN 
> to "unmaintained".

Agreed.

If wolfSSL support is expected to work in OpenVPN, those interested in 
wolfSSL need to be far more active and follow the OpenVPN development to 
ensure the support still functions and performs as expected.

The wolfSSL support has so far had quite little impact on growing the 
OpenVPN user or development base, so there is little motivation or even 
reasons for the OpenVPN community to take ownership of this.  Don't 
expect the wolfSSL support to be tested much at all by the community 
developers.  On the other side, we do see that wolfSSL has more a 
benefit of slamming the "works with OpenVPN" label on wolfSSL.  But 
don't count on the OpenVPN community doing the grunt work for wolfSSL.

Either be more actively involved - or accept we will move it to an 
unmaintained status - plausibly removing it if it stays broken for a 
longer time.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


