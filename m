Message-ID: <04763daecd4acd7f6c5bf9ed1781ee37.squirrel@...2257...>
In-Reply-To: <20180301112353.GX69387@...1296...>
References: <52e860ea74ac958309368374049f14bd.squirrel@...2257...>
 <20180301112353.GX69387@...1296...>
Date: Thu, 1 Mar 2018 15:32:52 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] tls fix for upcoming 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Thu, Mar 01, 2018 at 12:14:06PM +0100, Simon Matter wrote:
>> I've just done some test builds with 2.4.5 tagged version.
>>
>> Attached patch makes it build with older systems. Do you see any issue
>> with the change?
>
> Which SSL library version needs this?
>
> (I thought we have test systems for everything we officially support, plus
> a few more to catch avoidable LibreSSL breakage etc)

I saw that the #ifdefs were forgotten there, because they exist in other
places of the same file but didn't make it into the separate more recent
commit.

Anyway, it's for RHEL5, which is still supported for RedHat customers or
CERN Linux 5 users (SLC5).

I know OpenVPN officially doesn't care for it anymore but I do :-)

Regards,
Simon


