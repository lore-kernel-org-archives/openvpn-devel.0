References: <b174d626-1cf3-3c85-c61c-34ad587c454e@...515...>
 <dd69acae-6d9f-938b-510a-69fe105ba531@...68...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <17975a99-5de5-cc4b-7136-c1466818b37b@...515...>
Date: Fri, 18 Jan 2019 10:17:12 +0200
MIME-Version: 1.0
In-Reply-To: <dd69acae-6d9f-938b-510a-69fe105ba531@...68...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Dropping Ubuntu 12.04 packages?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

Il 16/01/19 17:42, Matthias Andree ha scritto:
> Am 20.12.18 um 14:17 schrieb Samuli Seppänen:
>> Hi,
>>
>> I've worked on openvpn-vagrant and sbuild_wrapper recently[*] and
>> noticed that mainstream support for Debian 7 and Ubuntu 12.04 ended:
>>
>> https://wiki.debian.org/DebianReleases
>> https://wiki.ubuntu.com/Releases
>>
>> However, Ubuntu 12.04 is still under "Extended Security Maintenance",
>> meaning that a small subset of packages still receive security updates:
>>
>> https://wiki.ubuntu.com/SecurityTeam/ESM/12.04
>>
>> OpenVPN and OpenSSL are among the packages that Canonical still supports.
>>
>> The question is: do _we_ want to keep releasing OpenVPN packages for
>> Ubuntu 12.04?
> 
> Kill it, along with 14.04. <https://wiki.ubuntu.com/LTS>: "The LTS
> designation applies only to specific subsets of the Ubuntu archive." -
> and among those only a subset of packages, see
> <https://wiki.ubuntu.com/Releases>: "Packages in main and restricted are
> supported for 5 years in long term support (LTS) releases". You run
> universe packages, you lose, and for whatever "supported" means in a
> Ubuntu context.

Then Ubuntu 12.04 shall go. If won't have 2.4.x releases before April
2019 then Ubuntu 14.04 can go as well. I don't think packaging OpenVPN
2.5 for 14.04 would be useful anyways.

Samuli





