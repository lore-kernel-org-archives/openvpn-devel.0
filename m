References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-2-arne@...1227...>
 <f16a3c68-89c0-c9a9-5a36-272979b8e95e@...2181...>
 <20210406205120.GG976@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f9b82849-f9b3-bf84-705b-e2ca34717409@...2080...>
Date: Tue, 13 Apr 2021 14:46:45 +0200
MIME-Version: 1.0
In-Reply-To: <20210406205120.GG976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/5] Remove checks for uint* types that
 are part of C99
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

On 06/04/2021 22:51, Gert Doering wrote:
> Hi,
> 
> On Tue, Apr 06, 2021 at 10:39:59PM +0200, Antonio Quartulli wrote:
>> Gert should be able to test on *more ancient things* that we still support.
> 
> Hardly :-) - David maintains the software museum.
> 
> My oldest machine is FreeBSD 7.4, which has been EOLed since like
> ages, and even that one has <inttypes.h> and <stdint.h>...

FreeBSD 7.4 is the software museum [0] ;-)  RHEL-7.0 was released 15 
months _after_ FreeBSD 7.4.  RHEL-7 is oldest the supported Linux distro 
we officially support in OpenVPN, and it gets updates from Red Hat until 
June 20204 [1].  RHEL-7 is fully C99 capable.

[0] <https://endoflife.software/operating-systems/linux/FreeBSD>
[1] 
<https://endoflife.software/operating-systems/linux/red-hat-enterprise-linux-rhel#7>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


